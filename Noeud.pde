final int NOEUD = 0;
final int VISITE = 1;
final int SPORE = 2;
final int NOPE = 6;
final int COURONNE = 3;
final int LARGEUR = 38;
final int LONGUEURE = 44;

public class Noeud {

  private float x, y;
  private int id, time, distance;
  private ArrayList<Arrete> arretes;
  private int etat; //0 noeud, 1 visite, 2 spore, 3 couronne;
  private Noeud precedent;

  public Noeud(float x, float y, int id, int time) {
    this.x = x;
    this.y = y;
    this.id = id;
    this.etat = NOEUD;
    this.time = time;
    this.arretes = new ArrayList<>();
    this.distance = Integer.MAX_VALUE;
    this.precedent = null;
  }

  public void setX(float x) {
    this.x = x;
  }

  public void setY(float y) {
    this.y = y;
  }

  public int getId() {
    return this.id;
  }

  public float getX() {
    return this.x;
  }

  public float getY() {
    return this.y;
  }

  public int getTime() {
    return this.time;
  }

  public void dessiner() {
    switch(etat) {
    case NOEUD:
      fill(0, 0, 0);
      break;
    case VISITE:
      fill(255, 255, 0);
      break;
    case SPORE:
      fill(255, 0, 0);
      break;
    case COURONNE:
      fill(0, 255, 0);
      break;

    case NOPE:
      fill(200);
      break;
    }
    noStroke();
    ellipse(x, y, 3, 3);


    for (Arrete a : arretes) {
      a.dessiner();
    }
  }

  public void addArrete(Arrete arrete) {
    this.arretes.add(arrete);
  }

  public ArrayList<Arrete> getArretes() {
    return this.arretes;
  }

  public int getDegre() {
    return this.arretes.size();
  }

  public int getEtat() {
    return this.etat;
  }

  public void setEtat(int etat) {
    this.etat = etat;
  }

  public int getDistance() {
    return this.distance;
  }

  public void setDistance(int distance) {
    this.distance = distance;
  }

  public ArrayList<Noeud> getVoisins() {
    ArrayList<Noeud> voisins = new ArrayList<>();
    for (Arrete a : arretes) {
      Noeud n = a.getAutreNoeud(this);
      voisins.add(n);
    }
    return voisins;
  }

  public boolean voisinageVisite() {
    ArrayList<Noeud> voisinage = this.getVoisins();
    for (Noeud n : voisinage) {
      if (n.getEtat() != VISITE) {
        return false;
      }
    }
    return true;
  }

  public Noeud getVoisinPasVisite() {
    ArrayList<Noeud> voisinage = this.getVoisins();
    for (Noeud n : voisinage) {
      if (n.getEtat() != VISITE) {
        return n;
      }
    }
    return null;
  }
  @Override
    public boolean equals(Object obj) {
    if (this == obj) return true;
    if (obj == null || getClass() != obj.getClass()) return false;
    Noeud noeud = (Noeud) obj;
    return id == noeud.id;
  }

  @Override
    public int hashCode() {
    return Integer.hashCode(id);
  }

  boolean contains(float px, float py) {
    // Méthode pour vérifier si le point est cliqué
    float d = dist(px, py, x, y);
    return (d < 3);  // Rayon de tolérance pour le clic
  }

  public String toString() {
    return "["+this.id+":"+etat+"]" ;
  }

  boolean isPointInTriangle(float xA, float yA, float xB, float yB, float xC, float yC, float xP, float yP) {
    float denominateur = ((yB - yC) * (xA - xC) + (xC - xB) * (yA - yC));
    float lambda1 = ((yB - yC) * (xP - xC) + (xC - xB) * (yP - yC)) / denominateur;
    float lambda2 = ((yC - yA) * (xP - xC) + (xA - xC) * (yP - yC)) / denominateur;
    float lambda3 = 1 - lambda1 - lambda2;
    if (lambda1 >= 0 && lambda2 >= 0 && lambda3 >= 0 && lambda1 <= 1 && lambda2 <= 1 && lambda3 <= 1) {
      return true;
    } else {
      return false;
    }
  }

  void triangleOpp(Noeud spore, ArrayList<Noeud> noeuds) {

    float vx = spore.getX() - this.x;
    float vy = spore.getY() - this.y;
    float norme = sqrt(vx * vx + vy * vy);
    vx /= norme;
    vy /= norme;

    float triangleBaseX = this.x - LONGUEURE * vx;
    float triangleBaseY = this.y - LONGUEURE * vy;
    float triangleXp1 = this.x;
    float triangleYp1 = this.y;

    float triangleXp2 = triangleBaseX - LARGEUR * vy;
    float triangleYp2 = triangleBaseY + LARGEUR * vx;

    float triangleXp3 = triangleBaseX + LARGEUR * vy;
    float triangleYp3 = triangleBaseY - LARGEUR * vx;

    //stroke(1);
    //fill(255);
    //triangle(triangleXp1, triangleYp1, triangleXp2, triangleYp2, triangleXp3, triangleYp3) ;
    for (Noeud n : noeuds) {
      if (isPointInTriangle(triangleXp1, triangleYp1, triangleXp2, triangleYp2, triangleXp3, triangleYp3, n.getX(), n.getY()) && n != this) {
        this.etat = NOPE;
        break;
      } else {
      }
      noStroke();
    }
  }


  void dessinTriangle(Noeud spore, ArrayList<Noeud> noeuds) {

    float vx = spore.getX() - this.x;
    float vy = spore.getY() - this.y;
    float norme = sqrt(vx * vx + vy * vy);
    vx /= norme;
    vy /= norme;

    float triangleBaseX = this.x - LONGUEURE * vx;
    float triangleBaseY = this.y - LONGUEURE * vy;
    float triangleXp1 = this.x;
    float triangleYp1 = this.y;

    float triangleXp2 = triangleBaseX - LARGEUR * vy;
    float triangleYp2 = triangleBaseY + LARGEUR * vx;

    float triangleXp3 = triangleBaseX + LARGEUR * vy;
    float triangleYp3 = triangleBaseY - LARGEUR * vx;

    stroke(1);
    fill(255);
    triangle(triangleXp1, triangleYp1, triangleXp2, triangleYp2, triangleXp3, triangleYp3) ;
    noStroke();
  }
}
