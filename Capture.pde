// Mode capture (--capture) : rend des points de vue prédéfinis, enregistre
// les images du README dans Data/images/ puis quitte.
// { x, y, z, lacet, tangage, champ de vision, lumière allumée (1/0) }
final float[][] VUES = {
  { -255, -175, -470, 0.42, -0.14, PI / 2.9, 1 },
  { -230, -185, 440, PI - 0.45, -0.22, PI / 2.9, 1 },
  { -255, -175, -470, 0.42, -0.14, PI / 2.9, 0 },
  { -110, -128, -330, 0.2, -0.3, PI / 3.4, 1 },
  { -270, -165, -40, HALF_PI - 0.25, -0.05, PI / 2.9, 1 },
};
final int IMAGES_PAR_VUE = 20; // laisse le temps aux textures d'être envoyées au GPU
int imagesVue = 0;

void preparerCapture(int etape) {
  if (etape >= VUES.length) return;
  float[] v = VUES[etape];
  cam.placer(v[0], v[1], v[2], v[3], v[4], v[5]);
  eclairage.allume = v[6] > 0;
}

boolean terminerCapture(int etape) {
  if (etape >= VUES.length) {
    exit();
    return false;
  }
  if (++imagesVue < IMAGES_PAR_VUE) return false;
  imagesVue = 0;
  String fichier = sketchPath("Data/images/demo" + (etape + 1) + ".png");
  save(fichier);
  println("Capture : " + fichier);
  return true;
}
