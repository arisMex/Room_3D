// Un matériau = texture + teinte + paramètres d'éclairage.
// Les matériaux sont partagés : MeshBuilder regroupe toutes les faces d'un même
// matériau dans un seul PShape (un seul appel de dessin).
class Materiau {
  PImage tex;
  int teinte = 0xFFFFFFFF;
  float tuileU = 0, tuileV = 0; // taille (cm) d'une répétition de texture ; 0 = étirée
  boolean miroirU = false;
  float emission = 0;           // 0..1 : auto-illumination (écrans, lampes, extérieur)
  float speculaire = 0.08;
  float brillance = 8;

  Materiau(PImage tex) {
    this.tex = tex;
  }

  Materiau teinte(int c) {
    teinte = c;
    return this;
  }
  Materiau tuile(float u, float v) {
    tuileU = u;
    tuileV = v;
    return this;
  }
  Materiau miroir() {
    miroirU = true;
    return this;
  }
  Materiau emission(float e) {
    emission = e;
    return this;
  }
  Materiau brillant(float spec, float shin) {
    speculaire = spec;
    brillance = shin;
    return this;
  }
  boolean transparent() {
    return alpha(teinte) < 255;
  }
}

// Tous les matériaux de la scène, créés une seule fois.
class Materiaux {
  Textures t;
  Materiau mur, sol, plafond, plinthe, exterieur;
  Materiau plateauTable, metal, metalClair, bois, plastiqueNoir, plastiqueGris;
  Materiau porte, poignee, cadreFenetre, vitre, appui;
  Materiau tableauVolet, tableauCroquis, tableauCentre, cadreTableau, craie, brosse;
  Materiau ucFace, ucDos, ucCote, clavier, dosEcran;
  Materiau alu, couvercleMac, radiateur, radiateurCote;
  Materiau lampeAllumee, lampeEteinte, cadreLampe;
  HashMap<PImage, Materiau> ecrans = new HashMap<PImage, Materiau>();

  Materiaux(Textures t) {
    this.t = t;
    mur = new Materiau(t.getSansRaccord("mur.jpg", 1024)).tuile(320, 320);
    sol = new Materiau(t.getSansRaccord("sol.jpg", 1024)).tuile(640, 434).teinte(color(196, 184, 178)).brillant(0.15, 20);
    plafond = new Materiau(t.get("toit.jpeg")).tuile(240, 240).emission(0.32); // lumière indirecte
    plinthe = new Materiau(t.get("plinthe.png")).tuile(45, 0);
    exterieur = new Materiau(t.get("exter.jpg")).emission(1.0).teinte(color(0));

    plateauTable = new Materiau(t.get("table.jpg")).tuile(160, 0).brillant(0.25, 30);
    metal = new Materiau(t.blanc).teinte(color(28, 28, 30)).brillant(0.5, 40);
    metalClair = new Materiau(t.blanc).teinte(color(185, 188, 192)).brillant(0.6, 50);
    bois = new Materiau(t.get("chaise.png")).brillant(0.2, 20);
    plastiqueNoir = new Materiau(t.blanc).teinte(color(22, 22, 24)).brillant(0.45, 40);
    plastiqueGris = new Materiau(t.blanc).teinte(color(60, 62, 66)).brillant(0.2, 20);

    porte = new Materiau(t.get("texturePorte.png")).brillant(0.15, 16);
    poignee = new Materiau(t.blanc).teinte(color(30)).brillant(0.8, 60);
    cadreFenetre = new Materiau(t.get("texturePorte.png")).brillant(0.15, 16);
    vitre = new Materiau(t.blanc).teinte(color(200, 225, 240, 38)).brillant(0.9, 80);
    appui = new Materiau(t.blanc).teinte(color(225, 225, 222)).brillant(0.2, 20);

    tableauCentre = new Materiau(t.tableauCommandes()).brillant(0.12, 12);
    tableauCroquis = new Materiau(t.tableauCroquis()).brillant(0.12, 12);
    tableauVolet = new Materiau(t.ardoise(800, 960).get()).brillant(0.12, 12);
    cadreTableau = new Materiau(t.blanc).teinte(color(178, 182, 188)).brillant(0.6, 50);
    craie = new Materiau(t.blanc).teinte(color(240, 240, 232));
    brosse = new Materiau(t.blanc).teinte(color(70, 50, 35)).brillant(0.2, 20);

    ucFace = new Materiau(t.get("ucFace.png")).brillant(0.3, 30);
    ucDos = new Materiau(t.get("ucDos.png")).brillant(0.3, 30);
    ucCote = new Materiau(t.blanc).teinte(color(30, 30, 32)).brillant(0.3, 30);
    clavier = new Materiau(t.get("clavier.png")).brillant(0.2, 20);
    dosEcran = new Materiau(t.get("dosEcran.png")).teinte(color(95)).brillant(0.3, 30);

    alu = new Materiau(t.blanc).teinte(color(196, 198, 202)).brillant(0.6, 50);
    couvercleMac = new Materiau(t.get("amc.png")).brillant(0.6, 50);
    radiateur = new Materiau(t.get("radiateur.png")).brillant(0.3, 30);
    radiateurCote = new Materiau(t.blanc).teinte(color(232, 232, 230));

    lampeAllumee = new Materiau(t.blanc).teinte(color(0)).emission(1.0);
    lampeEteinte = new Materiau(t.blanc).teinte(color(170, 172, 178)).brillant(0.4, 30);
    cadreLampe = new Materiau(t.blanc).teinte(color(210)).brillant(0.3, 20);
  }

  // Un matériau d'écran par fond d'écran (lumineux).
  Materiau ecran(PImage fond) {
    Materiau m = ecrans.get(fond);
    if (m == null) {
      m = new Materiau(fond).teinte(color(60)).emission(0.85).brillant(0.6, 60);
      ecrans.put(fond, m);
    }
    return m;
  }
}
