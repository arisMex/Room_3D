public class Salle {
  int longueur, largeur, hauteur;
  PImage texMur, texSol, texPlafond;

  // Constructeur de la salle
  public Salle(int lg, int lr, int ht, PImage txMur, PImage txSol, PImage txPlaf) {
    this.longueur = lg;
    this.largeur = lr;
    this.hauteur = ht;
    this.texMur = txMur;
    this.texSol = txSol;
    this.texPlafond = txPlaf;
  }


  PShape getSalle() {
    PShape tableau = (new Tableau(120, 1.5)).getTableau() ;
    tableau.translate(0, 0, longueur/2);



    PShape tables  = (new RangeeTables(3, 4, l, L, h, e, texTable)).getRangees();
    tables.translate(-largeur/3, hauteur/2-h, -longueur/2.5);

    //tests
    //PShape porte  = (new Fenetre(150, 200, texPorte)).getFenetre();
    // PShape ecran  = (new Ecran(53, 31, 60, 2,texUcFace, texUcDos, texUcCote)).getEcran();

    PShape s = createShape(GROUP);
    s.addChild(tableau);
    s.addChild(getMurFond());
    s.addChild(getMurG());
    s.addChild(getMurD());
    s.addChild(getMurFront());
    s.addChild(getSol());
    s.addChild(getPlafond());
    s.addChild(tables);
    //s.addChild(porte);
    //s.addChild(ecran);

    s.translate(-largeur/2, 0, 0);
    return s;
  }

  PShape getMurFond() {
    PShape mur = (new Cube(texMur)).getCube();
    mur.scale(largeur, hauteur, 0);
    mur.beginShape(QUADS);
    mur.translate(0, 0, -longueur/2);
    mur.texture(texMur);
    mur.endShape(CLOSE);
    return mur;
  }

  PShape getMurFront() {
    PShape mur = (new Cube(texMur)).getCube();
    mur.scale(largeur, hauteur, 0);
    mur.translate(0, 0, longueur/2);
    return mur;
  }

  PShape getMurG() {
    PShape porte = (new Porte(205, 92, 10, 15, texPorte)).getPorte();
    porte.translate(-longueur/3, (hauteur -205+e)/2, 0);
    PShape mur = (new Cube(texMur)).getCube();
    PShape s = createShape(GROUP);

    mur.scale(longueur, hauteur, 0);
    s.addChild(porte);
    //mur.rotateY(PI/2);
    //mur.translate(-largeur/2, 0, 0);
    s.addChild(mur);
    s.rotateY(PI/2);
    s.translate(-largeur/2, 0, 0);


    //mur.beginShape(QUADS);
    //mur.texture(texMur);
    //mur.endShape(CLOSE);
    return s;
  }

  PShape getMurD() {
    PShape[] mur = new PShape[5];
    PShape[] fenetres  = new PShape[3];


    for (int i = 0; i < mur.length; i++) {
      mur[i] = (new Cube(texMur)).getCube();
    }
    for (int i = 0; i < fenetres.length; i++) {
      fenetres[i] = (new Fenetre(170, 190, texPorte)).getFenetre();
    }

    PShape s = createShape(GROUP);

    fenetres[0].translate(-longueur/3, 90 - hauteur/2 +7.5, 2);
    s.addChild(fenetres[0]);
    fenetres[1].translate(-longueur/3 + 190 +10, 90 - hauteur/2 +7.5, 2);
    s.addChild(fenetres[1]);
    fenetres[2].translate(-longueur/3 + 2*190 +20, 90 - hauteur/2 +7.5, 2);
    s.addChild(fenetres[2]);

    mur[0].scale(longueur, 90, 10);
    mur[0].translate(0, -90/2 + hauteur/2, 0);
    s.addChild(mur[0]);

    mur[1].scale(longueur, hauteur-270, 10);
    mur[1].translate(0, -hauteur/2 +(hauteur-270)/2, 0);
    s.addChild(mur[1]);

    mur[2].scale(longueur, 90, 10);
    mur[2].translate(0, 90 - hauteur/2, 0);
    // s.addChild(mur[2]);

    s.rotateY(PI/2);
    s.translate(largeur/2, 0, 0);
    return s;
  }

  PShape getMurDroite() {
    PShape mur = (new Cube(texMur)).getCube();
    mur.scale(longueur, hauteur, 0);
    mur.rotateY(PI/2);
    mur.translate(largeur/2, 0, 0);
    //mur.beginShape(QUADS);
    //mur.texture(texMur);
    //mur.endShape(CLOSE);
    return mur;
  }

  PShape getSol() {
    PShape mur = (new Cube(texSol)).getCube();
    mur.scale(largeur, longueur, 0);
    mur.rotateX(PI/2);
    mur.translate(0, hauteur/2, 0);
    return mur;
  }

  PShape getPlafond() {
    PShape mur = (new Cube(texPlafond, true)).getCube();
    mur.scale(largeur, longueur, 0);
    mur.rotateX(PI/2);
    mur.translate(0, -hauteur/2, 0);
    return mur;
  }
}
