class Cube{
    float t;
    PImage texture;
    color c = -1 ;
    
    
    Cube(float t,  PImage tex) {
        this.t = t;
        this.texture = tex;
    }
    
    Cube(float t) {
        this.t = t;
    }
    Cube() {
        this.t = 1;
    }
    
    Cube(color c) {
        this.c = c;
    }
    
    PShape getCube() {
        PShape s = createShape();
        float c = t / 2;
        
        s.beginShape(QUADS);
        if(texture != null)s.texture(texture);
        if(c >1)fill(c);
        s.shininess(200.0);
        s.emissive(0, 0, 0);
        s.normal(0, 0, 1);
        
        s.noStroke();
        
        //front
        //s.fill(color(255, 0, 0));
        s.vertex( - c, -c, -c, 0, 0);
        s.vertex(c, -c, -c, 0, 1);
        s.vertex(c, c, -c, 1, 1);
        s.vertex( - c, c, -c, 1, 0);
        
        //arriere
        //s.fill(color(0, 255, 0));
        s.vertex(c, -c, c, 0, 0);
        s.vertex( - c, -c, c, 0, 1);
        s.vertex( - c, c, c, 1, 1);
        s.vertex(c, c, c, 1, 0);
        
        //top
        //s.fill(color(164, 98, 185));
        s.vertex( - c, -c, -c, 0, 0);
        s.vertex(c, -c, -c, 0, 1);
        s.vertex(c, -c, c, 1, 1);
        s.vertex( - c, -c, c, 1, 0);
        
        //bottom
        //s.fill(color(225, 50, 0));
        s.vertex( - c, c, -c, 0, 0);
        s.vertex(c, c, -c, 0, 1);
        s.vertex(c, c, c, 1, 1);
        s.vertex( - c, c, c, 1, 0);
        
        //left
        //s.fill(color(225, 50, 100));
        s.vertex( - c, -c, -c, 0, 0);
        s.vertex( - c, c, -c, 0, 1);
        s.vertex( - c, c, c, 1, 1);
        s.vertex( - c, -c, c, 1, 0);
        
        //right
        //s.fill(color(253, 233, 88));
        s.vertex(c, -c, -c, 0, 0);
        s.vertex(c, c, -c, 0, 1);
        s.vertex(c, c, c, 1, 1);
        s.vertex(c, -c, c, 1, 0);
        
        s.endShape(CLOSE);
        
        return s;
    }
        
        
}
