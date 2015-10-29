ArrayList<String> loadTo_tVp = new ArrayList<String>();
ArrayList<Integer> first_year = new ArrayList<Integer>();
ArrayList<Integer> last_year = new ArrayList<Integer>();
ArrayList<String> names = new ArrayList<String>();
int[] nameY;

void time_v_people_viz() {
  /*
  loadTo_tVp.add("Elizabeth Taylor");
   loadTo_tVp.add("Christian Bale");
   loadTo_tVp.add("Al Pacino");
   loadTo_tVp.add("Gary Oldman");
   loadTo_tVp.add("Robert De Niro");
   loadTo_tVp.add("Jennifer Lawrence");
   loadTo_tVp.add("Humphrey Bogart");
   loadTo_tVp.add("Alfred Hitchcock");
   loadTo_tVp.add("Martin Scorsese");
   loadTo_tVp.add("Steven Spielberg");
   */
  for (Actor a : entries) loadTo_tVp.add(a.getName());
  checkNames(actors);
  checkNames(actresses);
  checkNames(directors);

  nameY = new int[names.size()];
  for (int i = 0; i < names.size(); i++) nameY[i] = 0;
}

void checkNames(HashMap<String, Actor> group) {
  for (Map.Entry<String, Actor> entry : group.entrySet()) {
    String name = entry.getKey();

    if (loadTo_tVp.contains(name) && !names.contains(name)) {
      ArrayList<Movie> movies = group.get(name).getMovies();
      int earliest = 3000;
      int latest = 1900;

      for (Movie m : movies) {
        if (m.getYear() < earliest) {
          earliest = m.getYear();
        }
        if (m.getYear() > latest) {
          latest = m.getYear();
        }
      }
      names.add(name);
      first_year.add(earliest);
      last_year.add(latest);
    }
  }
}
/*
void addToTvp(Actor a) {
  ArrayList<Movie> movies = a.getMovies();
  int earliest = 3000;
  int latest = 1900;

  for (Movie m : movies) {
    if (m.getYear() < earliest) {
      earliest = m.getYear();
    }
    if (m.getYear() > latest) {
      latest = m.getYear();
    }
  }
  names.add(a.getName());
  first_year.add(earliest);
  last_year.add(latest);

  int[] dummy = new int[names.size()];
  for (int i = 0; i < names.size(); i++) dummy[i] = nameY[i];
  nameY[names.size() - 1] = 0;
  nameY = dummy;
}
*/
void draw_tVp() {
  if (!entries.isEmpty()) {
    int earliest = Collections.min(first_year);
    int latest = Collections.max(last_year);
    int dif = (latest - earliest) / 2;
    int scl = 1;//dif / height;
    int offset_y = height / 10;
    int offset_x = 50;//width / names.size() - 10;

    strokeWeight(10);
    strokeCap(PROJECT);
    stroke(255);
    PFont font = createFont("Calibri", 10);
    textFont(font);
    textAlign(CENTER);
    fill(255);

    for (int i = 0; i < names.size(); i++) {

      int x = width / 2 - names.size() * offset_x / 2 + i * offset_x;
      int f = first_year.get(i);
      int l = last_year.get(i);
      int origper2 = (l - f) / 2;
      int scaling = (scl*(l - f) / 2) - origper2;

      int y0 = f - earliest + scaling;
      int y1 = y0 + (l - f) + scaling;
      int y0_rev = (height - y0);
      int y1_rev = (height - y1);

      int name_y = checkHeight(y0_rev + 50, i);
      nameY[i] = (name_y);

      pushMatrix();
      translate(100, -((height / 2) - dif));
      text(names.get(i), x, name_y);
      line(x, y0_rev, x, y1_rev);
      popMatrix();
    }
    textFont(f1);
    textAlign(LEFT);
  }
}

int checkHeight(int p, int c) {
  int name_y = p;
  for (int n  = 0; n < names.size(); n++) {
    if (n != c) {
      int t1 = nameY[n] - name_y;
      int t2 = name_y - nameY[n];
      if (t1 < 5 && t1 >= 0) name_y -= 10;
      else if (t2 < 5 && t2 >= 0) name_y += 10;
    }
  }
  return name_y;
}

void clear_tvp() {
  loadTo_tVp.clear();
  names.clear();
  first_year.clear();
  last_year.clear();
  
}