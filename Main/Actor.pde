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
    pushMatrix();
    stroke(c);
    strokeWeight(2);
    noFill();

    /*
    
     STRAIGHT LINES
     
     int r = 0;
     while (r < this.movies.size()-1) {
     line(getMovieX(this.movies.get(r)),getMovieY(this.movies.get(r)),getMovieX(this.movies.get(r+1)),getMovieY(this.movies.get(r+1)));
     r = r + 1;
     } 
     */

    beginShape();
    curveVertex(getMovieX(movies.get(0)), getMovieY(movies.get(0))); // control point
    for ( int i = 0; i < movies.size(); i++) {
      curveVertex(getMovieX(movies.get(i)), getMovieY(movies.get(i))); // last control point
    }
    curveVertex(getMovieX(movies.get(movies.size()-1)), getMovieY(movies.get(movies.size()-1)));
    endShape();

    fill(c);
    for (int i=0; i<this.movies.size(); i++) {
      ellipse(getMovieX(this.movies.get(i)), getMovieY(this.movies.get(i)), 10, 10);
    }

    popMatrix();
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