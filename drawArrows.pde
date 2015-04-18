void drawArrows()
{
     int[] command = {0,0,0,0};
    
  for (int i = 14; i < 18; i++)
  {
    try{
      command[i-14] = Integer.parseInt(testSerial[i]);
    }
    catch(Exception e)
    {
      command[i-14] = command[i-14]; //yeah i know this is stupid
    }
  }

  


  int x = width/2;
  int y = int(height/1.3);
  textFont(SansSerifBold);
  textSize(55);
  fill(colorDarkBlue);
  textAlign(CENTER);
  text("Left", x - 325, y + 76/4);
  text("Right", x + 335, y + 76/4);
  text("Forward", x, y - 300);
  text("Backward", x, y + 315);
  
  
  strokeWeight(20);
  if (command[0] == 1)
  {
    stroke(colorRed);
    arrow(x - 20, y, x - 250, y); //Left Arrow
    stroke(colorDarkBlue);
    arrow(x + 20, y, x + 250, y); //Right Arrow
  } else if (command[1] == 1)
  {
    stroke(colorDarkBlue);
    arrow(x - 20, y, x - 250, y); //Left Arrow
    stroke(colorRed);
    arrow(x + 20, y, x + 250, y); //Right Arrow
    stroke(colorDarkBlue);
  } else 
  {
    stroke(colorDarkBlue);
    arrow(x - 20, y, x - 250, y); //Left Arrow
    arrow(x + 20, y, x + 250, y); //Right Arrow
  }

  if (command[2] == 1)
  {
    stroke(colorRed);
    arrow(x, y - 20, x, y - 250); //Forward Arrow
    stroke(colorDarkBlue);
    arrow(x, y + 20, x, y + 250); //Backward Arrow
  } else if (command[3] == 1)
  {
    stroke(colorRed);
    arrow(x, y + 20, x, y + 250); //Backward Arrow
    stroke(colorDarkBlue);
    arrow(x, y - 20, x, y - 250); //Forward Arrow
  } else 
  {
    stroke(colorDarkBlue);
    arrow(x, y + 20, x, y + 250); //Backward Arrow
    arrow(x, y - 20, x, y - 250); //Forward Arrow
  }
    
  strokeWeight(0);
     
  
}

void arrow(int x1, int y1, int x2, int y2) {
  line(x1, y1, x2, y2);
  pushMatrix();
  translate(x2, y2);
  float a = atan2(x1-x2, y2-y1);
  rotate(a);
  line(0, 0, -10, -10);
  line(0, 0, 10, -10);
  popMatrix();
} 
