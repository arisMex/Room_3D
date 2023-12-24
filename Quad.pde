class Quad{
  PShape quad;
  float taille;
  
  Quad(float t) {
   this.taille = t;
    quad = createShape();
    quad.beginShape();
    quad.noFill();
    quad.stroke(255);
    quad.vertex( - taille / 2, -taille / 2, -taille / 2);
    quad.vertex(taille / 2, -taille / 2, -taille / 2);
    quad.vertex(taille / 2, taille / 2, -taille / 2);
    quad.vertex( - taille / 2, taille / 2, -taille / 2);
    quad.endShape(CLOSE);
   
  }

    Quad(float t, PImage tex) {
   this.taille = t;
    quad = createShape();
    quad.beginShape();
    quad.texture(tex);
    quad.shininess(200.0);
    quad.emissive(0, 0, 0);
    quad.normal(0, 0, 1);
    quad.noFill();
    quad.stroke(255);
    quad.vertex( - taille / 2, -taille / 2, -taille / 2);
    quad.vertex(taille / 2, -taille / 2, -taille / 2);
    quad.vertex(taille / 2, taille / 2, -taille / 2);
    quad.vertex( - taille / 2, taille / 2, -taille / 2);
    quad.endShape(CLOSE);
   
  }

   Quad() {
   this.taille = 1;
    quad = createShape();
    quad.beginShape();
    
    quad.noFill();
    quad.stroke(255);
    quad.vertex( - taille / 2, -taille / 2, -taille / 2);
    quad.vertex(taille / 2, -taille / 2, -taille / 2);
    quad.vertex(taille / 2, taille / 2, -taille / 2);
    quad.vertex( - taille / 2, taille / 2, -taille / 2);
    quad.endShape(CLOSE);
   
  }
  
  PShape getQuad(){
    return this.quad;
  }
}
