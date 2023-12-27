class Clavier  {
    float l;
    float h;
    float L;
    PImage texFace, texCote;

    public Clavier (float L , float l, float h , PImage texFace,PImage texCote ) {
        this.L = L;
        this.l = l ;
        this.h = h ;
        this.texFace = texFace;
        this.texCote = texCote;
    }

    PShape getClavier() {
        PShape clav = (new  Cube( -1, -1, -1, -1, -1, -1, texCote ,  texCote,  texFace,  texCote,  texCote,  texCote)).getCube();
        clav.scale(L, h, l);
        clav.rotateY(PI);
        return clav;
    }
    

}
