// Caméra à la première personne : déplacements fluides (indépendants du nombre
// d'images par seconde), plusieurs touches simultanées, collisions avec les murs.
class CameraFPS {
  PVector pos = new PVector();
  float lacet, tangage;          // rotation horizontale / verticale (radians)
  float fov = PI / 3;
  float elan = 0;                // vitesse donnée par la molette (cm/s), amortie
  PVector vitesse = new PVector();

  final float VITESSE = 170;     // cm/s
  final float SENSIBILITE = 0.0045;
  final float MARGE = 18;        // distance minimale aux murs

  java.util.HashSet<Integer> codes = new java.util.HashSet<Integer>();
  java.util.HashSet<Character> lettres = new java.util.HashSet<Character>();

  CameraFPS() {
    reinitialiser();
  }

  void reinitialiser() {
    pos.set(-LARGEUR * 0.32, -165, -LONGUEUR / 2 + 40);
    lacet = 0.35;
    tangage = -0.12;
    fov = PI / 3;
    elan = 0;
    vitesse.set(0, 0, 0);
  }

  void placer(float x, float y, float z, float lacet, float tangage, float fov) {
    pos.set(x, y, z);
    this.lacet = lacet;
    this.tangage = tangage;
    this.fov = fov;
  }

  PVector avant() {
    return new PVector(sin(lacet), 0, cos(lacet));
  }
  PVector droite() {
    return new PVector(-cos(lacet), 0, sin(lacet));
  }

  void touche(char k, int code, boolean appuye) {
    char c = Character.toLowerCase(k);
    if (k == CODED) {
      if (appuye) codes.add(code);
      else codes.remove(code);
    } else if (appuye) lettres.add(c);
    else lettres.remove(c);
    // Maj / Ctrl arrivent aussi comme touches codées
    if (code == SHIFT || code == CONTROL) {
      if (appuye) codes.add(code);
      else codes.remove(code);
    }
  }

  boolean l(char c) {
    return lettres.contains(c);
  }
  boolean c(int code) {
    return codes.contains(code);
  }

  void tourner(float dx, float dy) {
    lacet -= dx * SENSIBILITE;
    tangage = constrain(tangage - dy * SENSIBILITE, -1.45, 1.45);
  }

  void zoomer(float n) {
    fov = constrain(fov + n * 0.05, PI / 8, PI / 2);
  }

  void avancerMolette(float n) {
    elan = constrain(elan + n * 120, -600, 600);
  }

  void mettreAJour(float dt) {
    dt = min(dt, 0.1);
    float av = 0, lat = 0, vert = 0;
    if (l('z') || l('w') || c(UP)) av += 1;
    if (l('s') || c(DOWN)) av -= 1;
    if (l('q') || l('a') || c(LEFT)) lat -= 1;
    if (l('d') || c(RIGHT)) lat += 1;
    if (l(' ')) vert -= 1;
    if (c(CONTROL)) vert += 1;
    float v = VITESSE * (c(SHIFT) ? 2.2 : 1);

    // Vitesse cible puis lissage exponentiel (démarrage / arrêt progressifs)
    PVector cible = PVector.mult(avant(), av).add(PVector.mult(droite(), lat));
    if (cible.magSq() > 0) cible.normalize().mult(v);
    cible.y = vert * v * 0.6;
    cible.add(PVector.mult(avant(), elan));
    float k = 1 - exp(-dt * 12);
    vitesse.lerp(cible, k);
    elan *= exp(-dt * 5);
    if (abs(elan) < 1) elan = 0;

    pos.add(PVector.mult(vitesse, dt));
    pos.x = constrain(pos.x, -LARGEUR / 2 + MARGE, LARGEUR / 2 - MARGE);
    pos.z = constrain(pos.z, -LONGUEUR / 2 + MARGE, LONGUEUR / 2 - MARGE);
    pos.y = constrain(pos.y, -HAUTEUR + 25, -40);
  }

  void appliquer() {
    PVector dir = new PVector(cos(tangage) * sin(lacet), -sin(tangage), cos(tangage) * cos(lacet));
    camera(pos.x, pos.y, pos.z, pos.x + dir.x, pos.y + dir.y, pos.z + dir.z, 0, 1, 0);
    perspective(fov, (float) width / height, 1, 5000);
  }
}
