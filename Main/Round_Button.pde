class CircularButton implements ControllerView<Button> {

  public void display(PGraphics pgs, Button theButton) {
    pgs.pushMatrix();
    if (theButton.isInside()) {
      if (theButton.isPressed()) { // button is pressed
        pgs.fill(200, 60, 0);
      }  else { // mouse hovers the button
        pgs.fill(200, 160, 100);
      }
    } else { // the mouse is located outside the button area
      pgs.fill(0, 160, 100);
    }
    
    pgs.ellipse(0, 0, theButton.getWidth(), theButton.getHeight());
    
    // center the caption label 
    int x = theButton.getWidth()/2 - theButton.getCaptionLabel().getWidth()/2;
    int y = theButton.getHeight()/2 - theButton.getCaptionLabel().getHeight()/2;
    
    translate(x, y);
    theButton.getCaptionLabel().draw(pgs);
    
    pgs.popMatrix();
  }
}