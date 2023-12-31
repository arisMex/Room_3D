PShape salle;


PShader colorShader;
PImage tex, texTable, texSol, texPlafond, texTbleau, texPorte, texUcFace, texUcDos, texUcCote, texClavier, textureChaise, texDosEcran;
PImage[] fondEcran;

float rayon = 200;
float theta = 0;
float phi = 0;
float camX = 0;
float camY = 0;
float camZ = 0;


float l = 80;
float L= 160;
float h = 73;
float e = 3;

int longueur =978, largeur= 594, hauteur= 278 ;

void setup() {
  size(1000, 800, P3D);
  tex = loadImage("Data/images/mur.jpg");
  texTable = loadImage("Data/images/table.jpg");
  texSol = loadImage("Data/images/sol.jpg");
  texPlafond = loadImage("Data/images/toit.jpeg");
  texTbleau = loadImage("Data/images/tableau.png");
  texPorte = loadImage("Data/images/texturePorte.png");
  texUcFace= loadImage("Data/images/ucFace.png");
  texUcDos =loadImage("Data/images/ucDos.png");
  texUcCote = loadImage("Data/images/ucCote.png");
  texClavier = loadImage("Data/images/clavier.png");
  textureChaise = loadImage("Data/images/chaise.png");
  texDosEcran = loadImage("Data/images/dosEcran.png");


  fondEcran = new PImage[4];
  fondEcran[0] = loadImage("Data/images/fe1.jpg");
  fondEcran[1] = loadImage("Data/images/f2.png");
  fondEcran[2] = loadImage("Data/images/f3.png");
  fondEcran[3] = loadImage("Data/images/f4.jpg");


  textureMode(NORMAL);
  salle = (new Salle(longueur, largeur, hauteur, tex, texSol, texPlafond)).getSalle();

  colorShader = loadShader("Data/LightShaderTexFrag.glsl", "Data/LightShaderTexVert.glsl");
}
void draw() {
  background(0);
  bougerCamera();
  camera(camX, camY, camZ, 0, 0, 0, 0, 1, 0);

  if (mousePressed) {
    textureWrap(REPEAT);
  } else {
    textureWrap(CLAMP);
  }
  
       //pointLight(255, 255, 255, -longueur/2, -hauteur/2, 0);
       //pointLight(255, 255, 255, -largeur/4, 0, 0);
       //pointLight(255, 255, 255, -largeur/4, 0, 0);
      //box(20,20,20);
      //pointLight(200, 200, 0,largeur/2,hauteur/2,longueur/2 );
     // pointLight(200, 200, 0,width/2,height/2,longueur/2 );
  
  shader(colorShader);
  pushMatrix();
  translate(largeur/2, 0, 0);
  shape(salle);
  popMatrix();
}

void bougerCamera() {
  float sensitivity = 0.01;

  // Rotation de la caméra avec la souris
  if (mousePressed) {
    theta += sensitivity * (pmouseX - mouseX);
    phi += sensitivity * (pmouseY - mouseY);
  }

  // Zoom avec le scroll
  //rayon -= 0.1 * mouseWheel(); // Ajustez la valeur selon la sensibilité souhaitée
  rayon = constrain(rayon, 200, 1000);

  // Conversion des coordonnées sphériques en coordonnées cartésiennes
  camX = rayon * cos(phi) * sin(theta);
  camY = rayon * sin(phi);
  camZ = rayon * cos(phi) * cos(theta);
}
