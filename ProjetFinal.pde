PShape cube;
Table tableModel;
PShape rangee;
PShape  table;
PShape  table2;
PShape salle;


PShader colorShader;
PImage tex, texTable, texSol, texPlafond;

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

int longueur =978 , largeur= 594, hauteur= 278 ;

void setup() {
  size(800, 800, P3D);
  tex = loadImage("Data/images/mur.jpg");
  texTable = loadImage("Data/images/table.jpg");
  texSol = loadImage("Data/images/sol.jpg");
  texPlafond = loadImage("Data/images/toit.jpg");

  textureMode(NORMAL);
  //tableModel = new Table(l, L, h, e, texTable);
  salle = (new Salle(longueur, largeur, hauteur, tex, texSol, texPlafond)).getSalle();
  

  //table = tableModel.getTable();
  //rangee = (new RangeeTables(3, 4, l, L, h, e, texTable)).getRangees();
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
  shader(colorShader);
  //shape(cube);
 // shape(rangee);
  shape(salle);
}

void bougerCamera() {
  camX = rayon * cos(phi) * sin(theta);
  camY = rayon * sin(phi);
  camZ = rayon * cos(phi) * cos(theta);

  theta += 0.01;
  phi   = 0.5;
}
