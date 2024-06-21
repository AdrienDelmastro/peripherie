public class Arrete {
  private Noeud n1, n2;

  public Arrete(Noeud n1, Noeud n2) {
    this.n1 = n1;
    this.n2 = n2;
  }

  public Noeud getAutreNoeud(Noeud appel) {
    if (appel.getId() != this.n1.getId()) {
      return n1;
    } else {
      return n2;
    }
  }

  public void setN1(Noeud n1) {
    this.n1 = n1;
  }

  public void setN2(Noeud n2) {
    this.n2 = n2;
  }

  public void dessiner() {
    line(n1.getX(), n1.getY(), n2.getX(), n2.getY());
  }
}
