/*
HashMap<String, ArrayList<Movie>> in_time_limit_map = new HashMap<String, ArrayList<Movie>>();
HashMap<String, ArrayList<Movie>> in_time_limit= new HashMap<String, ArrayList<Movie>>();

// Aikarajan asettamiseen näytettävässä infossa
void setTimeLimitFromMap(HashMap<String, Actor> group, int f, int t) {
  ArrayList<Movie> movies_in_time = new ArrayList<Movie>();
  int from = f;
  int to = t;

  for (Map.Entry<String, Actor> entry : group.entrySet()) {
    String name = entry.getKey();
    Actor person = entry.getValue();
    ArrayList<Movie> movies = person.getMovies();

    for (Movie m : movies) {
      int year = m.getYear();
      if (year >= from && year <= to) {
        movies_in_time.add(m);
      }
    }
    in_time_limit.put(name, movies_in_time);
  }
}

void setTimeLimitFromList(ArrayList<Actor> group, int f, int t) {
  ArrayList<Movie> in_time = new ArrayList<Movie>();
  int from = f;
  int to = t;

  for (Actor a : group) {
    String name = a.getName();
    ArrayList<Movie> movies = a.getMovies();
    
    for (Movie m : movies) {
      int year = m.getYear();
      if (year >= from && year <= to) {
        in_time.add(m);
      }
    }
    in_time_limit.put(name, in_time);
  }
}
*/