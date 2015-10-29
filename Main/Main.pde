  //Pidetään importit täällä niin helppo löytää kaikki
import java.util.*;
import java.text.Collator;
import controlP5.*;
import de.looksgood.ani.*;

int spacing = 20;

boolean load_money = false; // Näistä kolmesta vain yks true kerralla
boolean load_ratings = false;
boolean load_money_ratings = true;
boolean tvp = true; // visualisoinnin valinta
boolean tvm = false;

void settings() {
  size(1280, 750);
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

  // Piirtää valitut nimet
  int y = 100;
  for (int i = 0; i < entries.size(); i++) {
    textAlign(LEFT);
    text(entries.get(i).getName(), 250, y);
    y = y + spacing;
  }

  if (tvp) draw_tVp();
  if (tvm) draw_tVm();
}

void test() {
  for (Movie m : directors.get("Alfred Hitchcock").getMovies()) println(m.getTitle(), m.getYear());
}