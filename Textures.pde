// Registre des textures : chaque image n'est chargée qu'une seule fois.
class Textures {
  final int TAILLE_MAX = 2048; // les images plus grandes sont réduites au chargement
  HashMap<String, PImage> cache = new HashMap<String, PImage>();
  PImage blanc;
  PImage[] fondsEcran;

  Textures() {
    blanc = createImage(4, 4, RGB);
    blanc.loadPixels();
    java.util.Arrays.fill(blanc.pixels, color(255));
    blanc.updatePixels();

    fondsEcran = new PImage[] { get("fe1.jpg"), get("f2.png"), get("f3.png"), get("f4.jpg") };
  }

  PImage get(String nom) {
    PImage img = cache.get(nom);
    if (img == null) {
      img = loadImage("Data/images/" + nom);
      if (img == null) {
        println("Texture introuvable : " + nom);
        img = blanc;
      } else if (max(img.width, img.height) > TAILLE_MAX) {
        if (img.width >= img.height) img.resize(TAILLE_MAX, 0);
        else img.resize(0, TAILLE_MAX);
      }
      cache.put(nom, img);
    }
    return img;
  }

  // Texture rendue raccordable : l'image (réduite à `taille` px) est recopiée
  // en miroir sur 2 × 2 cases, les bords se rejoignent donc sans raccord visible.
  PImage getSansRaccord(String nom, int taille) {
    String cle = nom + "#miroir";
    PImage img = cache.get(cle);
    if (img != null) return img;
    PImage src = loadImage("Data/images/" + nom);
    if (src == null) return get(nom);
    if (max(src.width, src.height) > taille) {
      if (src.width >= src.height) src.resize(taille, 0);
      else src.resize(0, taille);
    }
    src.loadPixels();
    int w = src.width, h = src.height;
    img = createImage(2 * w, 2 * h, RGB);
    img.loadPixels();
    for (int y = 0; y < 2 * h; y++) {
      int sy = y < h ? y : 2 * h - 1 - y;
      for (int x = 0; x < 2 * w; x++) {
        int sx = x < w ? x : 2 * w - 1 - x;
        img.pixels[y * 2 * w + x] = src.pixels[sy * w + sx];
      }
    }
    img.updatePixels();
    cache.put(cle, img);
    return img;
  }

  // ---- Tableaux noirs dessinés à la craie au démarrage ----------------------
  PGraphics ardoise(int w, int h) {
    PGraphics pg = createGraphics(w, h);
    pg.beginDraw();
    pg.image(get("tableau.png"), 0, 0, w, h);
    pg.noStroke();
    for (int i = 0; i < 40; i++) { // traces de brosse, adoucies par le flou
      pg.fill(255, 5);
      pg.ellipse(random(w), random(h), random(w * 0.15, w * 0.4), random(h * 0.05, h * 0.12));
    }
    pg.filter(BLUR, 8);
    return pg;
  }

  // Grain de craie : petites taches couleur ardoise sur les tracés.
  PImage finirCraie(PGraphics pg) {
    pg.noStroke();
    for (int i = 0; i < pg.width * pg.height / 60; i++) {
      pg.fill(35, 85, 70, 70);
      pg.rect(random(pg.width), random(pg.height), 2, 2);
    }
    pg.endDraw();
    return pg.get();
  }

  // Tableau central : les commandes du programme et la date du jour.
  PImage tableauCommandes() {
    PGraphics pg = ardoise(1600, 800);
    int craie = color(245, 245, 235, 230), jaune = color(255, 236, 140, 230);
    pg.textFont(createFont("SansSerif.bold", 74, true));
    pg.fill(craie);
    pg.textAlign(LEFT, TOP);
    pg.text("Salle de TP 3D", 90, 60);
    pg.stroke(craie);
    pg.strokeWeight(4);
    pg.line(90, 155, 640, 150);
    pg.noStroke();
    pg.textFont(createFont("SansSerif", 34, true));
    pg.textAlign(RIGHT, TOP);
    pg.text(nf(day(), 2) + "/" + nf(month(), 2) + "/" + year(), 1510, 72);

    String[][] cmd = {
      { "Z Q S D / flèches", "se déplacer" },
      { "clic gauche + glisser", "tourner" },
      { "molette", "avancer / reculer" },
      { "Ctrl + molette", "zoom" },
      { "Espace / Ctrl", "monter / descendre" },
      { "Maj", "courir" },
      { "clic droit ou L", "lumière" },
      { "+ / -", "luminosité" },
      { "H  ·  R  ·  P", "aide · reset · capture" },
    };
    pg.textFont(createFont("SansSerif", 48, true));
    pg.textAlign(LEFT, TOP);
    for (int i = 0; i < cmd.length; i++) {
      int col = i < 5 ? 0 : 1, lig = i < 5 ? i : i - 5;
      float x = 90 + col * 780, y = 200 + lig * 112;
      pg.fill(jaune);
      pg.text(cmd[i][0], x, y);
      pg.fill(craie);
      pg.text("→ " + cmd[i][1], x + 30, y + 50);
    }
    return finirCraie(pg);
  }

  // Volet gauche : croquis d'un cube en perspective avec ses axes.
  PImage tableauCroquis() {
    PGraphics pg = ardoise(800, 960);
    int craie = color(245, 245, 235, 220);
    pg.stroke(craie);
    pg.strokeWeight(5);
    pg.noFill();
    float x0 = 220, y0 = 560, c = 300, dx = 130, dy = -110;
    pg.rect(x0, y0 - c, c, c);
    pg.quad(x0, y0 - c, x0 + dx, y0 - c + dy, x0 + c + dx, y0 - c + dy, x0 + c, y0 - c);
    pg.quad(x0 + c, y0, x0 + c + dx, y0 + dy, x0 + c + dx, y0 - c + dy, x0 + c, y0 - c);
    pg.strokeWeight(3);
    for (float t = 0; t < 1; t += 0.08) { // arêtes cachées en pointillés
      pg.line(x0 + dx * t, y0 + dy * t, x0 + dx * (t + 0.04), y0 + dy * (t + 0.04));
      pg.line(x0 + dx + c * t, y0 + dy, x0 + dx + c * (t + 0.04), y0 + dy);
      pg.line(x0 + dx, y0 + dy - c * t, x0 + dx, y0 + dy - c * (t + 0.04));
    }
    // axes
    pg.strokeWeight(4);
    float ox = 110, oy = 820;
    pg.line(ox, oy, ox + 170, oy);
    pg.line(ox, oy, ox, oy - 170);
    pg.line(ox, oy, ox + 95, oy - 80);
    pg.fill(craie);
    pg.textFont(createFont("SansSerif", 40, true));
    pg.text("x", ox + 185, oy + 12);
    pg.text("y", ox - 10, oy - 185);
    pg.text("z", ox + 105, oy - 90);
    pg.text("V = a³", 480, 830);
    return finirCraie(pg);
  }

  PImage fondAleatoire() {
    return fondsEcran[(int) random(fondsEcran.length)];
  }
}
