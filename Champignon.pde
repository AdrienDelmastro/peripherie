import java.util.Stack;

public class Champignon {

  private ArrayList<Noeud> noeuds;
  private Noeud spore;

  public Champignon() {
    this.noeuds = new ArrayList<>();
  }

  public Champignon(String fichier) {
    this.noeuds = new ArrayList<>();

    table  = loadTable(fichier, "header");
    // table.sort("T");
    for (TableRow row : table.rows()) {
      Noeud n1 = new Noeud(row.getFloat("XU")/5, row.getFloat("YU")/5, row.getInt("U"), row.getInt("T"));
      Noeud n2 = new Noeud(row.getFloat("XV")/5, row.getFloat("YV")/5, row.getInt("V"), row.getInt("T"));
      addNoeud(n1);
      addNoeud(n2);
      n1 = getNoeudById(n1.getId());
      n2 = getNoeudById(n2.getId());
      Arrete arrete = new Arrete(n1, n2);
      n1.addArrete(arrete);
      n2.addArrete(arrete);
    }

    Noeud spore = getNoeudById(92104);
    this.spore = spore;
    spore.setEtat(2);
    println(this.noeuds.size());
    int nbArrete = 0;
    for(Noeud n : this.noeuds){
      nbArrete+= n.getDegre();
    }
    println(nbArrete);
    println((float)nbArrete/this.noeuds.size());
  }

  public ArrayList<Noeud> getNoeuds() {
    return this.noeuds;
  }

  public boolean addNoeud(Noeud noeud) {
    if (!this.noeuds.contains(noeud)) {
      return this.noeuds.add(noeud);
    }
    return false;
  }

  public Noeud getNoeud(Noeud noeud) {
    return this.noeuds.get(this.noeuds.indexOf(noeud));
  }

  public Noeud getNoeudById(int id) {
    for (Noeud n : this.noeuds) {
      if (n.getId() == id) {
        return n;
      }
    }

    return null;
  }

  public void dessiner() {
    for (Noeud n : noeuds) {
      n.dessiner();
    }
  }

  public int getSize() {
    return this.noeuds.size();
  }

  public ArrayList<Noeud> rechercheEnProfondeur() {
    Stack<Noeud> pile = new Stack<>();
    Noeud courant = this.spore;
    int distance = 0;
    courant.setEtat(VISITE);
    courant.setDistance(distance);
    pile.push(courant);
    while (!pile.empty()) {
      if (!courant.voisinageVisite()) {
        pile.push(courant);
        courant = courant.getVoisinPasVisite();
        distance++;
        courant.setDistance(distance);
        courant.setEtat(VISITE);
      } else {
        courant = pile.pop();
        distance--;
      }
    }
    ArrayList<Noeud> pasConnexe = new ArrayList<>();
    for (Noeud n : this.noeuds) {
      if(n.getEtat() == NOEUD){
        pasConnexe.add(n);
      }
    }
    return pasConnexe;
  }

  public void dijskra() {
    ArrayList<Noeud> aRetirer = rechercheEnProfondeur();
    ArrayList<Noeud> pasVisite = this.noeuds;
    for(Noeud n : aRetirer){
      pasVisite.remove(n);
    }
    spore.setDistance(0);
  }

  public Noeud getSpore() {
    return this.spore;
  }

  public void getCouronne() {
    for (Noeud n : noeuds) {
      if (n.getDegre() == 1) {
        n.setEtat(3);
      }
    }
  }
}
