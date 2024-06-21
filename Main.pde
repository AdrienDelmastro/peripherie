Table table;
//U,V,XU,YU,XV,YV,T
ArrayList<Noeud> champignon;
Champignon champ;
void setup() {
  size(1500, 1000);
  background(255);
  champ = new Champignon("champignon.csv");
  for(Noeud n : champ.getNoeuds()){
    n.triangleOpp(champ.getSpore(), champ.getNoeuds());
  }
  //champ.rechercheEnProfondeur();
}

void draw() {
  champ.dessiner();
}

void mousePressed() {
    for (Noeud n : champ.getNoeuds()) {
        if (n.contains(mouseX, mouseY)) {
            n.dessinTriangle(champ.getSpore(), champ.getNoeuds());
        }
    }
}
