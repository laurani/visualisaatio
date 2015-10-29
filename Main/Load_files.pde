
HashMap<String, Actor> actors = new HashMap<String, Actor>();
HashMap<String, Actor> actresses = new HashMap<String, Actor>();
HashMap<String, Actor> directors = new HashMap<String, Actor>();
HashMap<String, Actor> producers = new HashMap<String, Actor>();
HashMap<String, Actor> all = new HashMap<String, Actor>();

void loadFiles() {
  if (load_money) {
    String[] actors_m = loadStrings("actors & money.txt");
    String[] actresses_m = loadStrings("actresses & money.txt");
    String[] directors_m = loadStrings("directors & money.txt");
    String[] producers_m = loadStrings("producers & money.txt");

    readFiles(actors_m, actors, true, false);
    readFiles(actresses_m, actresses, true, false);
    readFiles(directors_m, directors, true, false);
    readFiles(producers_m, producers, true, false);
  }
  if (load_ratings) {
    String[] actors_r = loadStrings("actors & ratings.txt");
    String[] actresses_r = loadStrings("actresses & ratings.txt");
    String[] directors_r = loadStrings("directors & ratings.txt");
    String[] producers_r = loadStrings("producers & ratings.txt");

    readFiles(actors_r, actors, false, true);
    readFiles(actresses_r, actresses, false, true);
    readFiles(directors_r, directors, false, true);
    readFiles(producers_r, producers, false, true);
  }
  if (load_money_ratings) {
    String[] actors_m_r = loadStrings("actors & money & ratings.txt");
    String[] actresses_m_r = loadStrings("actresses & money & ratings.txt");
    String[] directors_m_r = loadStrings("directors & money & ratings.txt");
    String[] producers_m_r = loadStrings("producers & money & ratings.txt");

    readFiles(actors_m_r, actors, true, true);
    readFiles(actresses_m_r, actresses, true, true);
    readFiles(directors_m_r, directors, true, true);
    readFiles(producers_m_r, producers, true, true);
  }

  toAll(actors);
  toAll(actresses);
  toAll(directors);
  toAll(producers);
}

void readFiles(String[] file, HashMap<String, Actor> target, boolean readMoney, boolean readRating) {
  Actor cur = null;
  boolean nextactor = true;

  for (String i : file) {
    if (nextactor) {
      String line = i.trim();
      cur = new Actor(line, createColor());
      if (!target.keySet().contains(line)) target.put(line, cur);
      nextactor = false;
    } else if (i.isEmpty()) {
      nextactor = true;
    } else {
      String[] parts = i.split("  ");
      String temp = parts[0];

      String title = temp.substring(0, temp.length() - 7).trim();
      int year = Integer.parseInt(temp.substring((temp.length() - 5), (temp.length() - 1)).trim());

      long gross = -1;
      double rating = -1;
      if (readMoney) {
        gross = Long.parseLong(parts[1].trim());
      }
      if (readRating && readMoney) {
        rating = Double.parseDouble(parts[2].trim());
      }
      if (readRating && !readMoney) {
        rating = Double.parseDouble(parts[1].trim());
      }
      Movie mov = new Movie(title, year, gross, rating);
      cur.addMovie(mov);
    }
  }
}
 
void toAll(HashMap<String, Actor> group) {
  for (Map.Entry<String, Actor> entry : group.entrySet()) {
    if (!all.keySet().contains(entry.getKey())) {
      all.put(entry.getKey(), entry.getValue());
    }
  }
}