// Käytetään jotakuinki 16 / 32 pikselin grid-systeemiä, tulee helpolla hyvännäköset raamit

int windowW = 1280;
int windowH = 768;

// Reunat
int margin = 40;
int marginL = 272;
int marginR = 64;

//Koordinaaston leveys ja korkeus
int w = 1280-(marginL+marginR);
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
int firstYear = 2010;
int lastYear = 2015;
int amountOfYears = lastYear-firstYear;
float mostMoney = 500000000.0;

void time_v_money_viz() {
}

void draw_tVm() {
  background(bgColor);

  fill(textColor);
  textAlign(CENTER);
  textSize(16);

  strokeWeight(1);
  //DIMMER GRID AND TEXT
  stroke(gridDimColor);
  fill(gridColor);
  textSize(12);
  for (int i=0; i<h/rowHeight+1; i++) {
    line(marginL, (windowH-margin)-rowHeight*i, marginL+w, (windowH-margin)-rowHeight*i);
    textAlign(RIGHT);
    text(int(millions()*(i/(float(h)/rowHeight))), marginL-8, (windowH-margin)-rowHeight*i);
  }
  // GRID EDGE LINES
  stroke(gridColor);
  line(marginL, margin, marginL, windowH-margin);
  line(marginL, windowH-margin, windowW-marginR, windowH-margin);

  // Vertical line at mouseX. 
  if (mouseX<marginL+w && mouseX>marginL && mouseY<margin+h && mouseY>margin) {
    stroke(255, 180, 180);
    line(mouseX, margin, mouseX, windowH-margin);
    textAlign(CENTER);
    textSize(16);
    // Year text below the line, so that data point seems to be in the middle of "year column"
    // DOESN'T WORK PROPERLY ... when trying different amountOfYears.
    text(firstYear+amountOfYears*(mouseX-(marginL-(w/amountOfYears)/2))/w, mouseX, windowH-margin+24);
    textAlign(RIGHT);
  }



  //Näytä kaikki näyttelijät
  if (!entries.isEmpty()) {

    for (Actor i : entries) {

      i.display();
    }
  }
}

// Lasketaan elokuva-pisteiden piirtokoordinaatit

int getMovieX(Movie movie) {
  int x = w/amountOfYears*abs(firstYear - movie.year)+marginL;
  return x;
}

int getMovieY(Movie movie) {
  int y = h-int(movie.getGross()*(h/mostMoney))+margin;
  return y;
}

int millions() {
  return int(mostMoney/1000000);
}

void setLimits() {
  int min = 3000;
  int max = 1900;
  float mon = 500000000;

  for (Actor m : entries) {
    for (Movie u : m.movies) {
      int year = u.getYear();
      long money = u.getGross();
      min = min(min, year);
      max = max(max, year);
      mon = max(mon, money);
    }
  }

  amountOfYears = max-min+1;
  firstYear = min-1;
  lastYear = max+1;
  mostMoney = mon;
  
  // Sets year slider position from first movie to last movie among selected people.
  ((Range)cp5.getController("Years")).setRangeValues(min-1, max+1);
}

color createColor() {
  int a = ceil(random(100, 255));
  int b = ceil(random(100, 255));
  int c = ceil(random(100, 255));
  return color(a, b, c);
}