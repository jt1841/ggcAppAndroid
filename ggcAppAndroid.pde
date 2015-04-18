/* A simple example to controll your arduino board via bluetooth of your android smartphone or tablet. Tested with Android 4.
Requirements:
Arduino Board
Bluetooth shield
Android Smartphone (Android 2.3.3 min.)
Ketai library for processing
Jumper D0 to TX
Jumper D1 to RX
Set bluetooth, bluetooth admin and internet sketch permissions in processing.
Processing Code:
*/

//required for BT enabling on startup

import android.content.Intent;
import android.os.Bundle;
import ketai.net.bluetooth.*;
import ketai.ui.*;
import ketai.net.*;
import controlP5.*;

PFont fontMy;
PFont SansSerifBold = createFont("SansSerif-Bold", 76);
PFont SansSerif = createFont("SansSerif", 76);
boolean bReleased = true; //no permament sending when finger is tap
KetaiBluetooth bt;
boolean isConfiguring = true;
String info = "";
KetaiList klist;
ArrayList devicesDiscovered = new ArrayList();
int colorBlack = 0;
int colorDarkBlue = #02344d;
int colorRed = #FC0000;
int colorDarkRed = #cc0000;
int colorBackground = #bdbdbd;
int colorGreen = #009100;
int colorPurple = #74009E;
int colorOrange = #FF6A00;
int tabTextColor = #eeeee7;
PImage teamLogo;


//Tabs
Tab flexTab;
Tab gyroTab;
Tab configTab;

//Controllers
ControlP5 flexController;
ControlP5 gyroController;
ControlP5 commandController;
CheckBox checkbox;
int Thumb = 20;
int Index = 20;
int Middle = 20;
int Ring = 20;
int Pinky = 20;
int GyroLeft = 60;
int GyroRight = 60;
boolean FThumb = false;
boolean FIndex = true;
boolean FMiddle = true;
boolean FRing = true;
boolean FPinky = true;
boolean BThumb = true;
boolean BIndex = true;
boolean BMiddle = true;
boolean BRing = true;
boolean BPinky = true;

//Serial Communication
String[] testSerial = {
  "value", "100", "100", "100", "100", "100", "-1", "active", "1", "1", "1", "1", "1", "command", "0", "0", "0", "1"
};


//********************************************************************
// The following code is required to enable bluetooth at startup.
//********************************************************************

void onCreate(Bundle savedInstanceState) {
 super.onCreate(savedInstanceState);
 bt = new KetaiBluetooth(this);
}

void onActivityResult(int requestCode, int resultCode, Intent data) {
 bt.onActivityResult(requestCode, resultCode, data);
}

void setup() {
 size(displayWidth, displayHeight);
 frameRate(10);
 orientation(PORTRAIT);
 background(colorBackground);
 
 //start listening for BT connections
 bt.start();
 //at app start select device…
 isConfiguring = true;
 //font size
 fontMy = createFont("SansSerif", 40);
 textFont(fontMy);
 
 initializeInteractiveObjects();
 teamLogo = loadImage("teamLogo.png");
}

void draw() {
 //at app start select device
  background(colorBackground);
  drawTabs();
 
 if (isConfiguring)
 {
  ArrayList names;
  background(colorBackground);
  klist = new KetaiList(this, bt.getPairedDeviceNames());
  isConfiguring = false;
 }
 else if (flexTab.active)
 {
   drawArrows();
   fill(colorRed);
   textSize(30);
   textAlign(LEFT);
   text("Threshold: ",10, height/5 - 40);
   //textSize(40);
   textAlign(CENTER);
   int shift = 50;
   text("" + Thumb,width/7 + width/28 + shift, height/5 - 40);
   text("" + Index,width*2/7 + width/28 + shift, height/5 - 40);
   text("" + Middle,width*3/7 + width/28 + shift, height/5 - 40);
   text("" + Ring,width*4/7 + width/28 + shift, height/5 - 40);
   text("" + Pinky,width*5/7 + width/28 + shift, height/5 - 40);
   flexController.draw();
   
   //Serial Values
     int[] thresholdArray = 
  {
    100-Thumb, 100-Index, 100-Middle, 100-Ring, 100-Pinky  // , GyroLeft, GyroRight
  };
    fill(colorDarkBlue);
    text("Thumb",width/7 + width/28 + shift, height/5 - 140);
    text("Index",width*2/7 + width/28 + shift, height/5 - 140);
    text("Middle",width*3/7 + width/28 + shift, height/5 - 140);
    text("Ring",width*4/7 + width/28 + shift, height/5 - 140);
    text("Pinky",width*5/7 + width/28 + shift, height/5 -140);
    textAlign(LEFT);
    text("Value: ",10, height/5 - 90);
    textAlign(CENTER);
    for (int i = 1; i < 6; i++)
    {
      text("" + testSerial[i],width*i/7 + width/28 + shift, height/5 - 90);
      
      strokeWeight(15);
      if(int(testSerial[i]) > thresholdArray[i-1])
        stroke(colorRed);
      else
        stroke(colorDarkBlue);
        
      line(width*i/7 + 30, height/5 + 6*int(testSerial[i]) , width*i/7 + 70 + width/14,  height/5 + 6*int(testSerial[i])  );
    }

      strokeWeight(0);
      stroke(colorDarkBlue);

 }
 else if (gyroTab.active)
 {
    gyroController.draw(); 
    drawArrows();
    
    
  int[] thresholdArray = 
  {
    100-Thumb, 100-Index, 100-Middle, 100-Ring, 100-Pinky, GyroLeft, GyroRight
  };
      float theta = -int(testSerial[6])*3.1415/180;
      float x0 = width/2;
      float y0 = height/3;
      float r = 200;
      float x1 = x0 - r*cos(theta);
      float y1 = y0 - r*sin(theta);
      float x2 = x0 + r*cos(theta);
      float y2 = y0 + r*sin(theta);

      stroke(colorDarkBlue);
      strokeWeight(20);
      text(testSerial[6], x0, y0 + 300);
      
      if(int(testSerial[6]) < -thresholdArray[6] || int(testSerial[6]) > thresholdArray[5])
      {
        stroke(colorDarkRed);
      }
      else
      {
        stroke(colorDarkBlue); 
      }
      line(x1, y1, x2, y2);

      fill(colorRed);
      stroke(colorRed);
      theta = int(GyroLeft)*3.1415/180;
      x2 = x0 + r*cos(theta);
      y2 = y0 - r*sin(theta);
      line(x0, y0, x2, y2);

      theta = int(-GyroRight)*3.1415/180;
      x1 = x0 - r*cos(theta);
      y1 = y0 + r*sin(theta);
      line(x0, y0, x1, y1);

      text(GyroLeft, width/14 + 60, 220);
      text(-GyroRight, width - 175, 220);
      
      strokeWeight(0);

    
    
    
 }
 else if(configTab.active)
 {
   commandController.draw();
   drawArrows();
   
   textFont(SansSerifBold);
   fill(colorDarkBlue);
   textSize(40);
   int shiftX = -100;
   int shiftY = 50;
   
    text("Thumb", 225 +155 + shiftX, height/5 + shiftY);
    text("Index",225 +155*2+ shiftX, height/5 + shiftY);
    text("Middle",225 +155*3 + shiftX, height/5 + shiftY);
    text("Ring",225 +155*4+ shiftX, height/5 + shiftY);
    text("Pinky",225 +155*5 + shiftX, height/5 + shiftY);
    textAlign(LEFT);
    text("Forward", 20,550);
    text("Backward", 20,695);
   
 }
 else
 {
    //print received data
  fill(colorDarkBlue);
  textFont(SansSerifBold);

  //Display Team Logo
  textAlign(LEFT);
  image(teamLogo, 0, height - 400, width, teamLogo.height + (width - teamLogo.width)/2);
  textSize(40);
  text("Georgia Institute of Technology - 2015\n" +
       "Jonathan Talbott, Erin Hanson, Daniel Russell, \n" +
       "Justin Denard, Brian Nemsick",50,250);
       
  textFont(fontMy);
  noStroke();
  textAlign(CENTER);
  text(info, 20, 104);
  
  //Show sliders
   
 }
 
 
 
 
 
 
 
}

void onKetaiListSelection(KetaiList klist) {
 String selection = klist.getSelection();
 bt.connectToDeviceByName(selection);
 //dispose of list for now
 klist = null;
}

//Call back method to manage data received
void onBluetoothDataEvent(String who, byte[] data) {
 if (isConfiguring)
 return;
 
 //received
 String eventString = new String(data);
 String eventArray[] = eventString.split("\\r?\\n");
 
for(int i = 0; i < eventArray.length; i++)
{
if (eventArray[i] != null && eventArray[i].trim().length() > 2)
  {
    if (!eventArray[i].trim().substring(0).equals("!") && eventArray[i].trim().substring(eventArray[i].trim().length() - 1).equals("$"))
    {
      String check = eventArray[i].trim().substring(0, 2); //first 2 characters
      String value = eventArray[i].trim().substring(2, eventArray[i].trim().length() - 1); //last characters - EOL symbol $
      
      if (value.matches("-?\\d+(\\.\\d+)?"))
    {
      //println("Check: " + check);
      //println("Value: " + value);
      if (check.substring(0, 1).equals("F")) //its a flex value
      {
        switch (check.charAt(1))
        {
        case '0': 
          testSerial[1] = value;
          break;
        case '1': 
          testSerial[2] = value;
          break;
        case '2': 
          testSerial[3] = value;
          break;
        case '3': 
          testSerial[4] = value;
          break;
        case '4': 
          testSerial[5] = value;
          break;
        }
      } else if (check.substring(0, 1).equals("G")) //Gyro value
      {
        testSerial[6] = value;
      } else if (check.substring(0, 1).equals("A")) //Active Value
      {
        switch (check.charAt(1))
        {
        case '0': 
          testSerial[8] = value;
          break;
        case '1': 
          testSerial[9] = value;
          break;
        case '2': 
          testSerial[10] = value;
          break;
        case '3': 
          testSerial[11] = value;
          break;
        case '4': 
          testSerial[12] = value;
          break;
        }
      } else if (check.substring(0, 1).equals("C")) //Command Value
      {
        switch (check.charAt(1))
        {
        case 'L': 
          testSerial[14] = value;
          break;
        case 'R': 
          testSerial[15] = value;
          break;
        case 'F': 
          testSerial[16] = value;
          break;
        case 'B': 
          testSerial[17] = value;
          break;
        }
      }
    }
    }
  }
}
}

void mousePressed()
{
  flexTab.click(mouseX,mouseY);
  gyroTab.click(mouseX,mouseY);
  configTab.click(mouseX,mouseY);
  println("" + mouseX + "," + mouseY);
}




// Arduino+Bluetooth+Processing 
// Arduino-Android Bluetooth communication
