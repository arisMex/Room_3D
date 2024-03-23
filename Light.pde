class Light {

  PVector[] lightPos = {
    new PVector( largeur/4, -hauteur/2+20, -longueur/4),
    new PVector( -largeur/4, -hauteur/2+20, -longueur/4),
    new PVector( -largeur/4, -hauteur/2 +20, longueur *(2/3)),
    new PVector( largeur/4, -hauteur/2+20, longueur*(2/3)),
    new PVector( largeur/4, -hauteur/2 +20, longueur/4),
    new PVector( -largeur/4, -hauteur/2+20, longueur/4),
  };

  PVector[] lightColor = {
    new PVector(200, 200, 200),
    new PVector(200, 200, 200),
    new PVector(200, 200, 200),
    new PVector(200, 200, 200),
    new PVector(200, 200, 200),
    new PVector(200, 200, 200),
  };

  void setLight() {

    emissive(lightColor[0].x, lightColor[0].y, lightColor[0].z);
    ambientLight(20, 20, 20);
    noStroke();
    fill(255);
    for (int i = 0; i < lightPos.length; i++) {
      pushMatrix();
      translate(lightPos[i].x-21, lightPos[i].y -21, lightPos[i].z -21);
      scale(0.3, 0.1, 0.5);
      box(150);

      lightSpecular(lightColor[i].x, lightColor[i].y, lightColor[i].z);
      pointLight(lightColor[i].x, lightColor[i].y, lightColor[i].z,
        lightPos[i].x, lightPos[i].y, lightPos[i].z);

      popMatrix();
    }
    
  }
}
