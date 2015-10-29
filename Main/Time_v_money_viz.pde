// Käytetään jotakuinki 16 / 32 pikselin grid-systeemiä, tulee helpolla hyvännäköset raamit

int windowW = 1024;
int windowH = 768;

// Reunat
int margin = 128;

//Koordinaaston leveys ja korkeus
int w = 1024-margin*2;
int h = 768-margin*2;


// Riviväli
int rowHeight = 32;

color bgColor = #292F36;
color gridDimColor = #4A535E;
color gridColor = #7D8389;
color textColor = #F7F9FF;


// TODO: Uusien värien valinta siten että niitä on enemmän (mutta harmonia säilyy)
color[] dataColors = {#FF6B6B, #FFE66D, #4ECDC4, #7DDF64, #CC4FB1};

// Skaalausta varten
int amountOfYears = 30;
int firstYear = 1985;
float mostMoney = 500000000.0;

void time_v_money_viz() {
}

void draw_tVm() {
  pushMatrix();
  //translate(350, 0);
  background(bgColor);

  fill(textColor);
  textAlign(CENTER);
  textSize(16);
  text("DADA", windowW/2, 32);

  strokeWeight(1);
  //DIMMER GRID AND TEXT
  stroke(gridDimColor);
  fill(gridColor);
  textSize(12);
  for (int i=0; i<h/rowHeight+1; i++) {
    line(margin, (windowH-margin)-rowHeight*i, margin+w, (windowH-margin)-rowHeight*i);
    textAlign(RIGHT);
    text(int(millions()*(i/(float(h)/rowHeight))), margin-8, (windowH-margin)-rowHeight*i);
  }
  // GRID EDGE LINES
  stroke(gridColor);
  line(margin, margin, margin, windowH-margin);
  line(margin, windowH-margin, windowW-margin, windowH-margin);

  // Vertical line at mouseX. 
  if (mouseX<margin+w && mouseX>margin && mouseY<margin+h && mouseY>margin) {
    stroke(255, 180, 180);
    line(mouseX, margin, mouseX, windowH-margin);
    textAlign(CENTER);
    textSize(16);
    // Year text below the line, so that data point seems to be in the middle of "year column"
    // DOESN'T WORK PROPERLY ... when trying different amountOfYears.
    text(firstYear+amountOfYears*(mouseX-(margin-(w/amountOfYears)/2))/w, mouseX, windowH-margin+24);
  }

  //Näytä kaikki näyttelijät
  if (!entries.isEmpty()) {
    for (Actor i : entries) {
      i.display();
    }
  }
  popMatrix();
}
/*
void mouseReleased() {
 // animate the variable mostMoney in 0.5 sec to another value
 if (mostMoney == 300000000.0) Ani.to(this, 0.5, "mostMoney", 600000000.0);
 if (mostMoney == 600000000.0) Ani.to(this, 0.5, "mostMoney", 300000000.0);
 }
 */
// Lasketaan elokuva-pisteiden piirtokoordinaatit

int getMovieX(Movie movie) {
  int x = w/amountOfYears*abs(firstYear - movie.year)+margin;
  return x;
}

int getMovieY(Movie movie) {
  int y = h-int(movie.getGross()*(h/mostMoney))+margin;
  return y;
}

int millions() {
  return int(mostMoney/1000000);
}

void setYears() {
  int min = 3000;
  int max = 1900;

  for (Actor m : entries) {
    int year = m.getMovies().get(0).getYear();
    if (year < min) {
      min = year;
    }
    if (year > max) {
      max = year;
    }
  }
}