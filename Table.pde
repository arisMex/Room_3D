class Table {
  float l;
  float L;
  float H;
  float e;
  PImage texture;

  Cube cube;
  PShape plan;

  Table(float l, float L, float H, float e, PImage tex) {
    this.L = L;
    this.l = l;
    this.H = H;
    this.e = e;
    this.texture = tex;

    cube = new Cube();
    plan = cube.getCube();
    plan.scale(L, l, e);
    plan.rotateX(PI / 2);
  }

  Table(float l, float L, float H, float e) {
    this.L = L;
    this.l = l;
    this.H = H;
    this.e = e;

    cube = new Cube();
  }

  PShape getTable() {
    PShape s = createShape(GROUP);
    PShape[] legs  =new PShape[4];
    
    legs[0] = getLeg();
    legs[0].translate(L/2-2*e, H/2 + e, l/2-2*e);
    s.addChild(legs[0]);
    
    legs[1] = getLeg();
    legs[1].translate(-L/2+2*e, H/2 + e, l/2-2*e);
    s.addChild(legs[1]);
    
    legs[2] = getLeg();
    legs[2].translate(-L/2+2*e, H/2 + e, -l/2+2*e);
    s.addChild(legs[2]);
    
    legs[3] = getLeg();
    legs[3].translate(L/2-2*e, H/2 + e, -l/2+2*e);
    s.addChild(legs[3]);
  
    s.addChild(plan);
    
    return s;
  }


  PShape getLeg() {
    color c = color(0,0,0);
    PShape leg = (new Cube(c)).getCube();
    leg.scale(e, H, e);
    leg.beginShape(QUADS);
    leg.texture(texture);

    leg.endShape(CLOSE);

    return leg;
  }
}
