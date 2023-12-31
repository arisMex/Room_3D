class Fenetre {
  float l;
  float h;
  float eZ= 10;
  float e = 5;
  color c = color(192, 192, 197);
  PImage texture;

  Fenetre(float h, float l,  PImage tex) {
    this.h = h;
    this.l = l;
    this.texture = tex;
  }


  PShape getFenetre() {
    PShape cadre = getCadre();
    //PShape prt = getPrt();

    PShape s = createShape(GROUP);
    s.addChild(cadre);
    //s.addChild(prt);
    return s;
  }


  PShape getCadre() {
    PShape[] cad  =new PShape[7];
    PShape[] vitres  = new PShape[4];
    for (int i = 0; i < 7; ++i) {
      cad[i] = (new Cube(texPorte)).getCube();
    }
    
    for (int i = 0; i < 4; ++i) {
      vitres[i] = (new Cube(color(255,255,255,30))).getCube();
    }
    
    
    PShape s = createShape(GROUP);

    //haut
    cad[0].scale(l+2*e, e, eZ);
    cad[0].translate(0, -h/2-e/2, 0);
    s.addChild(cad[0]);
    
    cad[3].scale(l+2*e, e, eZ);
    cad[3].translate(0, h/2+e/2, 0);
    s.addChild(cad[3]);
    
    cad[4].scale(l+2*e, e, eZ);
    cad[4].translate(0, -h/4-e/2, 0);
    s.addChild(cad[4]);

    cad[1].scale(e, h+e/2, eZ);
    cad[1].translate(l/2 + e/2, 0, 0);
    s.addChild(cad[1]);

    cad[2].scale(e, h+e/2, eZ);
    cad[2].translate(-l/2 - e/2, 0, 0);
    s.addChild(cad[2]);
    
    cad[5].scale(e , h*3/4+e/2, eZ);
    cad[5].translate(l/6 + e/2,h/8 , 0);
    s.addChild(cad[5]);
    
    cad[6].scale(e, h/4+e/2, eZ);
    cad[6].translate(-l/6 - e/2,-h*3/8 - e/2 , 0);
    s.addChild(cad[6]);
    
    
    vitres[1].scale(l/3, h/4, eZ);
    vitres[1].translate(-l/3 - e/2, -h*3/8 - e/2 , 0);
    s.addChild(vitres[1]);
    
    vitres[2].scale(l*2/3, h/4, eZ);
    vitres[2].translate(l/6, -h*3/8 - e/2 , 0);
    s.addChild(vitres[2]);
    
    vitres[3].scale(l/3, h*2/3+ 3*e, eZ);
    vitres[3].translate(l/3 ,  h/12+e*1.5 , 0);
    s.addChild(vitres[3]);
    
    vitres[0].scale(l*2/3, h*2/3+3*e, eZ);
    vitres[0].translate(-l/6, h/12+1.5*e , 0);
    s.addChild(vitres[0]);


    return s;
  }



  PShape getSerrure() {
    color c2 = color(0, 0, 0);
    PShape p1 = (new Cube(c2)).getCube();
    PShape p2 = (new Cube(c2)).getCube();
    PShape p3 = (new Cube(c2)).getCube();
    PShape p4 = (new Cube(c2)).getCube();
    PShape p5 = (new Cube(c2)).getCube();
    PShape p6 = (new Cube(c2)).getCube();


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
