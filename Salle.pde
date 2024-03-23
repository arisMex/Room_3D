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

    PShape pc = (new PC( 40, 30, 1)).getPc();
    pc.rotateY(-PI*2/3);
    pc.translate(0, hauteur/4+ 5, longueur/5 - 30 );

    PShape tableau = (new Tableau(120, 1.5)).getTableau() ;
    tableau.translate(0, 0, longueur/2-2);



    PShape tables  = (new RangeeTables(3, 4, l, L, h, e, texTable)).getRangees();
    tables.translate(-largeur/3, hauteur/2-h, -longueur/2.5);
    PShape table  = (new Table( l, L, h, e, texTable)).getTable();
    table.translate(0, hauteur/2-h+10, longueur/6+5);
    PShape chaise = (new Chaise(40, 44, 84, 2, textureChaise)).getChaise();
    chaise.rotateY(PI + PI/10);
    chaise.translate(0, hauteur/3, longueur/5 + 15 );

    PShape radiateurs  = (new Radiateur( 150, 100, 10, texRadiateur)).getRadiateurs(1);
    radiateurs.rotateY(PI/2);
    radiateurs.translate(largeur/2-20, hauteur/3, -longueur/3 - 30);
    PShape radiateurs2  = (new Radiateur( 150, 100, 10, texRadiateur)).getRadiateurs(3);
    radiateurs2.rotateY(PI/2);
    radiateurs2.translate(largeur/2-20, hauteur/3, longueur/4);

    PShape g_ecran  = (new GEcran(180, 120, 20, 10, texUcFace, texUcDos, texUcCote)).getEcran();
    g_ecran.rotateY(PI/6);
    g_ecran.translate(largeur/3.5, 0, longueur*4/10);

    PShape s = createShape(GROUP);
    s.addChild(tableau);
    s.addChild(getMurFond());
    s.addChild(getMurG());
    s.addChild(getMurD());
    s.addChild(getMurFront());
    s.addChild(getSol());
    s.addChild(getPlafond());
    s.addChild(tables);
    s.addChild(table);
    s.addChild(g_ecran);
    s.addChild(radiateurs);
    s.addChild(radiateurs2);
    s.addChild(chaise);
    s.addChild(pc);
    s.translate(-largeur/2, 0, 0);
    return s;
  }

  PShape getMurFond() {
    PShape mur = (new Cube(texMur)).getCube();
    PShape p = (new Cube(texPlinthe)).getCube();
    PShape porte = (new Porte(205, 92, 10, 10, texPorte)).getPorte();
    PShape s = createShape(GROUP);
    p.scale(largeur, hauteur/20, 1);
    p.translate(0, hauteur/2 - hauteur/40, -longueur/2 + 2);
    porte.translate(largeur/3, (hauteur -205+e)/2, -longueur/2+5);
    s.addChild(porte);
    mur.scale(largeur, hauteur, 2);
    mur.beginShape(QUADS);
    mur.translate(0, 0, -longueur/2);
    mur.texture(texMur);
    mur.endShape(CLOSE);

    s.addChild(mur);
    s.addChild(p);
    return s;
  }

  PShape getMurFront() {
    PShape mur = (new Cube(texMur)).getCube();
    PShape p = (new Cube(texPlinthe)).getCube();

    PShape s = createShape(GROUP);
    p.scale(largeur, hauteur/20, 1);
    p.translate(0, hauteur/2 - hauteur/40, longueur/2 - 2);
    mur.scale(largeur, hauteur, 2);
    mur.translate(0, 0, longueur/2);

    s.addChild(mur);
    s.addChild(p);
    return s;
  }

  PShape getMurG() {
    PShape porte = (new Porte(205, 92, 10, 10, texPorte)).getPorte();
    porte.translate(-longueur/3, (hauteur -205+e)/2, 5);
    PShape p = (new Cube(texPlinthe)).getCube();

    PShape mur = (new Cube(texMur)).getCube();
    PShape s = createShape(GROUP);
    p.scale(longueur, hauteur/20, 12);
    p.translate(0, hauteur/2 - hauteur/40, -2);
    s.addChild(p);

    mur.scale(longueur, hauteur, 2);

    s.addChild(porte);
    s.addChild(mur);
    s.rotateY(PI/2);
    s.translate(-largeur/2, 0, 0);
    return s;
  }

  PShape getMurD() {
    PShape[] mur = new PShape[7];
    PShape[] fenetres  = new PShape[4];
    PShape p = (new Cube(texPlinthe)).getCube();

    for (int i = 0; i < mur.length; i++) {
      mur[i] = (new Cube(texMur)).getCube();
    }
    for (int i = 0; i < fenetres.length; i++) {
      fenetres[i] = (new Fenetre(170, 190, texPorte)).getFenetre();
    }

    PShape s = createShape(GROUP);

    p.scale(longueur, hauteur/20, 12);
    p.translate(0, hauteur/2 - hauteur/40, -2);
    s.addChild(p);

    fenetres[0].translate(-longueur/3, 90 - hauteur/2 +7.5, -1);
    s.addChild(fenetres[0]);
    fenetres[1].translate(-longueur/3 + 190 +10, 90 - hauteur/2 +7.5, -1);
    s.addChild(fenetres[1]);
    fenetres[2].translate(-longueur/3 + 2*190 +20, 90 - hauteur/2 +7.5, -1);
    s.addChild(fenetres[2]);
    fenetres[3].translate(longueur/2.5 - 30, 90 - hauteur/2 +7.5, -1);
    s.addChild(fenetres[3]);

    mur[0].scale(longueur, 90, 10);
    mur[0].translate(0, -90/2 + hauteur/2, -1);
    s.addChild(mur[0]);

    mur[1].scale(longueur, hauteur-270, 10);
    mur[1].translate(0, -hauteur/2 +(hauteur-270)/2, -1);
    s.addChild(mur[1]);

    mur[2].scale(longueur/6 - 190/2, hauteur, 11);
    mur[2].translate(-longueur/2 + 30, 0, -1);
    s.addChild(mur[2]);

    mur[3].scale(30, hauteur, 10);
    mur[3].translate(longueur/2 - 15, 0, -1);
    s.addChild(mur[3]);

    mur[4].scale((longueur- 800)/2, hauteur, 40);
    mur[4].translate(218, 0, -15);
    s.addChild(mur[4]);
    //texture exter
    mur[5] = (new Cube(texExtr)).getCube();
    mur[5].scale((longueur)*8, hauteur*8, 10);
    mur[5].translate(1000, -200, 1500);
    s.addChild(mur[5]);
    
    mur[6] = (new Cube(texExtr)).getCube();
    mur[6].scale((longueur)*8, hauteur*8, 10);
    mur[6].translate(-longueur*8 +1000, -200, 1500);
    s.addChild(mur[6]); 
    

    s.rotateY(PI/2);
    s.translate(largeur/2, 0, 0);
    return s;
  }

  PShape getMurDroite() {
    PShape mur = (new Cube(texMur)).getCube();
    mur.scale(longueur, hauteur, 2);
    mur.rotateY(PI/2);
    mur.translate(largeur/2, 0, 0);
    return mur;
  }

  PShape getSol() {
    PShape mur = (new Cube(texSol)).getCube();
    mur.scale(largeur, longueur, 2);
    mur.rotateX(PI/2);
    mur.translate(0, hauteur/2, 0);
    return mur;
  }

  PShape getPlafond() {
    PShape mur = (new Cube(texPlafond, true)).getCube();
    mur.scale(largeur, longueur, 2);
    mur.rotateX(PI/2);
    mur.translate(0, -hauteur/2, 0);
    return mur;
  }
}
