HashMap<String, ArrayList<Movie>> in_time_limit = new HashMap<String, ArrayList<Movie>>();

void doTime(HashMap<String, Actor> group, int f, int t) {
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