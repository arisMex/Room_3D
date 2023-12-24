class RangeeTables {
  float l;
  float L;
  float H;
  float e;
  PImage texture;
  int nbTables;
  int nbRangees;
  int distanceEntreRangees;

  Cube cube;
  PShape plan;

  RangeeTables(int nbTab, int nbRan, float l, float L, float H, float e, PImage tex) {
    this.L = L;
    this.l = l;
    this.H = H;
    this.e = e;
    this.texture = tex;
    this.nbTables = nbTab;
    this.texture = tex;    
    this.nbTables = nbTables;
    this.nbRangees = nbRan;


  }
  
   PShape getRangee() {
    PShape s = createShape(GROUP);
    PShape[] tables  =new PShape[nbTables];
    
    for(int i = 0; i<nbTables; i++){
      tables[0] = (new Table(l, L, H, e, tex)).getTable();
      tables[0].translate(i*L, 0, 0);
      s.addChild(tables[0]);
    
    }
    
   
    return s;
   
   }





}
