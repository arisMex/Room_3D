PShape salle;


PShader colorShader;
PShader[] shaders;
PImage tex, texTable, texSol, texPlafond, texTbleau, texTbleauMil, texPorte, texUcFace, texMac, texUcDos, texUcCote, texClavier, textureChaise, texDosEcran, texPlinthe, texExtr, texSouris, texRadiateur;
PImage[] fondEcran;
Light light;

float rayon = 200;
float theta = 0;
float phi = 0;
float camX = 0;
float camY = 0;
float camZ = 0;
PVector move ;

float l = 80;
float L= 160;
float h = 73;
float e = 3;
boolean lumiere;

int longueur =978, largeur= 594, hauteur= 278 ;
PImage img;

void setup() {
  size(1000, 800, P3D);
  tex = loadImage("Data/images/mur.jpg");
  texTable = loadImage("Data/images/table.jpg");
  texSol = loadImage("Data/images/sol.jpg");
  texPlafond = loadImage("Data/images/toit.jpeg");
  texTbleau = loadImage("Data/images/tableau.png");
  texTbleauMil = loadImage("Data/images/tabMil.png");

  texPorte = loadImage("Data/images/texturePorte.png");
  texUcFace= loadImage("Data/images/ucFace.png");
  texUcDos =loadImage("Data/images/ucDos.png");
  texUcCote = loadImage("Data/images/ucCote.png");
  texClavier = loadImage("Data/images/clavier.png");
  textureChaise = loadImage("Data/images/chaise.png");
  texDosEcran = loadImage("Data/images/dosEcran.png");
  texPlinthe = loadImage("Data/images/plinthe.png");
  texExtr = loadImage("Data/images/exter.jpg");
  texSouris = loadImage("Data/images/souris.png");
  texRadiateur = loadImage("Data/images/radiateur.png");
  texMac = loadImage("Data/images/amc.png");


  fondEcran = new PImage[4];
  fondEcran[0] = loadImage("Data/images/fe1.jpg");
  fondEcran[1] = loadImage("Data/images/f2.png");
  fondEcran[2] = loadImage("Data/images/f3.png");
  fondEcran[3] = loadImage("Data/images/f4.jpg");

  img = loadImage("Data/images/loading.gif");
  imageMode(CENTER);
  image(img, width/2, height/2, width, height);

  textureMode(NORMAL);
  salle = (new Salle(longueur, largeur, hauteur, tex, texSol, texPlafond)).getSalle();
  move = new PVector(0, 0, 0);


  colorShader = loadShader("Data/LightShaderTexFrag1.glsl", "Data/LightShaderTexVert1.glsl");

  shaders = new PShader[2];
  shaders[0] = loadShader("Data/LightShaderTexVert.glsl");
  shaders[1] = loadShader("Data/LightShaderTexFrag.glsl");
  light = new Light();
}


void draw() {
  background(0);
  bougerCamera();
  camera(camX + move.x, camY + move.y, camZ + move.z, move.x, move.y, move.z, 0, 1, 0);


  if (lumiere) {
    light.setLight();
  }
  pushMatrix();
  translate(largeur/2, 0, 0);

  shader(colorShader);

  shape(salle);
  popMatrix();
}

void mousePressed() {
  if (mouseButton == RIGHT) //allumer/eteindre la lumiere
    lumiere= !lumiere;
}

void bougerCamera() {
  float sensitivity = 0.01;
  float vitesse = 2;

  // Rotation de la caméra avec la souris
  if (mousePressed) {
    theta += sensitivity * (pmouseX - mouseX);
    phi += sensitivity * (pmouseY - mouseY);
  }

  rayon = constrain(rayon, 200, 1000);

  // Déplacement de la caméra avec le clavier
  if (keyPressed) {
    if (key == 'w' || key == 'W' || keyCode == UP) {
      move.z -=  cos(theta) *vitesse;
      move.x -=  sin(theta)*vitesse;
      move.y -= sin(phi)*vitesse;
    } else if (key == 's' || key == 'S' ||keyCode == DOWN) {
      move.z +=  cos(theta) *vitesse;
      move.x +=  sin(theta)*vitesse;
      move.y += sin(phi)*vitesse;
    } else if (key == 'q' || key == 'Q' || keyCode == LEFT) {
      move.z +=  sin(theta) *vitesse;
      move.x -=  cos(theta)*vitesse;
    } else if (key == 'd' || key == 'D' || keyCode == RIGHT) {
      move.z -=  sin(theta) *vitesse;
      move.x +=  cos(theta)*vitesse;
    }
  }

  // Conversion des coordonnées sphériques en coordonnées cartésiennes
  camX = rayon * cos(phi) * sin(theta);
  camY = rayon * sin(phi);
  camZ = rayon * cos(phi) * cos(theta);
}
