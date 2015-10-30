import java.util.*;
import java.text.Collator;
import controlP5.*;
import de.looksgood.ani.*;

int spacing = 20;

boolean load_money = false; // Näistä kolmesta vain yks true kerralla
boolean load_ratings = false;
boolean load_money_ratings = true;
boolean tvp = false; // visualisoinnin valinta
boolean tvm = true;

void settings() {
  fullScreen();
  //size(1280, 750);
  //pixelDensity(displayDensity());  // Retina-näyttöä varten - Kusee jotkin fontit jotenkin
}

void setup() {
  frameRate(30);
  loadFiles();
  init_menu();
  Ani.init(this);
  if (tvp) time_v_people_viz();

  //test();
}

void draw() {
  background(50);

  if (tvp) draw_tVp();
  if (tvm) draw_tVm();
}

void test() {
  //for (Movie m : directors.get("Alfred Hitchcock").getMovies()) println(m.getTitle(), m.getYear());
  ArrayList<Movie> m = all.get("Anne Hathaway").graphMovies;
  for (Movie mov : m) println(mov.getTitle(), mov.getYear(), mov.getGross());
}