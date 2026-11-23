// Éclairage de la salle : 6 plafonniers (lumières ponctuelles atténuées) et la
// lumière du jour qui entre par les fenêtres (directionnelle). 8 lumières au
// maximum dans Processing : 1 ambiante + 1 directionnelle + 6 ponctuelles.
class Eclairage {
  boolean allume = true;
  PVector[] positions;
  PShape lampesAllumees, lampesEteintes;

  Eclairage() {
    positions = new PVector[6];
    int i = 0;
    for (int col = -1; col <= 1; col += 2) {
      for (int rang = -1; rang <= 1; rang++) {
        positions[i++] = new PVector(col * LARGEUR / 4, -HAUTEUR + 12, rang * LONGUEUR / 3);
      }
    }
    lampesAllumees = construireLampes(mat.lampeAllumee);
    lampesEteintes = construireLampes(mat.lampeEteinte);
  }

  PShape construireLampes(Materiau diffuseur) {
    MeshBuilder mb = new MeshBuilder();
    for (PVector p : positions) {
      mb.push();
      mb.translate(p.x, -HAUTEUR + 1.5, p.z);
      mb.box(64, 3, 124, mat.cadreLampe, MeshBuilder.BAS, null);
      mb.translate(0, 1.6, 0);
      mb.box(58, 0.2, 118, null, MeshBuilder.BAS, diffuseur);
      mb.pop();
    }
    return mb.build();
  }

  PShape plafonniers() {
    return allume ? lampesAllumees : lampesEteintes;
  }

  void basculer() {
    allume = !allume;
  }

  void appliquer() {
    lightFalloff(1, 0, 0);
    lightSpecular(0, 0, 0);
    if (allume) {
      ambientLight(72, 72, 76);
      lightSpecular(40, 40, 38);
      directionalLight(70, 70, 66, -1, 0.55, 0.15);
      lightFalloff(1, 0, 0.0000032);
      lightSpecular(110, 108, 100);
      for (PVector p : positions) pointLight(118, 116, 108, p.x, p.y, p.z);
    } else {
      // Lumière du jour uniquement : plus sombre, plus bleutée
      ambientLight(48, 52, 62);
      lightSpecular(70, 70, 66);
      directionalLight(150, 148, 138, -1, 0.55, 0.15);
    }
    lightFalloff(1, 0, 0);
  }
}
