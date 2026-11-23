// Assemble la salle : murs, sol, plafond, ouvertures et mobilier.
// Repère : origine au centre du sol, x vers la droite (côté fenêtres),
// y vers le bas, z vers le tableau.
class Salle {
  final float W = LARGEUR, D = LONGUEUR, H = HAUTEUR, EP = EP_MUR;

  // Fenêtres du mur droit (x = +W/2) : centres en z, largeur, allège, hauteur
  final float[] FENETRES_Z = { -361, -74, 126, 326 };
  final float FEN_L = 190, FEN_ALLEGE = 90, FEN_H = 170;

  // Portes : position et largeur de l'ouverture (battant 92 + huisserie 2 × 8)
  final float PORTE_FOND_X = LARGEUR / 3, PORTE_GAUCHE_Z = LONGUEUR / 3, PORTE_TROU = 110;

  // Rangées d'élèves
  final int NB_RANGEES = 4, NB_TABLES = 3;
  final float TABLE_L = 160, TABLE_P = 80, TABLE_H = 73;
  final float RANGEES_X = -40;
  final float[] RANGEES_Z = { -360, -210, -60, 90 };

  void construire(MeshBuilder mb) {
    construireEnveloppe(mb);
    construireMurFenetres(mb);
    construireOuvertures(mb);
    construireRangees(mb);
    construireBureauProf(mb);
  }

  // ---- Sol, plafond, murs pleins, plinthes ---------------------------------
  void construireEnveloppe(MeshBuilder mb) {
    // sol / plafond : seule la face visible est générée
    mb.push();
    mb.translate(0, 1, 0);
    mb.box(W, 2, D, null, MeshBuilder.HAUT, mat.sol);
    mb.pop();
    mb.push();
    mb.translate(0, -H - 1, 0);
    mb.box(W, 2, D, null, MeshBuilder.BAS, mat.plafond);
    mb.pop();

    // mur du tableau (z = +D/2), mur du fond (z = -D/2), mur gauche (x = -W/2)
    mb.push();
    mb.translate(0, -H / 2, D / 2 + EP / 2);
    mb.box(W, H, EP, null, MeshBuilder.AVANT, mat.mur);
    mb.pop();
    mb.push();
    mb.translate(0, -H / 2, -D / 2 - EP / 2);
    mb.box(W, H, EP, null, MeshBuilder.ARRIERE, mat.mur);
    mb.pop();
    mb.push();
    mb.translate(-W / 2 - EP / 2, -H / 2, 0);
    mb.box(EP, H, D, null, MeshBuilder.DROITE, mat.mur);
    mb.pop();

    // plinthes et goulotte, interrompues au niveau des portes
    float ep = 1.2;
    float[][] trouFond = { { PORTE_FOND_X - PORTE_TROU / 2, PORTE_FOND_X + PORTE_TROU / 2 } };
    float[][] trouGauche = { { PORTE_GAUCHE_Z - PORTE_TROU / 2, PORTE_GAUCHE_Z + PORTE_TROU / 2 } };
    float[][] aucun = {};
    bande(mb, false, D / 2 - ep / 2, -W / 2, W / 2, aucun, -6, 12, ep, mat.plinthe);
    bande(mb, false, -D / 2 + ep / 2, -W / 2, W / 2, trouFond, -6, 12, ep, mat.plinthe);
    bande(mb, true, -W / 2 + ep / 2, -D / 2, D / 2, trouGauche, -6, 12, ep, mat.plinthe);
    bande(mb, true, W / 2 - ep / 2, -D / 2, D / 2, aucun, -6, 12, ep, mat.plinthe);
    bande(mb, true, -W / 2 + 2, -D / 2, D / 2, trouGauche, -95, 10, 4, mat.appui);
  }

  // Bande horizontale le long d'un mur (plinthe, goulotte) avec des interruptions.
  // leLongDeZ : la bande suit l'axe z (murs latéraux) ; sinon l'axe x.
  void bande(MeshBuilder mb, boolean leLongDeZ, float fixe, float debut, float fin,
    float[][] trous, float y, float h, float ep, Materiau mt) {
    float a = debut;
    for (int i = 0; i <= trous.length; i++) {
      float b = i < trous.length ? trous[i][0] : fin;
      if (b - a > 0.5) {
        float c = (a + b) / 2, lg = b - a;
        mb.push();
        if (leLongDeZ) {
          mb.translate(fixe, y, c);
          mb.box(ep, h, lg, mt);
        } else {
          mb.translate(c, y, fixe);
          mb.box(lg, h, ep, mt);
        }
        mb.pop();
      }
      if (i < trous.length) a = trous[i][1];
    }
  }

  // ---- Mur droit percé de fenêtres, vue extérieure -------------------------
  void construireMurFenetres(MeshBuilder mb) {
    float x = W / 2 + EP / 2;
    float yBasFen = -FEN_ALLEGE, yHautFen = -FEN_ALLEGE - FEN_H;

    // allège et linteau sur toute la longueur
    blocMur(mb, x, 0, yBasFen, -D / 2, D / 2);
    blocMur(mb, x, yHautFen, -H, -D / 2, D / 2);
    // trumeaux entre les fenêtres
    float[] z = FENETRES_Z.clone();
    java.util.Arrays.sort(z);
    float debut = -D / 2;
    for (float zc : z) {
      blocMur(mb, x, yBasFen, yHautFen, debut, zc - FEN_L / 2);
      debut = zc + FEN_L / 2;
    }
    blocMur(mb, x, yBasFen, yHautFen, debut, D / 2);

    for (float zc : FENETRES_Z) {
      mb.push();
      mb.translate(x, (yBasFen + yHautFen) / 2, zc);
      mb.rotateY(HALF_PI);
      new Fenetre(FEN_L, FEN_H).construire(mb);
      mb.pop();

      // radiateur sous chaque fenêtre
      mb.push();
      mb.translate(W / 2 - 6, 0, zc);
      mb.rotateY(HALF_PI);
      new Radiateur(150, 58).construire(mb);
      mb.pop();
    }

    // paysage extérieur (auto-illuminé)
    mb.push();
    mb.translate(W / 2 + 420, -420, 0);
    mb.rotateY(HALF_PI);
    mb.plan(1700, 1940, mat.exterieur);
    mb.pop();
  }

  void blocMur(MeshBuilder mb, float x, float y0, float y1, float z0, float z1) {
    if (abs(z1 - z0) < 0.01 || abs(y1 - y0) < 0.01) return;
    mb.push();
    mb.translate(x, (y0 + y1) / 2, (z0 + z1) / 2);
    mb.box(EP, abs(y1 - y0), abs(z1 - z0), mat.mur);
    mb.pop();
  }

  // ---- Portes et tableaux ---------------------------------------------------
  void construireOuvertures(MeshBuilder mb) {
    // porte du fond, tournée vers la salle (+z)
    mb.push();
    mb.translate(PORTE_FOND_X, 0, -D / 2);
    mb.rotateY(PI);
    new Porte(205, 92).construire(mb);
    mb.pop();

    // porte du mur gauche, près du tableau, tournée vers +x
    mb.push();
    mb.translate(-W / 2, 0, PORTE_GAUCHE_Z);
    mb.rotateY(-HALF_PI);
    new Porte(205, 92).construire(mb);
    mb.pop();

    // tableaux sur le mur avant
    mb.push();
    mb.translate(RANGEES_X, -150, D / 2);
    new Tableau().construire(mb);
    mb.pop();

    // grand écran sur pied à droite du tableau, orienté vers la classe
    mb.push();
    mb.translate(W / 2 - 75, 0, D / 2 - 140);
    mb.rotateY(PI / 4);
    new Ecran(170, 96, 110, true).construire(mb);
    mb.pop();
  }

  // ---- Postes des élèves ------------------------------------------------------
  void construireRangees(MeshBuilder mb) {
    for (int r = 0; r < NB_RANGEES; r++) {
      for (int t = 0; t < NB_TABLES; t++) {
        float tx = RANGEES_X + (t - (NB_TABLES - 1) / 2.0) * TABLE_L;
        float tz = RANGEES_Z[r];
        mb.push();
        mb.translate(tx, 0, tz);
        new Table(TABLE_L, TABLE_P, TABLE_H, 3).construire(mb);
        posteEleve(mb, -TABLE_L / 4);
        posteEleve(mb, TABLE_L / 4);
        mb.pop();
      }
    }
  }

  // Un poste : écran, UC, clavier, souris et chaise. Origine = centre de la table.
  void posteEleve(MeshBuilder mb, float x) {
    mb.push();
    mb.translate(x, -TABLE_H, 0);

    mb.push();
    mb.translate(-4, 0, TABLE_P / 2 - 20);
    mb.rotateY(random(-0.08, 0.08));
    new Ecran(53, 30, 9, false).construire(mb);
    mb.pop();

    mb.push();
    mb.translate(30, 0, TABLE_P / 2 - 18);
    new UC().construire(mb);
    mb.pop();

    mb.push();
    mb.translate(-4 + random(-2, 2), 0, -TABLE_P / 2 + 20 + random(-3, 3));
    mb.rotateY(random(-0.06, 0.06));
    new Clavier().construire(mb);
    mb.pop();

    mb.push();
    mb.translate(27, 0, -TABLE_P / 2 + 20 + random(-2, 2));
    mb.rotateY(random(-0.1, 0.1));
    new Souris().construire(mb);
    mb.pop();
    mb.pop();

    mb.push();
    mb.translate(x + random(-5, 5), 0, -TABLE_P / 2 - 18 - random(0, 12));
    mb.rotateY(random(-0.15, 0.15));
    new Chaise().construire(mb);
    mb.pop();
  }

  // ---- Bureau de l'enseignant (face aux élèves) -----------------------------
  void construireBureauProf(MeshBuilder mb) {
    mb.push();
    mb.translate(-40, 0, 245);
    new Table(TABLE_L, TABLE_P, TABLE_H + 2, 3).construire(mb);

    mb.push();
    mb.translate(-20, -TABLE_H - 2, 8);
    mb.rotateY(PI + 0.25);
    new PC().construire(mb);
    mb.pop();

    mb.push();
    mb.translate(45, -TABLE_H - 2, 5);
    mb.rotateY(PI + 0.1);
    new Souris().construire(mb);
    mb.pop();

    mb.push();
    mb.translate(-10, 0, TABLE_P / 2 + 30);
    mb.rotateY(PI + 0.3);
    new Chaise().construire(mb);
    mb.pop();
    mb.pop();
  }
}
