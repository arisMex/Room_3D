public class Salle {
  int longueur, largeur, hauteur;
  PImage texMur, texSol, texPlafond;

  // Constructeur de la salle
  public Salle(int lg, int lr, int ht, PImage txMur , PImage txSol, PImage txPlaf) {
    this.longueur = lg;
    this.largeur = lr;
    this.hauteur = ht;
    this.texMur = txMur;
    this.texSol = txSol;
    this.texPlafond = txPlaf;    
  }


  PShape getSalle() {
    PShape tableau = (new Tableau(120, 1.5)).getTableau() ;
    tableau.translate(0, 0,longueur/2);
    
    PShape tables  = (new RangeeTables(3, 4, l, L, h, e, texTable)).getRangees();
    tables.translate(-largeur/3, hauteur/2-h, -longueur/2.5); 

    //tests
    //PShape porte  = (new Porte(205, 92, 10, 15, texPorte)).getPorte();
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
    porte.translate(-longueur/3, (hauteur -205+e)/2,0);
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
