class Souris  {
    float l;
    float h;
    float L;
    PImage texFace, texDos, texCote;

    public Souris (float L , float l, float h  ) {
        this.L = L;
        this.l = l ;
        this.h = h ;
        texFace = texRadiateur;
    }

    PShape getSouris() {
        PShape uc = (new  Cube( -1, -1, -1, -1, -1, -1, texCote ,  texFace,  texDos,  texCote,  texCote,  texCote)).getCube();
        uc.scale(l, h, L);
        return uc;
    }
    

}
