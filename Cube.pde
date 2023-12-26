class Cube {
  float t=1;
  PImage texture = null, texture1=null, texture2=null, texture3=null, texture4=null, texture5=null, texture6=null;
  color c = -1, c1 = -1, c2 = -1, c3 = -1, c4 = -1, c5 = -1, c6 = -1 ;



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

    //top

    if (texture1 != null)
      s.texture(texture1);
    else if (c1 != -1)
      s.fill(c1);
    else if (texture != null)
      s.texture(texture);
    else
      s.fill(0);
    //s.fill(color(164, 98, 185));
    s.vertex( - c, -c, -c, 0, 0);
    s.vertex(c, -c, -c, 0, 1);
    s.vertex(c, -c, c, 1, 1);
    s.vertex( - c, -c, c, 1, 0);

    //front
    //s.fill(color(255, 0, 0));
    if (texture2 != null)
      s.texture(texture2);
    else if (c2 != -1)
      s.fill(c2);
    else if (texture != null)
      s.texture(texture);
    else
      s.fill(0);
    s.vertex( - c, -c, -c, 0, 0);
    s.vertex(c, -c, -c, 0, 1);
    s.vertex(c, c, -c, 1, 1);
    s.vertex( - c, c, -c, 1, 0);

    //arriere
    if (texture3 != null)
      s.texture(texture3);
    else if (c3 != -1)
      s.fill(c3);
    else if (texture != null)
      s.texture(texture);
    else
      s.fill(0);
    //s.fill(color(0, 255, 0));
    s.vertex(c, -c, c, 0, 0);
    s.vertex( - c, -c, c, 0, 1);
    s.vertex( - c, c, c, 1, 1);
    s.vertex(c, c, c, 1, 0);



    //bottom
    if (texture4 != null)
      s.texture(texture4);
    else if (c4 != -1)
      s.fill(c4);
    else if (texture != null)
      s.texture(texture);
    else
      s.fill(0);
    //s.fill(color(225, 50, 0));
    s.vertex( - c, c, -c, 0, 0);
    s.vertex(c, c, -c, 0, 1);
    s.vertex(c, c, c, 1, 1);
    s.vertex( - c, c, c, 1, 0);

    //left
    if (texture5 != null)
      s.texture(texture5);
    else if (c5 != -1)
      s.fill(c5);
    else if (texture != null)
      s.texture(texture);
    else
      s.fill(0);
    //s.fill(color(225, 50, 100));
    s.vertex( - c, -c, -c, 0, 0);
    s.vertex( - c, c, -c, 0, 1);
    s.vertex( - c, c, c, 1, 1);
    s.vertex( - c, -c, c, 1, 0);

    //right
    if (texture6 != null)
      s.texture(texture6);
    else if (c6 != -1)
      s.fill(c6);
    else if (texture != null)
      s.texture(texture);
    else
      s.fill(0);
    //s.fill(color(253, 233, 88));
    s.vertex(c, -c, -c, 0, 0);
    s.vertex(c, c, -c, 0, 1);
    s.vertex(c, c, c, 1, 1);
    s.vertex(c, -c, c, 1, 0);

    s.endShape(CLOSE);

    return s;
  }
}
