class PC {
  float l;
  float e;
  float h;

  PC(float l, float h, float e) {
    this.l = l;
    this.h = h;
    this.e = e;
  }

  PShape getPc() {
    PShape s = createShape(GROUP);
    PShape ecran = getCadre();
    ecran.translate(0, -h/2, h/2-e/2);
    s.addChild(ecran);
    s.addChild(getBase());

    return s;
  }

  PShape getCadre() {
    PShape[] cad = new PShape[4];
    PShape ecran = (new Cube(fondEcran[(int)random(0, 3)])).getCube();
    PShape dos = (new Cube(texMac)).getCube();

    for (int i = 0; i < 4; ++i) {
      cad[i] = (new Cube(texDosEcran)).getCube();
    }
    PShape s = createShape(GROUP);

    cad[0].scale(e/2, h+e, e);
    cad[0].translate(-h/2-(e)/4, 0, 0);
    s.addChild(cad[0]);

    cad[1].scale(e/2, h+e, e);
    cad[1].translate(h/2+(e)/4, 0, 0);
    s.addChild(cad[1]);

    cad[2].scale(l+e/2, e/2, e);
    cad[2].translate(0, -(h+e)/2, 0);
    s.addChild(cad[2]);

    cad[3].scale(l+e/2, e, e);
    cad[3].translate(0, (h+e)/2, 0);
    s.addChild(cad[3]);

    ecran.scale(l, h, e/2);
    ecran.translate(0, 0, -e/3.5);
    s.addChild(ecran);

    dos.scale(l+e, h+e, e);
    s.addChild(dos);

    return s;
  }

  PShape getBase() {
    PShape base = (new Cube(texDosEcran)).getCube();
    PShape clavier = (new Clavier(30, 15, e/2, texClavier, texClavier)).getClavier();
    PShape s = createShape(GROUP);
    base.scale(l, h, e);
    base.rotateX(PI/2);
    clavier.translate(0, -1, -e);
    s.addChild(base);
    s.addChild(clavier);

    return s;
  }
}
