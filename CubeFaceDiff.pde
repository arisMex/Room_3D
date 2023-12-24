class CubeFaceDiff {
  float t;
  PImage texture;
  PShape face;

  PShape myCube;

  PShape q1;
  PShape q2; // Copie la face avant
  PShape q3; // Copie la face avant
  PShape q4; // Copie la face avant
  PShape q5; // Copie de la face avant
  PShape q6; // Copie de la face avant

  Quad q;



  CubeFaceDiff(float t, PImage tex, PShape face) {
    this.t = t;
    this.texture = tex;
    this.face = face;
    
    initFaces( face);
    initCube();
  }

  CubeFaceDiff(float t, PShape face) {
    this.t = t;
    this.face = face;
    initFaces( face);
    initCube();
  }
  CubeFaceDiff(PShape face) {
    this.t = 1;
    this.face = face;
    initFaces( face);
    initCube();
  }

  

  PShape getCube() {
    PShape box = createShape(GROUP);

    box.addChild(q1);

    // Face arrière
    q2.rotateY(PI); // Rotation de 180 degrés
    box.addChild(q2);

    // Côté gauche
    PShape q3 = q1.getTessellation(); // Copie la face avant
    q3.rotateY(PI / 2); // Rotation de 90 degrés
    box.addChild(q3);

    // Côté droit
    q4.rotateY( -PI / 2); // Rotation de -90 degrés
    box.addChild(q4);

    // Dessous
    q5.rotateX(PI / 2); // Rotation de 90 degrés
    box.addChild(q5);

    // Dessus

    q6 = q1.getTessellation(); // Copie de la face avantq6.rotateX( -PI / 2);
    box.addChild(q6);

    return box;
  }

  void initCube() {
    myCube = createShape(GROUP);

    myCube.addChild(q1);

    // Face arrière
    q2.rotateY(PI); // Rotation de 180 degrés
    myCube.addChild(q2);

    // Côté gauche
    q3.rotateY(PI / 2); // Rotation de 90 degrés
    myCube.addChild(q3);

    // Côté droit
    q4.rotateY( -PI / 2); // Rotation de -90 degrés
    myCube.addChild(q4);

    // Dessous
    q5.rotateX(PI / 2); // Rotation de 90 degrés
    myCube.addChild(q5);

    // Dessus
    q6.rotateX( -PI / 2); // Rotation de -90 degrés
    myCube.addChild(q6);
  }

  void initFaces(PShape face) {
    q = new Quad(t);
    this.q1 =(q.getQuad());
    this.q2 = face.getTessellation();
    this.q3 = face.getTessellation();
    this.q4 = face.getTessellation();
    this.q5 = face.getTessellation();
    this.q6 = face.getTessellation();
  }

    
  
}
