PShape cube;
Table tableModel;
PShape rangee;
PShape  table;
PShape  table2;

PShader colorShader;
PImage tex;
PImage texTable;

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
  
void setup() {
  size(600, 600, P3D);
  tex = loadImage("Data/images/toit.jpg");
  texTable = loadImage("Data/images/table.jpg");
   textureMode(NORMAL);
  Cube cu = new Cube(100);
  Quad q = new Quad(100, tex);
  CubeFaceDiff cfd = new CubeFaceDiff(100, q.getQuad());
  cube = cu.getCube();
  
  tableModel = new Table(l,L,h,e,tex);
  table = tableModel.getTable();
  rangee = (new RangeeTables(3, 1, l,L,h,e,texTable)).getRangee();
  colorShader = loadShader("Data/LightShaderTexFrag.glsl", "Data/LightShaderTexVert.glsl");
}

void draw() {
  background(255);
  bougerCamera();
  camera(camX, camY, camZ, 0, 0, 0, 0, 1, 0);
if (mousePressed) {
    textureWrap(REPEAT); 
  } else {
    textureWrap(CLAMP);
  }
  shader(colorShader);
  //shape(cube);
  shape(rangee);
}

void bougerCamera() {
  camX = rayon * cos(phi) * sin(theta);
  camY = rayon * sin(phi);
  camZ = rayon * cos(phi) * cos(theta);

  theta += 0.01;
  phi   = -0.5;   
}
