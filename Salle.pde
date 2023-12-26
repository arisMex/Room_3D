public class Salle {
  int longueur, largeur, hauteur;
  PImage texMur, texSol;

  // Constructeur de la salle
  public Salle(int lg, int pr, int ht, PImage txMur, PImage txSol) {
    this.longueur = lg;
    this.largeur = pr;
    this.hauteur = ht;
    this.texMur = txMur;
    this.texSol = txSol;
  }


  PShape getSalle() {
    PShape s = createShape(GROUP);
    s.addChild(getMurFond());
    //s.addChild(getMurG());
    //s.addChild(getMurD());
    //s.addChild(getMurFront());
    //s.addChild(getSol());
    //s.rotateY(PI/20);
    //s.rotateX(PI/20);

    s.translate(-largeur/2,0, 0);
    return s;
  }



  PShape getMurFond() {
    PShape mur = (new Cube(texMur)).getCube();
    mur.scale(largeur, hauteur, 0);
    mur.beginShape(QUADS);
    mur.translate(largeur/2, hauteur/2, 0);
    //mur.texture(texMur);
    mur.endShape(CLOSE);
    return mur;
  }

  PShape getMurFront() {
    PShape mur = (new Cube(texMur)).getCube();
    mur.scale(largeur, hauteur, 0);
    mur.translate(0, 0, -longueur);

    return mur;
  }

  PShape getMurG() {
    PShape mur = (new Cube(texMur)).getCube();
    mur.scale(longueur, hauteur, 0);
    mur.rotateY(PI/2);
    mur.translate(-largeur/2, 0, longueur/2);
    //mur.beginShape(QUADS);
    //mur.texture(texMur);
    //mur.endShape(CLOSE);
    return mur;
  }

  PShape getMurD() {
    PShape mur = (new Cube(texMur)).getCube();
    mur.scale(longueur, hauteur, 0);
    mur.rotateY(PI/2);
    mur.translate(largeur/2, 0, longueur/2);
    //mur.beginShape(QUADS);
    //mur.texture(texMur);
    //mur.endShape(CLOSE);
    return mur;
  }

  PShape getSol() {
    PShape mur = (new Cube(texSol)).getCube();
    mur.scale(largeur, longueur, 0);
    mur.rotateX(PI/2);
    return mur;
  }
}
