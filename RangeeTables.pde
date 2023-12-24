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
    this.nbRangees = nbRan;
  }
  
   PShape getRangee() {
    PShape s = createShape(GROUP);
    PShape[] tables  =new PShape[nbTables];
    
    for(int i = 0; i<nbTables; i++){
      tables[i] = (new Table(l, L, H, e, texture)).getTable();
      tables[i].translate(i*L, 0, 0);
      s.addChild(tables[i]);
    
    }
    return s;
   
   }

 PShape getRangees() {
    PShape s = createShape(GROUP);
    PShape[] rangee  =new PShape[nbRangees];
    
    for(int i = 0; i<nbRangees; i++){
      rangee[i] = getRangee();
      rangee[i].translate(0, 0, i*2*l);
      s.addChild(rangee[i]);
    
    }
   
    return s;
   
   }




}
