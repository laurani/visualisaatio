class Movie {
  String title;
  int year;
  double rating;
  long gross;

  Movie(String t, int y, long g, double r) {
    title = t;
    year = y;
    rating = r;
    gross = g;
  }

  String getTitle() {
    return title;
  }

  int getYear() {
    return year;
  }

  double getRating() {
    return rating;
  }

  long getGross() {
    return gross;
  }
}