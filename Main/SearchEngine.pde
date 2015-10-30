ArrayList<Actor> entries = new ArrayList<Actor>();
ControlP5 cp5;
PFont f1, f2, f3;
MenuList menulist;
Range yearsToShow;

void init_menu() {
  f1 = createFont("Calibri", 16, true);
  f2 = createFont("Calibri", 12, true);
  f3 = createFont("Calibri", 10, true);
  textFont(f1);

  cp5 = new ControlP5(this);
  ControlFont cf = new ControlFont(f2, 241);

  cp5.addTextfield("")
    .setPosition(20, 20)
    .setSize(200, 30)
    .setFont(f1)
    .setColor(color(255))
    ;

  cp5.addBang("clear")
    .setPosition(20, 620)
    .setSize(200, 30)
    .getCaptionLabel().align(ControlP5.CENTER, ControlP5.CENTER)
    ;

  cp5.addBang("directors")
    .setPosition(20, 440)
    .setSize(95, 40)
    .getCaptionLabel().align(ControlP5.CENTER, ControlP5.CENTER)
    ;

  cp5.addBang("producers")
    .setPosition(125, 440)
    .setSize(95, 40)
    .getCaptionLabel().align(ControlP5.CENTER, ControlP5.CENTER)
    ;

  cp5.addBang("actors")
    .setPosition(125, 490)
    .setSize(95, 40)
    .getCaptionLabel().align(ControlP5.CENTER, ControlP5.CENTER)
    ;

  cp5.addBang("actresses")
    .setPosition(20, 490)
    .setSize(95, 40)
    .getCaptionLabel().align(ControlP5.CENTER, ControlP5.CENTER)
    ;
    
  cp5.addBang("visualization_1")
    .setPosition(20, 675)
    .setSize(95, 40)
    .getCaptionLabel().align(ControlP5.CENTER, ControlP5.CENTER)
    ;
    
  cp5.addBang("visualization_2")
    .setPosition(125, 675)
    .setSize(95, 40)
    .getCaptionLabel().align(ControlP5.CENTER, ControlP5.CENTER)
    ;

  yearsToShow = cp5.addRange("Years")
    .setBroadcast(false) 
    .setPosition(20, 550)
    .setSize(200, 30)
    .setHandleSize(20)
    .setRange(1913, 2015)
    .setRangeValues(1913, 2015)
    .setBroadcast(true)
    .setColorForeground(color(255, 40))
    .setColorBackground(color(255, 40))
    .setLabelVisible(false)
    ;

  style("clear", cf);
  style("directors", cf);
  style("producers", cf);
  style("actors", cf);
  style("actresses", cf);
  style("visualization_1", cf);
  style("visualization_2", cf);
  style("Years", cf);

  cp5.setColorForeground(0xff0099CC);
  cp5.setColorBackground(0xff336699);
  cp5.setColorActive(0xff66CCFF);

  menulist = new MenuList( cp5, "menu", 200, 360 );
  menulist.setPosition(20, 80);
}

void style(String s, ControlFont f) {
  cp5.getController(s)
    .getCaptionLabel()
    .setFont(f)
    .toUpperCase(false)
    .setSize(14)
    ;
}

public void clear() {
  entries.clear();
  clear_tvp();
}

public void directors() {
  menulist.loadToMenu(directors);
}

public void actors() {
  menulist.loadToMenu(actors);
}

public void actresses() {
  menulist.loadToMenu(actresses);
}

public void producers() {
  menulist.loadToMenu(producers);
}

public void visualization_1() {
  tvm = true;
  tvp = false;
}

public void visualization_2() {
  tvp = true;
  tvm = false;
  time_v_people_viz();
}

boolean notInEntries(String name) {
  for (Actor a : entries) {
    if (a.getName().equals(name)) return false;
  }
  return true;
}


////////////////////////////////////////////////////////////// älä koske tän jälkeen jos et oo varma




void controlEvent(ControlEvent theEvent) {
  if (theEvent.isAssignableFrom(Textfield.class)) {
    String n = theEvent.getStringValue();
    if (all.keySet().contains(n) && notInEntries(n)) {
      entries.add(all.get(n));
      setLimits();
      if (tvp) time_v_people_viz(); //addToTvp(all.get(n));
    }
  }
  if (theEvent.isFrom("menu")) {
    int index = Math.round(theEvent.getValue());
    String n = menulist.getItem(index);
    if (notInEntries(n)) {
      entries.add(all.get(n));
      setLimits();
      if (tvp) time_v_people_viz(); //addToTvp(all.get(n));
    }
  }
  if (theEvent.isFrom("Years")) {
    int s = int(theEvent.getController().getArrayValue(0));
    int e = int(theEvent.getController().getArrayValue(1));
    firstYear = s;
    lastYear = e;
    //setLimits();
  }
}

class MenuList extends Controller<MenuList> {

  float pos, npos;
  int itemHeight = 25;
  int scrollerLength = 40;
  List<String> items = new ArrayList<String>();
  PGraphics menu;
  boolean updateMenu;

  MenuList(ControlP5 c, String theName, int theWidth, int theHeight) {
    super( c, theName, 0, 0, theWidth, theHeight );
    c.register( this );
    menu = createGraphics(getWidth(), getHeight() );

    setView(new ControllerView<MenuList>() {

      public void display(PGraphics pg, MenuList t ) {
        if (updateMenu) {
          updateMenu();
        }
        if (inside()) {
          menu.beginDraw();
          int len = -(itemHeight * items.size()) + getHeight();
          int ty = int(map(pos, len, 0, getHeight() - scrollerLength - 2, 2 ) );
          menu.fill(255);
          menu.rect(getWidth()-4, ty, 4, scrollerLength );
          menu.endDraw();
        }
        pg.image(menu, 0, -10);
        textFont(f1);
        fill(255);
        text(firstYear, 30, 518);
        text(lastYear, 200, 518);
      }
    }
    );
    updateMenu();
  }

  /* only update the image buffer when necessary - to save some resources */
  void updateMenu() {
    int len = -(itemHeight * items.size()) + getHeight();
    npos = constrain(npos, len, 0);
    pos += (npos - pos) * 0.1;
    menu.beginDraw();
    menu.noStroke();
    menu.background(0, 64);
    menu.textFont(cp5.getFont().getFont());
    menu.pushMatrix();
    menu.translate( 0, pos );
    menu.pushMatrix();

    int i0 = PApplet.max( 0, int(map(-pos, 0, itemHeight * items.size(), 0, items.size())));
    int range = ceil((float(getHeight())/float(itemHeight))+1);
    int i1 = PApplet.min( items.size(), i0 + range );

    menu.translate(0, i0*itemHeight);

    for (int i=i0; i<i1; i++) {
      String m = items.get(i);
      menu.fill(#5C85AD, 180);
      menu.rect(0, 0, getWidth(), itemHeight-1 );
      menu.fill(255);
      menu.textFont(f1);
      menu.text(m, 10, 20 );
      menu.textLeading(50);
      menu.translate( 0, itemHeight );
    }
    menu.popMatrix();
    menu.popMatrix();
    menu.endDraw();
    updateMenu = abs(npos-pos)>0.01 ? true:false;
  }

  /* when detecting a click, check if the click happend to the far right, if yes, scroll to that position, 
   * otherwise do whatever this item of the list is supposed to do.
   */
  public void onClick() {
    if (getPointer().x()>getWidth()-30) {
      npos= -map(getPointer().y(), 0, getHeight(), 0, items.size()*itemHeight);
      updateMenu = true;
    } else {
      int len = itemHeight * items.size();
      int index = int( map( getPointer().y() - pos, 0, len, 0, items.size() ) ) ;
      setValue(index);
    }
  }

  public void onMove() {
  }

  public void onDrag() {
    npos += getPointer().dy() * 2;
    updateMenu = true;
  } 

  public void onScroll(int n) {
    npos += ( n * 4 );
    updateMenu = true;
  }

  void addItem(String m) {
    items.add(m);
    Collections.sort(items);
    updateMenu = true;
  }

  String getItem(int theIndex) {
    return items.get(theIndex);
  }

  void clear() {
    items.clear();
  }

  void loadToMenu(HashMap<String, Actor> people) {
    clear();
    for (Map.Entry<String, Actor> entry : people.entrySet()) {
      menulist.addItem(entry.getKey());
    }
  }
}