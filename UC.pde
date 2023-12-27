class UC  {
    float l;
    float h;
    float L;
    PImage texFace, texDos, texCote;

    public UC (float L , float l, float h , PImage texFace,PImage texDos,PImage texCote ) {
        this.L = L;
        this.l = l ;
        this.h = h ;
        this.texFace = texFace;
        this.texDos = texDos;
        this.texCote = texCote;
    }

    PShape getUC() {
        PShape uc = (new  Cube( -1, -1, -1, -1, -1, -1, texCote ,  texFace,  texDos,  texCote,  texCote,  texCote)).getCube();
        uc.scale(l, h, L);
        return uc;
    }
    

}
