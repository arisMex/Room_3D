class Tableau {
  float l;
  float e;
  color c = color(192,192,197);
  PImage texture;

  Cube cube;
  PShape plan;

  Tableau(float l, float e, PImage tex) {
    this.l = l;
    this.e = e;
    this.texture = tex;
  }

  Tableau(float l, float e) {
    this.l = l;
    this.e = e;
  }

  PShape getTableau() {
    PShape tabG = getPetitTab();
    tabG.translate(l*(1.5), 0, 0);
    PShape tabD = getPetitTab();
    PShape tabMil = getGrandTab();
    tabD.translate(-l*(1.5), 0, 0);
    PShape s = createShape(GROUP);
    s.addChild(tabG);
    s.addChild(tabD);
    s.addChild(tabMil);
    return s;
  }


  PShape getGrandTab() {
    PShape[] cad  =new PShape[4];
    PShape plaque = (new Cube(texTbleau)).getCube();
    for (int i = 0; i < 4; ++i) {
      cad[i] = (new Cube(c)).getCube();
    }
    PShape s = createShape(GROUP);

    cad[0].scale(e, l, e);
    cad[0].translate(-l+(e)/2, 0, 0);
    s.addChild(cad[0]);

    cad[1].scale(e, l, e);
    cad[1].translate(l+(e)/2, 0, 0);
    s.addChild(cad[1]);

    cad[2].scale(2*l-(e)/2, e, e);
    cad[2].translate(0, -(l+e)/2, 0);
    s.addChild(cad[2]);

    cad[3].scale(2*l-(e)/2, e, e);
    cad[3].translate(0, (l+e)/2, 0);
    s.addChild(cad[3]);

    plaque.scale(2*l-(e), l-e, e);
    s.addChild(plaque);


    return s;
  }

  PShape getPetitTab() {
    PShape[] cad  =new PShape[4];
    PShape plaque = (new Cube(texTbleau)).getCube();
    for (int i = 0; i < 4; ++i) {
      cad[i] = (new Cube(c)).getCube();
    }
    PShape s = createShape(GROUP);

    cad[0].scale(e, l, e);
    cad[0].translate(-(l+e)/2, 0, 0);
    s.addChild(cad[0]);

    cad[1].scale(e, l, e);
    cad[1].translate((l+e)/2, 0, 0);
    s.addChild(cad[1]);

    cad[2].scale(l, e, e);
    cad[2].translate(0, -(l+e)/2, 0);
    s.addChild(cad[2]);

    cad[3].scale(l, e, e);
    cad[3].translate(0, (l+e)/2, 0);
    s.addChild(cad[3]);

    plaque.scale(l-(e), l-e, e);
    s.addChild(plaque);


    return s;
  }
}
