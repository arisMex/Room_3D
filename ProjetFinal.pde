/*
 * Salle de TP en 3D — Processing (P3D)
 *
 * Toute la géométrie statique est fusionnée par MeshBuilder en un lot par
 * matériau : la scène complète se dessine en quelques dizaines d'appels.
 *
 * Commandes : ZQSD / WASD / flèches = se déplacer, souris (glisser) = tourner,
 * Espace / Ctrl = monter / descendre, Maj = courir, clic droit ou L = lumière,
 * + / - = luminosité, H = aide, R = réinitialiser la caméra, P = capture d'écran.
 *
 * Mode capture (régénère les images du README) :
 *   processing-java --sketch=<dossier> --run --capture
 */

// Dimensions de la salle (cm) : x = largeur, y = hauteur (vers le bas), z = longueur.
// Le sol est en y = 0, le plafond en y = -HAUTEUR.
final float LARGEUR = 594;
final float LONGUEUR = 978;
final float HAUTEUR = 278;
final float EP_MUR = 10;

Textures textures;
Materiaux mat;
Eclairage eclairage;
CameraFPS cam;
PShader shaderScene;

PShape scene;          // géométrie statique fusionnée
PImage imgChargement;

boolean afficherAide = true;
float exposition = 1.0;   // luminosité globale, réglable avec + / -
boolean modeCapture = false;
int etapeCapture = 0;

void settings() {
  modeCapture = args != null && java.util.Arrays.asList(args).contains("--capture");
  if (modeCapture) size(1920, 1080, P3D);
  else size(1280, 720, P3D);
  smooth(8);
  PJOGL.setIcon("Data/images/tableau.png");
}

void setup() {
  surface.setTitle("Salle de TP 3D");
  imgChargement = loadImage("Data/images/loading.gif");
  frameRate(60);
}

// La première image affiche l'écran de chargement, la scène est construite à la seconde.
boolean initialise = false;

void initialiser() {
  randomSeed(7);
  textureMode(NORMAL);
  textureWrap(REPEAT);
  ((PGraphicsOpenGL) g).textureSampling(5); // trilinéaire

  textures = new Textures();
  mat = new Materiaux(textures);
  eclairage = new Eclairage();
  cam = new CameraFPS();

  shaderScene = loadShader("Data/shaders/eclairage.frag", "Data/shaders/eclairage.vert");

  int t0 = millis();
  MeshBuilder mb = new MeshBuilder();
  new Salle().construire(mb);
  scene = mb.build();
  println("Scène : " + mb.nbFaces + " faces, " + scene.getChildCount()
    + " lots (" + (millis() - t0) + " ms)");
  initialise = true;
}

void draw() {
  if (!initialise) {
    if (frameCount == 1) {
      background(0);
      imageMode(CENTER);
      image(imgChargement, width/2, height/2, height * 4/3.0, height);
      return;
    }
    initialiser();
  }

  if (modeCapture) preparerCapture(etapeCapture);
  else cam.mettreAJour(1.0 / max(frameRate, 1));

  background(18);
  cam.appliquer();
  eclairage.appliquer();

  shader(shaderScene);
  shaderScene.set("exposition", exposition);
  shaderScene.set("resolution", (float) width, (float) height);
  shape(scene);
  shape(eclairage.plafonniers());
  resetShader();

  if (modeCapture) {
    if (terminerCapture(etapeCapture)) etapeCapture++;
    return;
  }
  if (afficherAide) dessinerAide();
}

void dessinerAide() {
  hint(DISABLE_DEPTH_TEST);
  noLights();
  camera();
  perspective();
  noStroke();
  fill(0, 160);
  rect(12, 12, 310, 186, 8);
  fill(255);
  textSize(13);
  textAlign(LEFT, TOP);
  text("ZQSD / WASD / flèches : se déplacer\n"
    + "Souris (glisser) : tourner\n"
    + "Espace / Ctrl : monter / descendre\n"
    + "Maj : courir   Molette : avancer/reculer\n"
    + "Ctrl + molette : zoom\n"
    + "Clic droit / L : lumière " + (eclairage.allume ? "(allumée)" : "(éteinte)") + "\n"
    + "+ / - : luminosité (" + nf(exposition * 100, 0, 0) + " %)\n"
    + "P : capture   R : reset   H : masquer l'aide\n"
    + nf(frameRate, 0, 0) + " FPS", 24, 22);
  hint(ENABLE_DEPTH_TEST);
}

void mousePressed() {
  if (mouseButton == RIGHT && eclairage != null) eclairage.basculer();
}

void mouseDragged() {
  if (cam != null && mouseButton == LEFT) cam.tourner(mouseX - pmouseX, mouseY - pmouseY);
}

// Molette : avancer / reculer. Ctrl + molette : zoom (champ de vision).
void mouseWheel(MouseEvent ev) {
  if (cam == null) return;
  if (ev.isControlDown()) cam.zoomer(ev.getCount());
  else cam.avancerMolette(-ev.getCount());
}

void keyPressed() {
  if (cam == null) return;
  cam.touche(key, keyCode, true);
  char k = Character.toLowerCase(key);
  if (k == 'l') eclairage.basculer();
  else if (k == 'h') afficherAide = !afficherAide;
  else if (k == 'r') cam.reinitialiser();
  else if (k == 'p') saveFrame("captures/capture-####.png");
  else if (k == '+' || k == '=') exposition = min(exposition + 0.1, 2.0);
  else if (k == '-') exposition = max(exposition - 0.1, 0.3);
}

void keyReleased() {
  if (cam != null) cam.touche(key, keyCode, false);
}
