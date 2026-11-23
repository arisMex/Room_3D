// Mobilier et équipements. Chaque objet est construit à l'origine courante du
// MeshBuilder (posé au sol ou sur un plan de travail) et orienté vers -z
// (face AVANT), sauf indication contraire.

// ---------------------------------------------------------------------------
class Table {
  float L, l, H, e; // longueur (x), profondeur (z), hauteur, épaisseur du plateau

  Table(float L, float l, float H, float e) {
    this.L = L;
    this.l = l;
    this.H = H;
    this.e = e;
  }

  void construire(MeshBuilder mb) {
    // plateau
    mb.push();
    mb.translate(0, -H + e / 2, 0);
    mb.box(L, e, l, mat.plateauTable);
    mb.pop();

    // pieds en métal
    float p = 4, retrait = 6;
    for (int sx = -1; sx <= 1; sx += 2) {
      for (int sz = -1; sz <= 1; sz += 2) {
        mb.push();
        mb.translate(sx * (L / 2 - retrait), 0, sz * (l / 2 - retrait));
        mb.boxPose(p, H - e, p, mat.metal);
        mb.translate(0, -0.5, 0);
        mb.boxPose(p + 1.5, 1, p + 1.5, mat.plastiqueNoir); // patin
        mb.pop();
      }
    }
    // ceinture sous le plateau
    float hc = 6;
    for (int sz = -1; sz <= 1; sz += 2) {
      mb.push();
      mb.translate(0, -H + e + hc / 2, sz * (l / 2 - retrait));
      mb.box(L - 2 * retrait, hc, 2, mat.metal);
      mb.pop();
    }
    for (int sx = -1; sx <= 1; sx += 2) {
      mb.push();
      mb.translate(sx * (L / 2 - retrait), -H + e + hc / 2, 0);
      mb.box(2, hc, l - 2 * retrait, mat.metal);
      mb.pop();
    }
  }
}

// ---------------------------------------------------------------------------
// Chaise d'école orientée vers +z (l'élève regarde vers +z) :
// piétement métallique, assise et dossier en bois vissés sur le piétement.
class Chaise {
  float l = 42, p = 40, hAssise = 46, hDossier = 86, e = 2.2, t = 2.2;

  void construire(MeshBuilder mb) {
    float xPied = l / 2 - t / 2 - 1;        // axe des pieds
    float zAvant = p / 2 - t / 2 - 1, zArriere = -p / 2 + t / 2 + 1;
    float hCadre = hAssise - e;             // dessous de l'assise

    // pieds avant (jusqu'au cadre) et arrière (jusqu'en haut du dossier)
    for (int sx = -1; sx <= 1; sx += 2) {
      mb.push();
      mb.translate(sx * xPied, 0, zAvant);
      mb.boxPose(t, hCadre, t, mat.metal);
      mb.pop();
      mb.push();
      mb.translate(sx * xPied, 0, zArriere);
      mb.boxPose(t, hDossier, t, mat.metal);
      mb.pop();
    }

    // cadre sous l'assise
    for (int sx = -1; sx <= 1; sx += 2) {
      mb.push();
      mb.translate(sx * xPied, -hCadre + 1.5, 0);
      mb.box(t, 3, zAvant - zArriere, mat.metal);
      mb.pop();
    }
    for (int sz = -1; sz <= 1; sz += 2) {
      mb.push();
      mb.translate(0, -hCadre + 1.5, sz == 1 ? zAvant : zArriere);
      mb.box(2 * xPied, 3, t, mat.metal);
      mb.pop();
    }
    // entretoises basses
    for (int sx = -1; sx <= 1; sx += 2) {
      mb.push();
      mb.translate(sx * xPied, -15, 0);
      mb.box(1.6, 1.6, zAvant - zArriere, mat.metal);
      mb.pop();
    }

    // assise (déborde légèrement du cadre)
    mb.push();
    mb.translate(0, -hAssise + e / 2, 0.5);
    mb.box(l, e, p + 1, mat.bois);
    mb.pop();

    // dossier : panneau vissé devant les pieds arrière + traverse basse
    float hPanneau = 19;
    mb.push();
    mb.translate(0, -hDossier + 2 + hPanneau / 2, zArriere + t / 2 + 0.8);
    mb.box(l - 1, hPanneau, 1.6, mat.bois);
    mb.pop();
    mb.push();
    mb.translate(0, -hDossier + 2 + hPanneau + 6, zArriere);
    mb.box(2 * xPied, 1.6, 1.6, mat.metal);
    mb.pop();
  }
}

// ---------------------------------------------------------------------------
// Écran sur pied. Si surPied est vrai, le pied repose au sol (grand écran).
class Ecran {
  float w, h, hauteurBas;
  boolean surPied;
  Materiau dalle;

  Ecran(float w, float h, float hauteurBas, boolean surPied) {
    this.w = w;
    this.h = h;
    this.hauteurBas = hauteurBas;
    this.surPied = surPied;
    this.dalle = mat.ecran(textures.fondAleatoire());
  }

  void construire(MeshBuilder mb) {
    float cadre = surPied ? 3 : 1.2, ep = surPied ? 5 : 2;
    float yCentre = -(hauteurBas + h / 2);

    // socle
    mb.push();
    if (surPied) {
      mb.translate(0, 0, 10);
      mb.boxPose(w * 0.45, 3, 55, mat.plastiqueGris);
      mb.translate(0, -3, 0);
      mb.boxPose(8, -yCentre - 3, 8, mat.plastiqueGris);
    } else {
      mb.translate(0, 0, 5);
      mb.boxPose(20, 1.2, 15, mat.plastiqueNoir);
      mb.translate(0, -1.2, 3);
      mb.boxPose(5, -yCentre - 1.2, 2.5, mat.dosEcran);
    }
    mb.pop();

    // coque + dalle
    mb.push();
    mb.translate(0, yCentre, 0);
    Materiau[] coque = { mat.plastiqueNoir, mat.plastiqueNoir, mat.plastiqueNoir, mat.dosEcran, mat.plastiqueNoir, mat.plastiqueNoir };
    mb.box(w + 2 * cadre, h + 2 * cadre + (surPied ? 0 : 1.5), ep, coque);
    mb.push();
    mb.translate(0, surPied ? 0 : -0.75, -ep / 2 - 0.05);
    mb.plan(w, h, dalle);
    mb.pop();
    // bosse arrière
    mb.translate(0, h * 0.05, ep / 2 + 1.5);
    mb.box(w * 0.45, h * 0.5, 3, mat.dosEcran);
    mb.pop();
  }
}

// ---------------------------------------------------------------------------
class Clavier {
  float L = 44, l = 14, h = 2;

  void construire(MeshBuilder mb) {
    mb.push();
    mb.translate(0, -h / 2, 0);
    mb.box(L, h, l, mat.plastiqueNoir, MeshBuilder.HAUT, mat.clavier);
    mb.pop();
  }
}

// ---------------------------------------------------------------------------
class Souris {
  // Coque arrondie (demi-ellipsoïde), molette et câble vers l'avant (+z).
  void construire(MeshBuilder mb) {
    mb.boxPose(22, 0.3, 18, mat.plastiqueGris); // tapis
    mb.push();
    mb.translate(0, -0.3, 0);
    mb.boxPose(6.0, 0.4, 10.0, mat.plastiqueGris); // semelle
    mb.translate(0, -0.4, 0);
    mb.dome(3.0, 3.2, 5.2, 8, mat.plastiqueNoir);
    // séparation des boutons et molette
    mb.push();
    mb.translate(0, -2.75, 2.6);
    mb.box(0.25, 0.5, 3.6, mat.plastiqueGris);
    mb.translate(0, -0.3, 0);
    mb.box(0.8, 1.0, 1.6, mat.metalClair);
    mb.pop();
    // câble
    mb.translate(0, 0.4, 9.0);
    mb.boxPose(0.45, 0.45, 8, mat.plastiqueNoir);
    mb.pop();
  }
}

// ---------------------------------------------------------------------------
// Unité centrale debout, façade vers -z.
class UC {
  float l = 9, h = 29, L = 28;

  void construire(MeshBuilder mb) {
    mb.push();
    mb.translate(0, -h / 2, 0);
    mb.box(l, h, L, new Materiau[] { mat.ucCote, mat.ucCote, mat.ucFace, mat.ucDos, mat.ucCote, mat.ucCote });
    mb.pop();
  }
}

// ---------------------------------------------------------------------------
// Ordinateur portable, écran tourné vers l'utilisateur placé en -z.
class PC {
  float L = 32, l = 22, e = 1.6;

  void construire(MeshBuilder mb) {
    mb.push();
    mb.translate(0, -e / 2, 0);
    mb.box(L, e, l, mat.alu);
    mb.pop();
    // clavier incrusté
    mb.push();
    mb.translate(0, -e - 0.05, 1);
    mb.box(L - 4, 0, l * 0.45, null, MeshBuilder.HAUT, mat.clavier);
    mb.pop();
    // écran sur charnière
    mb.push();
    mb.translate(0, -e, l / 2 - 0.4);
    mb.rotateX(-0.28);
    mb.translate(0, -l / 2, 0);
    mb.box(L, l, 0.7, new Materiau[] { mat.alu, mat.alu, mat.plastiqueNoir, mat.couvercleMac, mat.alu, mat.alu });
    mb.translate(0, 0, -0.4);
    mb.plan(L - 2.5, l - 2.5, mat.ecran(textures.fondAleatoire()));
    mb.pop();
  }
}

// ---------------------------------------------------------------------------
// Radiateur à éléments, posé contre un mur (face vers -z).
class Radiateur {
  float L, h, e = 8, hauteurSol = 14;

  Radiateur(float L, float h) {
    this.L = L;
    this.h = h;
  }

  void construire(MeshBuilder mb) {
    mb.push();
    mb.translate(0, -hauteurSol - h / 2, 0);
    mb.box(L, h, e, mat.radiateurCote, MeshBuilder.AVANT, mat.radiateur);
    mb.pop();
    // tuyau d'alimentation et robinet
    mb.push();
    mb.translate(-L / 2 + 3, -hauteurSol / 2, 0);
    mb.box(2.5, hauteurSol, 2.5, mat.metalClair);
    mb.translate(0, -hauteurSol / 2 + 3, -2);
    mb.box(4, 4, 4, mat.metalClair);
    mb.pop();
  }
}

// ---------------------------------------------------------------------------
// Porte avec huisserie. Origine = bas de la porte, dans le plan du mur.
class Porte {
  float h, l, cadre = 8, profondeur = 14;

  Porte(float h, float l) {
    this.h = h;
    this.l = l;
  }

  void construire(MeshBuilder mb) {
    // huisserie
    mb.push();
    mb.translate(0, -h - cadre / 2, 0);
    mb.box(l + 2 * cadre, cadre, profondeur, mat.porte);
    mb.pop();
    for (int s = -1; s <= 1; s += 2) {
      mb.push();
      mb.translate(s * (l / 2 + cadre / 2), 0, 0);
      mb.boxPose(cadre, h, profondeur, mat.porte);
      mb.pop();
    }
    // battant
    mb.push();
    mb.translate(0, 0, -2);
    mb.boxPose(l, h - 0.5, 4, mat.porte);
    mb.pop();
    // poignée côté salle
    mb.push();
    mb.translate(l / 2 - 10, -105, -4);
    mb.box(3.5, 14, 1, mat.poignee);        // plaque
    mb.translate(0, -4.5, -1.5);
    mb.box(2, 2, 3, mat.poignee);           // tige
    mb.translate(-6, 0, -1.5);
    mb.box(13, 2, 2, mat.poignee);          // levier, vers la charnière
    mb.pop();
  }
}

// ---------------------------------------------------------------------------
// Fenêtre. Origine = centre de l'ouverture, au milieu de l'épaisseur du mur.
class Fenetre {
  float w, h, cadre = 6, profondeur = 8;

  Fenetre(float w, float h) {
    this.w = w;
    this.h = h;
  }

  void montant(MeshBuilder mb, float x, float y, float bw, float bh) {
    mb.push();
    mb.translate(x, y, 0);
    mb.box(bw, bh, profondeur, mat.cadreFenetre);
    mb.pop();
  }

  void construire(MeshBuilder mb) {
    // dormant
    montant(mb, 0, -h / 2 + cadre / 2, w, cadre);
    montant(mb, 0, h / 2 - cadre / 2, w, cadre);
    montant(mb, -w / 2 + cadre / 2, 0, cadre, h);
    montant(mb, w / 2 - cadre / 2, 0, cadre, h);
    // imposte et meneau
    float yImposte = -h / 4;
    montant(mb, 0, yImposte, w, cadre * 0.8);
    montant(mb, -w / 6, (yImposte + h / 2) / 2, cadre * 0.8, h / 2 - yImposte);
    montant(mb, w / 6, (yImposte - h / 2) / 2, cadre * 0.8, yImposte + h / 2);
    // poignée
    mb.push();
    mb.translate(-w / 6 - 5, h / 8, -profondeur / 2 - 1.5);
    mb.box(1.5, 10, 2, mat.poignee);
    mb.pop();
    // vitrage
    mb.push();
    mb.translate(0, 0, 0);
    mb.plan(w - cadre, h - cadre, mat.vitre);
    mb.pop();
    // appui intérieur
    mb.push();
    mb.translate(0, h / 2 + 1, -profondeur / 2 - 4);
    mb.box(w + 12, 2, 14, mat.appui);
    mb.pop();
  }
}

// ---------------------------------------------------------------------------
// Tableau triptyque : panneau central (commandes) et deux volets accolés,
// cadre aluminium et auget avec craies et brosse. Origine = centre du
// panneau central, contre le mur ; face vers -z.
class Tableau {
  float L = 240, H = 120, volet = 100, c = 3, ep = 2;

  void panneau(MeshBuilder mb, float w, float h, Materiau surface) {
    mb.push();
    mb.translate(0, 0, -ep / 2);
    mb.box(w, h, ep, mat.cadreTableau, MeshBuilder.AVANT, surface);
    mb.pop();
    for (int s = -1; s <= 1; s += 2) {
      mb.push();
      mb.translate(0, s * (h / 2 + c / 2), -ep / 2 - 0.5);
      mb.box(w + 2 * c, c, ep + 1, mat.cadreTableau);
      mb.pop();
      mb.push();
      mb.translate(s * (w / 2 + c / 2), 0, -ep / 2 - 0.5);
      mb.box(c, h, ep + 1, mat.cadreTableau);
      mb.pop();
    }
  }

  void construire(MeshBuilder mb) {
    panneau(mb, L, H, mat.tableauCentre);
    float dx = L / 2 + c + volet / 2 + c;
    mb.push();
    mb.translate(-dx, 0, 0);
    panneau(mb, volet, H, mat.tableauVolet);
    mb.pop();
    mb.push();
    mb.translate(dx, 0, 0);
    panneau(mb, volet, H, mat.tableauCroquis);
    mb.pop();

    // auget sous le panneau central
    mb.push();
    mb.translate(0, H / 2 + c + 1, -5);
    mb.box(L + 2 * c, 2, 10, mat.cadreTableau);
    mb.push();
    mb.translate(0, -1.5, -3.5);
    mb.box(L + 2 * c, 3, 1, mat.cadreTableau); // rebord
    mb.pop();
    // craies et brosse
    float[] xs = { -70, -62, -55 };
    for (int i = 0; i < xs.length; i++) {
      mb.push();
      mb.translate(xs[i], -1 - 0.5, random(-2, 1));
      mb.rotateY(random(-0.6, 0.6));
      mb.box(6, 1, 1, mat.craie);
      mb.pop();
    }
    mb.translate(60, -1 - 2, 0);
    mb.rotateY(0.15);
    mb.box(14, 4, 5.5, mat.brosse, MeshBuilder.BAS, mat.plastiqueGris);
    mb.pop();
  }
}
