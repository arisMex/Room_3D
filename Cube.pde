class Cube {
  float t=1;
  PImage texture = null, texture1=null, texture2=null, texture3=null, texture4=null, texture5=null, texture6=null;
  color c = 0, c1 = -1, c2 = -1, c3 = -1, c4 = -1, c5 = -1, c6 = -1 ;



  Cube( color c1, color c2, color c3, color c4, color c5, color c6, PImage tex1, PImage tex2, PImage tex3, PImage tex4, PImage tex5, PImage tex6) {
    this.t = 1;
    this.texture1 = tex1;
    this.texture2 = tex2;
    this.texture3 = tex3;
    this.texture4 = tex4;
    this.texture5 = tex5;
    this.texture6 = tex6;
    this.c1 = c1;
    this.c2 = c2;
    this.c3 = c3;
    this.c4 = c4;
    this.c5 = c5;
    this.c6 = c6;
  }

  Cube(float t) {
    this.t = t;
    this.t = 1;
  }
  Cube(color c) {
    this.c = c;
    this.t = 1;
  }
  Cube(PImage t) {
    this.texture = t;
    this.t = 1;
  }
  Cube(PImage t, boolean rep) {
    if (rep)textureWrap(REPEAT);

    this.texture = t;
    this.t = 1;
  }
  Cube() {
    this.t = 1;
  }



  PShape getCube() {
    PShape s = createShape();
    float c = t / 2;

    s.beginShape(QUADS);
    s.shininess(200.0);
    s.emissive(0, 0, 0);
    s.normal(0, 0, 1);
    s.noStroke();

    // Top
    applyTextureOrFill(s, texture1, c1, texture, this.c);
    vertexWithTexture(s, -c, -c, -c, 0, 0);
    vertexWithTexture(s, c, -c, -c, 1, 0);
    vertexWithTexture(s, c, -c, c, 1, 1);
    vertexWithTexture(s, -c, -c, c, 0, 1);

    // Front
    applyTextureOrFill(s, texture2, c2, texture, this.c);
    vertexWithTexture(s, -c, -c, -c, 0, 0);
    vertexWithTexture(s, c, -c, -c, 1, 0);
    vertexWithTexture(s, c, c, -c, 1, 1);
    vertexWithTexture(s, -c, c, -c, 0, 1);

    // Back
    applyTextureOrFill(s, texture3, c3, texture, this.c);
    vertexWithTexture(s, c, -c, c, 0, 0);
    vertexWithTexture(s, -c, -c, c, 1, 0);
    vertexWithTexture(s, -c, c, c, 1, 1);
    vertexWithTexture(s, c, c, c, 0, 1);

    // Bottom
    applyTextureOrFill(s, texture4, c4, texture, this.c);
    vertexWithTexture(s, -c, c, -c, 0, 0);
    vertexWithTexture(s, c, c, -c, 1, 0);
    vertexWithTexture(s, c, c, c, 1, 1);
    vertexWithTexture(s, -c, c, c, 0, 1);

    // Left
    applyTextureOrFill(s, texture5, c5, texture, this.c);
    vertexWithTexture(s, -c, -c, -c, 0, 0);
    vertexWithTexture(s, -c, c, -c, 1, 0);
    vertexWithTexture(s, -c, c, c, 1, 1);
    vertexWithTexture(s, -c, -c, c, 0, 1);

    // Right
    applyTextureOrFill(s, texture6, c6, texture, this.c);
    vertexWithTexture(s, c, -c, -c, 0, 0);
    vertexWithTexture(s, c, c, -c, 1, 0);
    vertexWithTexture(s, c, c, c, 1, 1);
    vertexWithTexture(s, c, -c, c, 0, 1);

    s.endShape(CLOSE);

    return s;
  }

  void applyTextureOrFill(PShape s, PImage tex, color c, PImage defaultTex, color defaultColor) {
    if (tex != null) {
      s.texture(tex);
    } else if (c != -1) {
      s.fill(c);
    } else if (defaultTex != null) {
      s.texture(defaultTex);
    } else {
      s.fill(defaultColor);
    }
  }

  void vertexWithTexture(PShape s, float x, float y, float z, float u, float v) {
    s.vertex(x, y, z, u, v);
  }
}
