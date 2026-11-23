// Construit la géométrie statique en regroupant les faces par matériau.
//
// Au lieu de créer un PShape par cube (des milliers d'objets et d'appels de
// dessin), chaque pavé est transformé sur le CPU par la matrice courante puis
// ajouté au lot (PShape QUADS) de son matériau. build() renvoie un GROUP avec
// un enfant par matériau, les matériaux transparents en dernier.
class MeshBuilder {
  // Indices des faces d'un pavé
  static final int HAUT = 0, BAS = 1, AVANT = 2, ARRIERE = 3, GAUCHE = 4, DROITE = 5;

  // Normale sortante et vecteur « haut » de la texture pour chaque face.
  // Repère Processing : y vers le bas ; AVANT = face -z.
  final float[][] NORMALES = { {0, -1, 0}, {0, 1, 0}, {0, 0, -1}, {0, 0, 1}, {-1, 0, 0}, {1, 0, 0} };
  final float[][] HAUTS    = { {0, 0, 1}, {0, 0, 1}, {0, -1, 0}, {0, -1, 0}, {0, -1, 0}, {0, -1, 0} };

  PMatrix3D m = new PMatrix3D();
  ArrayList<PMatrix3D> pile = new ArrayList<PMatrix3D>();
  java.util.LinkedHashMap<Materiau, PShape> lots = new java.util.LinkedHashMap<Materiau, PShape>();
  int nbFaces = 0;

  // ---- Pile de transformations -------------------------------------------
  void push() {
    pile.add(m.get());
  }
  void pop() {
    m = pile.remove(pile.size() - 1);
  }
  void translate(float x, float y, float z) {
    m.translate(x, y, z);
  }
  void rotateX(float a) {
    m.rotateX(a);
  }
  void rotateY(float a) {
    m.rotateY(a);
  }
  void rotateZ(float a) {
    m.rotateZ(a);
  }

  // ---- Primitives ----------------------------------------------------------
  // Pavé centré sur l'origine courante.
  void box(float w, float h, float d, Materiau mt) {
    box(w, h, d, new Materiau[] { mt, mt, mt, mt, mt, mt });
  }

  // Pavé avec un matériau par face (ordre HAUT, BAS, AVANT, ARRIERE, GAUCHE, DROITE).
  // Une face à null n'est pas générée (faces cachées contre un mur, le sol...).
  void box(float w, float h, float d, Materiau[] faces) {
    float[] demi = { w / 2, h / 2, d / 2 };
    for (int f = 0; f < 6; f++) {
      if (faces[f] != null) face(f, demi, faces[f]);
    }
  }

  // Pavé dont seule une face reçoit un matériau particulier, les autres `reste`.
  void box(float w, float h, float d, Materiau reste, int face, Materiau special) {
    Materiau[] f = { reste, reste, reste, reste, reste, reste };
    f[face] = special;
    box(w, h, d, f);
  }

  // Rectangle orienté vers -z (visible depuis l'avant).
  void plan(float w, float h, Materiau mt) {
    Materiau[] f = new Materiau[6];
    f[AVANT] = mt;
    box(w, h, 0, f);
  }

  // Pavé posé : l'origine courante est le centre de sa face inférieure.
  void boxPose(float w, float h, float d, Materiau mt) {
    push();
    translate(0, -h / 2, 0);
    box(w, h, d, mt);
    pop();
  }

  // Demi-ellipsoïde posé sur l'origine (dôme vers le haut), normales lisses.
  // rx, rz : demi-largeurs ; ry : hauteur ; n : nombre d'anneaux.
  void dome(float rx, float ry, float rz, int n, Materiau mt) {
    PShape s = lot(mt);
    int nLon = 4 * n;
    PVector p = new PVector(), w = new PVector();
    for (int i = 0; i < n; i++) {
      for (int j = 0; j < nLon; j++) {
        int[][] coins = { {i, j}, {i, j + 1}, {i + 1, j + 1}, {i + 1, j} };
        for (int[] c : coins) {
          float a = c[0] * HALF_PI / n, b = c[1] * TWO_PI / nLon;
          float ca = cos(a), sa = sin(a), cb = cos(b), sb = sin(b);
          float nx = ca * cb / rx, ny = -sa / ry, nz = ca * sb / rz;
          float len = sqrt(nx * nx + ny * ny + nz * nz);
          nx /= len;
          ny /= len;
          nz /= len;
          s.normal(m.m00 * nx + m.m01 * ny + m.m02 * nz,
            m.m10 * nx + m.m11 * ny + m.m12 * nz,
            m.m20 * nx + m.m21 * ny + m.m22 * nz);
          p.set(rx * ca * cb, -ry * sa, rz * ca * sb);
          m.mult(p, w);
          s.vertex(w.x, w.y, w.z, (float) c[1] / nLon, (float) c[0] / n);
        }
        nbFaces++;
      }
    }
  }

  // ---- Interne -------------------------------------------------------------
  void face(int f, float[] demi, Materiau mt) {
    float[] n = NORMALES[f], up = HAUTS[f];
    float[] r = { n[1] * up[2] - n[2] * up[1], n[2] * up[0] - n[0] * up[2], n[0] * up[1] - n[1] * up[0] };
    float hn = abs(n[0]) * demi[0] + abs(n[1]) * demi[1] + abs(n[2]) * demi[2];
    float hr = abs(r[0]) * demi[0] + abs(r[1]) * demi[1] + abs(r[2]) * demi[2];
    float hu = abs(up[0]) * demi[0] + abs(up[1]) * demi[1] + abs(up[2]) * demi[2];

    float uMax = mt.tuileU > 0 ? 2 * hr / mt.tuileU : 1;
    float vMax = mt.tuileV > 0 ? 2 * hu / mt.tuileV : 1;

    PShape s = lot(mt);
    s.normal(m.m00 * n[0] + m.m01 * n[1] + m.m02 * n[2],
      m.m10 * n[0] + m.m11 * n[1] + m.m12 * n[2],
      m.m20 * n[0] + m.m21 * n[1] + m.m22 * n[2]);

    PVector local = new PVector(), monde = new PVector();
    int[][] coins = { {-1, -1}, {1, -1}, {1, 1}, {-1, 1} }; // (droite, bas)
    for (int[] c : coins) {
      float a = c[0], b = c[1];
      local.set(n[0] * hn + r[0] * a * hr - up[0] * b * hu,
        n[1] * hn + r[1] * a * hr - up[1] * b * hu,
        n[2] * hn + r[2] * a * hr - up[2] * b * hu);
      m.mult(local, monde);
      float u = (a + 1) / 2 * uMax;
      float v = (b + 1) / 2 * vMax;
      if (mt.miroirU) u = uMax - u;
      s.vertex(monde.x, monde.y, monde.z, u, v);
    }
    nbFaces++;
  }

  PShape lot(Materiau mt) {
    PShape s = lots.get(mt);
    if (s == null) {
      s = createShape();
      s.beginShape(QUADS);
      s.textureMode(NORMAL);
      s.noStroke();
      s.texture(mt.tex);
      s.fill(mt.teinte);
      s.tint(mt.teinte); // pour une forme texturée, Processing utilise la teinte (tint)
      s.emissive(color(255 * mt.emission));
      s.specular(color(255 * mt.speculaire));
      s.shininess(mt.brillance);
      lots.put(mt, s);
    }
    return s;
  }

  PShape build() {
    PShape groupe = createShape(GROUP);
    ArrayList<PShape> transparents = new ArrayList<PShape>();
    for (Materiau mt : lots.keySet()) {
      PShape s = lots.get(mt);
      s.endShape();
      if (mt.transparent()) transparents.add(s);
      else groupe.addChild(s);
    }
    for (PShape s : transparents) groupe.addChild(s);
    lots.clear();
    return groupe;
  }
}
