class Porte {
  float l;
  float h;
  float eZ;
  float e;
  color c = color(192, 192, 197);
  PImage texture;

  Porte(float h, float l, float e, float eZ, PImage tex) {
    this.h = h;
    this.l = l;
    this.e = e;
    this.eZ = eZ;
    this.texture = tex;
  }

  Porte(float l, float e) {
    this.l = l;
    this.e = e;
  }

  PShape getPorte() {
    PShape cadre = getCadre();
    PShape prt = getPrt();

    PShape s = createShape(GROUP);
    s.addChild(cadre);
    s.addChild(prt);
    return s;
  }


  PShape getCadre() {
    PShape[] cad  =new PShape[3];
    for (int i = 0; i < 3; ++i) {
      cad[i] = (new Cube(texPorte)).getCube();
    }
    PShape s = createShape(GROUP);

    //haut
    cad[0].scale(l+2*e, e, eZ);
    cad[0].translate(0, -h/2-e/2, 0);
    s.addChild(cad[0]);

    cad[1].scale(e, h+e/2, eZ);
    cad[1].translate(l/2 + e/2, 0, 0);
    s.addChild(cad[1]);

    cad[2].scale(e, h+e/2, eZ);
    cad[2].translate(-l/2 - e/2, 0, 0);
    s.addChild(cad[2]);


    return s;
  }

  PShape getPrt() {
    PShape plaque = (new Cube(texPorte)).getCube();
    PShape serrure = getSerrure();

    PShape s = createShape(GROUP);

    // Plaque de la porte
    plaque.scale(l, h, e/2);
    s.addChild(plaque);

    // Ajout de la serrure
    serrure.translate(l/3, 0, e/4); // Ajuster la position de la serrure
    s.addChild(serrure);

    return s;
  }

  PShape getSerrure() {
    PShape p1 = (new Cube(c)).getCube();
    PShape p2 = (new Cube(c)).getCube();
    PShape p3 = (new Cube(c)).getCube();
    PShape p4 = (new Cube(c)).getCube();
    PShape p5 = (new Cube(c)).getCube();
    PShape p6 = (new Cube(c)).getCube();


    PShape s = createShape(GROUP);
    p1.scale(l/8+e/8, e/3, e/3);
    p1.translate(0, 0, e/2);
    p2.scale(e/3, e/3, e/2);
    p2.translate( l/16, 0, e/3);

    p4.scale(l/8+e/8, e/3, e/3);
    p4.translate(0, 0, -e);
    p3.scale(e/3, e/3, e/2);
    p3.translate( l/16, 0, -e/1.5);


    p5.scale( e/2, h/8+e/8, e/2);
    p5.translate( l/16, 0, -e/3);

    p6.scale( e/2, h/8+e/8, e/2);
    p6.translate( l/16, 0, 0);


    s.addChild(p1);
    s.addChild(p2);
    s.addChild(p3);
    s.addChild(p4);
    s.addChild(p5);
    s.addChild(p6);


    return s;
  }
}
