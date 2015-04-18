class Button  {    

  // Button location and size
  int x;   
  int y;   
  int h;
  int w;
  // Is the button on or off?
  boolean on;
  String text;

  // Constructor initializes all variables
    Button(String tx, int tempX, int tempY)  {    
    x  = tempX;   
    y  = tempY;  
    h = 76;
    w = int(width/1.5);
    on = false;  // Button always starts as off
    text = tx;
  }
  
  public boolean click(int mx, int my) {
    
    return ( (mx > x) && (mx < x + w) && (my > y - h) && (my < y)); 

  }

  // Draw the rectangle
  void display() {
    fill(colorDarkBlue);
    textFont(SansSerifBold);
    textAlign(LEFT);
    text(text,x,y);
  }
  
} 
