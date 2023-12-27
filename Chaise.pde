class Chaise {
  float l;
  float L;
  float H;
  float e;
  PImage texture;

  Cube cube;
  PShape plan;

  Chaise(float l, float L, float H, float e, PImage tex) {
    this.L = L;
    this.l = l;
    this.H = H;
    this.e = e;
    this.texture = tex;
  }

  Chaise(float l, float L, float H, float e) {
    this.L = L;
    this.l = l;
    this.H = H;
    this.e = e;
  }

  PShape getChaise() {
    PShape pv = new Cube(texture).getCube();
    pv.scale(L/2, L, e);
    pv.rotateZ(PI/2);
    pv.translate(0, -L+L/4, l/2);
    PShape ph = new Cube(texture).getCube();
    ph.scale(L, L, 2);
    ph.rotateX(PI/2);

    PShape pp = new Cube(texture).getCube();
    pp.scale(L, L/10, e);
    pp.rotateX(-PI/6);
    pp.translate(0, l/20, -l/2 -e);

    PShape s = createShape(GROUP);

    s.addChild(pv);
    s.addChild(ph);
    s.addChild(pp);

    PShape[] legs  =new PShape[4];

    legs[0] = getLegDevant();
    legs[0].translate(l/2-e, 0, l/2+e);
    s.addChild(legs[0]);

    legs[1] = getLegDevant();
    legs[1].translate(-l/2+e, 0, l/2+e);
    s.addChild(legs[1]);

    legs[2] = getLegArriere();
    legs[2].translate(-l/2+e, L/2, -l/2+2*e);
    s.addChild(legs[2]);

    legs[3] = getLegArriere();
    legs[3].translate(l/2-e, L/2, -l/2+2*e);
    s.addChild(legs[3]);
    
    s.addChild(getLegAtelles());
    s.rotateY(PI);
    return s;
  }


  PShape getLegDevant() {
    color c = color(255, 255, 0);
    PShape leg = (new Cube(c)).getCube();
    leg.scale(e, H, e);
    leg.beginShape(QUADS);
    leg.texture(texture);
    leg.endShape(CLOSE);
    return leg;
  }

  PShape getLegArriere() {
    color c = color(255, 255, 0);
    PShape leg = (new Cube(c)).getCube();
    leg.scale(e, L, e);
    leg.beginShape(QUADS);
    leg.texture(texture);
    leg.endShape(CLOSE);
    return leg;
  }

  PShape getLegAtelles() {
    color c = color(255, 255, 0);
    PShape leg = (new Cube(c)).getCube();
    PShape leg2 = (new Cube(c)).getCube();
    PShape atelle = (new Cube(c)).getCube();
    PShape s = createShape(GROUP);


    leg.scale(e, l-2*e, e);
    leg.rotateZ(PI/2);
    leg.translate(0, 3*e, l/2+e);
    s.addChild(leg);
    
    leg2.scale(e, l-2*e, e);
    leg2.rotateZ(PI/2);
    leg2.translate(0, 3*e, -l/2 + 2*e);
    s.addChild(leg2);
    
    atelle.scale(l-2*e, L/4, e/4);
    atelle.translate(0, -L+L/4, l/2+e/1.5);
    s.addChild(atelle);
    
    
    return s;
  }
}
