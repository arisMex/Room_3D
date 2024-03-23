class Radiateur {
  float l;
  float L;
  float H;
  float e;
  PImage texture;

  Cube cube;
  PShape plan;

  Radiateur(float l, float H, float e, PImage tex) {
    this.L = L;
    this.l = l;
    this.H = H;
    this.e = e;
    this.texture = tex;

    cube = new Cube(color(-1), color(0), color(0), color(0), color(0), color(0), texture, null, null, null, null, null);//par def 

    plan = cube.getCube();
    plan.scale(L, l, e);
    plan.rotateX(PI / 2);
  }

  Radiateur(float l, float L, float H, float e) {
    this.L = L;
    this.l = l;
    this.H = H;
    this.e = e;
    cube = new Cube();
  }

  PShape getRadiateur() {
    PShape s = createShape(GROUP);
    PShape rad  =  (new Cube(texRadiateur)).getCube();
    rad.scale(l, h, e);
    s.addChild(rad);
    return s;
  }


  PShape getRadiateurs(int  nb) {
    PShape s = createShape(GROUP);
    PShape[] rads  =new PShape[nb];
    for (int i = 0; i<nb; i++) {
      rads[i] = (new Radiateur(l, h, e, texture)).getRadiateur();
      rads[i].translate(i*l, 0, 0);
      s.addChild(rads[i]);
    }
    return s;
  }
}
