class Actor {
  ArrayList<Movie> movies = new ArrayList<Movie>();
  String name;
  color c;

  Actor(String n, color actorColor) {
    name = n;
    c = actorColor;
  }

  void addMovie(Movie m) {
    this.movies.add(m);
    this.movies = arrangeMovies(this.movies);
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
    Movie m0 = this.movies.get(0);
    if (m0.getYear() > yearFrom && m0.getYear() < yearTo) {
      int x0 = getMovieX(m0);
      int y0 = getMovieY(m0);
      line(x0, h+margin, x0, y0);
    }
    
    for (int r = 0; r < this.movies.size()-1; r++) {
      Movie mov1 = this.movies.get(r);
      Movie mov2 = this.movies.get(r+1);

      if (mov1.getYear() > yearFrom && mov2.getYear() < yearTo) {
        int x0 = getMovieX(mov1);
        int y0 = getMovieY(mov1);
        int x1 = getMovieX(mov2);
        int y1 = getMovieY(mov2);

        line(x0, y0, x1, y1);
      }
    }
    
    Movie m1 = this.movies.get(this.movies.size()-1);
    if (m1.getYear() > yearFrom && m1.getYear() < yearTo) {
      int x1 = getMovieX(m1);
      int y1 = getMovieY(m1);
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
      if (m.getYear() > yearFrom && m.getYear() < yearTo) {
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
}