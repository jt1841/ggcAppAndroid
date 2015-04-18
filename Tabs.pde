class Tab
{
 int x0;
 int x1;
 int x2;
 int x3;
 int h;
 String text;
 int tabColor; 
 int tabColorActive;
 boolean active;
  
 Tab(String _text, int _x0, int _x1, int _x2, int _x3, int _h, int _tabColor )
 {
   x0 = _x0;
   x1 = _x1;
   x2 = _x2;
   x3 = _x3;
   h = _h;
   text = _text;
   tabColor = _tabColor;
   tabColorActive = tabColor;//(_tabColor & #fefefe) << 1;
   active = false;
 }
  
  public void click(int mx, int my) 
  {
      if(active & my > h)
        active = true;
      else
        active = ((mx > x0 && mx < x1 && my <= h));
    
  }

  // Draw the rectangle
  void display() 
  {
    if(active)
    {
      fill(tabColorActive);
      beginShape();
      vertex(x0, 0);
      vertex(x1, 0);
      vertex(x3-5, h + 10);
      vertex(x2-10, h + 10);
      endShape(CLOSE);
      textFont(SansSerifBold);

    }
    else
    {
      fill(tabColor);
      beginShape();
      vertex(x0, 0);
      vertex(x1, 0);
      vertex(x3, h);
      vertex(x2, h);
      endShape(CLOSE);
      textFont(SansSerif);

    }
   
    textSize(40);
    fill(tabTextColor);
    textAlign(CENTER);
    
    text(text,x0 + (x3 - x0)/2 , h/2 + 40/2.5);
  }
  
}

