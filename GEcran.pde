class GEcran {
  float l;
  float e;
  float h;
  float L;
  float baseL, basel, baseE;
  float couL, coul, couE;
  PImage texFace, texDos, texCote;

  GEcran (float L, float l, float h, float e, PImage texFace, PImage texDos, PImage texCote ) {
    this.L = L;
    this.l = l ;
    this.h = h ;
    this.e = e;
    this.texFace = texFace;
    this.texDos = texDos;
    this.texCote = texCote;
  }

  float getl() {
    return this.l;
  }
  float getL() {
    return this.L;
  }


  PShape getEcran() {
    PShape s = createShape(GROUP);
    PShape ecran = getCadre();
    ecran.translate(0, -hauteur/15);
    s.addChild(ecran);

    s.addChild(getSupport());

    return s;
  }

  PShape getCadre() {
    PShape[] cad  =new PShape[4];
    PShape ecran = (new Cube(fondEcran[(int)random(0, 3)])).getCube();
    PShape dos = (new Cube(texCote)).getCube();
    PShape inter = (new Cube(texCote)).getCube();

    for (int i = 0; i < 4; ++i) {
      cad[i] = (new Cube(texCote)).getCube();
    }
    PShape s = createShape(GROUP);

    cad[0].scale(e/2, l+e, e);
    cad[0].translate(-L/2-(e)/4, 0, 0);
    s.addChild(cad[0]);

    cad[1].scale(e/2, l+e, e);
    cad[1].translate(L/2+(e)/4, 0, 0);
    s.addChild(cad[1]);

    cad[2].scale(L+e, e/2, e);
    cad[2].translate(0, -(l+e)/2, 0);
    s.addChild(cad[2]);

    cad[3].scale(L+e, e, e);
    cad[3].translate(0, (l+e)/2, 0);
    s.addChild(cad[3]);

    ecran.scale(L, l, e/2);
    ecran.translate(0, 0, -e/3.5);
    s.addChild(ecran);

    dos.scale(L+e, l+e, e);
    s.addChild(dos);

    inter.scale(L/3, l/2, e);
    inter.translate(0, l/4, e);
    s.addChild(inter);


    return s;
  }

  PShape getSupport() {

    PShape base = (new Cube(texDosEcran)).getCube();
    PShape support = (new Cube(texCote)).getCube();



    PShape s = createShape(GROUP);

    base.scale(L/2, l/2, e/4);
    base.rotateX(PI/2);
    base.translate(0, hauteur/2, 2*e);
    s.addChild(base);

    support.scale(l/8, hauteur/2, e);
    support.translate(0, hauteur/4, 2*e);
    s.addChild(support);


    return s;
  }
}
