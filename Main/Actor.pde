class Actor {
  ArrayList<Movie> movies = new ArrayList<Movie>();
  ArrayList<Movie> graphMovies = new ArrayList<Movie>();
  String name;
  color c;

  Actor(String n, color actorColor) {
    name = n;
    c = actorColor;
  }

  void addMovie(Movie m) {
    this.movies.add(m);
    this.movies = arrangeMovies(this.movies);
    graphMovies = selectGraphPoints();
  }

  String getName() {
    return name;
  }

  ArrayList<Movie> getMovies() {
    return movies;
  }

  void display() {
    stroke(c);
    strokeWeight(5);
    noFill();

    // STRAIGHT LINES

    // Line from y-axis to first movie
    Movie m0 = this.movies.get(0);
    if (m0.getYear() > firstYear && m0.getYear() < lastYear) {
      int x0 = getMovieX(m0);
      int y0 = getMovieY(m0);
      line(x0, h+margin, x0, y0);
    }

    // Lines between graph points
    for (int r = 0; r < this.graphMovies.size()-1; r++) {
      Movie mov1 = this.graphMovies.get(r);
      Movie mov2 = this.graphMovies.get(r+1);

      if (mov1.getYear() > firstYear && mov2.getYear() < lastYear) {
        int x0 = getMovieX(mov1);
        int y0 = getMovieY(mov1);
        int x1 = getMovieX(mov2);
        int y1 = getMovieY(mov2);

        line(x0, y0, x1, y1);
      }
    }

    // Line from last element in graphMovies to last element in movies
    Movie last_graph = this.graphMovies.get(this.graphMovies.size()-1);
    Movie last_movie = this.movies.get(this.movies.size()-1);
    if (last_graph.getYear() > firstYear && last_movie.getYear() < lastYear) {
      int x0 = getMovieX(last_graph);
      int y0 = getMovieY(last_graph);
      int x1 = getMovieX(last_movie);
      int y1 = getMovieY(last_movie);
      line(x0, y0, x1, y1);
    }

    // Line from last movie to y-axis
    if (last_movie.getYear() > firstYear && last_movie.getYear() < lastYear) {
      int x1 = getMovieX(last_movie);
      int y1 = getMovieY(last_movie);
      line(x1, y1, x1, h+margin);
    }


    //CURVES (SHIT)
    /*

     beginShape();
     curveVertex(getMovieX(movies.get(0)), getMovieY(movies.get(0))); // control point
     for ( int i = 0; i < movies.size(); i++) {
     curveVertex(getMovieX(movies.get(i)), getMovieY(movies.get(i))); // last control point
     }
     curveVertex(getMovieX(movies.get(movies.size()-1)), getMovieY(movies.get(movies.size()-1)));
     endShape();
     
     */

    fill(c);
    for (Movie m : this.movies) {
      if (m.getYear() > firstYear && m.getYear() < lastYear) {
        ellipse(getMovieX(m), getMovieY(m), 10, 10);
      }
    }
  }

  ArrayList<Movie> arrangeMovies(ArrayList<Movie> mov) {
    Movie[] arr = mov.toArray(new Movie[mov.size()]);
    for (int i = 0; i < arr.length - 1; i++) {
      int j = i + 1;
      Movie dummy = arr[j];
      while (j > 0 && dummy.getYear() < arr[j - 1].getYear()) {
        arr[j] = arr[j - 1];
        j = j - 1;
      }
      arr[j] = dummy;
    }
    return new ArrayList<Movie>(Arrays.asList(arr));
  }

  // Select movies to draw lines between preventing zigzagging. Here the movie with largest gross is selected for each year.
  ArrayList<Movie> selectGraphPoints() {
    ArrayList<Movie> selected = new ArrayList<Movie>();
    Iterator<Movie> films = this.movies.iterator();
    Movie elect = (Movie)films.next();

    while (films.hasNext()) {
      Movie challenger = (Movie)films.next();

      if (challenger.getYear() == elect.getYear()) {
        if (challenger.getGross() > elect.getGross()) {
          elect = challenger;
        }
      } else {
        selected.add(elect);
        elect = challenger;
      }
    }
    if (selected.size() > 4) selected = trimGraph(selected);
    return selected;
  }

  // Helper method for selectGrapPoints, removes productions with much smaller gross than previous and following productions from linegraph.
  // Not working quite right (?)
  ArrayList<Movie> trimGraph(ArrayList<Movie> arr) {
    ArrayList<Movie> trimmed = new ArrayList<Movie>();
    trimmed.add(arr.get(0));
    
    int thisGross = int(arr.get(0).getGross());
    int previousGross = 0;
    int nextGross = int(arr.get(1).getGross());
    boolean moveOn = true;

    for (int i = 2; i < arr.size(); i++) {
      if (moveOn) previousGross = thisGross;
      thisGross = nextGross;
      nextGross = int(arr.get(i).getGross());

      if (!(thisGross < previousGross/2 && thisGross < nextGross/2)) {
        trimmed.add(arr.get(i - 1));
      }
    }
    trimmed.add(arr.get(arr.size() - 1));
    trimmed.add(movies.get(movies.size() - 1));
    return trimmed;
  }
}