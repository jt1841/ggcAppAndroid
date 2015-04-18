void initializeInteractiveObjects()
{
  int slant = 75;
  int h = 150;
  flexTab = new Tab("Flex Settings", 0, width/3, 0, width/3 - slant, h, colorDarkRed);
  gyroTab = new Tab("Gyro Settings", width/3, width*2/3, width/3 - slant, width*2/3 - slant, h, colorDarkBlue);
  configTab = new Tab("Control Settings", width*2/3, width, width * 2 /3 - slant, width, h, colorDarkRed);

  flexController = new ControlP5(this); //Sliders for flex and gyro threshold values
  flexController.setAutoDraw(false); 
  gyroController = new ControlP5(this);
  gyroController.setAutoDraw(false);
  commandController = new ControlP5(this);
  commandController.setAutoDraw(false);

  int spacing = 7;
  int shift = 50;
  flexController.addSlider("Thumb", 0, 100, Thumb, width/spacing + shift, height/5, width/14, 600)
    .setColorForeground(colorRed)
      .setLabelVisible(false)
        .setColorActive(colorDarkRed);
  flexController.addSlider("Index", 0, 100, Index, width*2/spacing + shift, height/5, width/14, 600)
    .setColorForeground(colorRed)
      .setLabelVisible(false)
        .setColorActive(colorDarkRed);
  flexController.addSlider("Middle", 0, 100, Middle, width*3/spacing + shift, height/5, width/14, 600)
    .setColorForeground(colorRed)
      .setLabelVisible(false)
        .setColorActive(colorDarkRed);
  flexController.addSlider("Ring", 0, 100, Ring, width*4/spacing + shift, height/5, width/14, 600)
    .setColorForeground(colorRed)
      .setLabelVisible(false)
        .setColorActive(colorDarkRed);
  flexController.addSlider("Pinky", 0, 100, Pinky, width*5/spacing + shift, height/5, width/14, 600)
    .setColorForeground(colorRed)
      .setLabelVisible(false)
        .setColorActive(colorDarkRed);
        
  gyroController.addSlider("GyroLeft", 0, 90, GyroLeft, 100, height/7, width/14, 600)
  .setColorForeground(colorRed)
    .setLabelVisible(false)
      .setColorActive(colorDarkRed);
  gyroController.addSlider("GyroRight", 0, 90, GyroRight, width - 200, height/7, width/14, 600)
  .setColorForeground(colorRed)
    .setLabelVisible(false)
      .setColorActive(colorDarkRed);

  checkbox = commandController.addCheckBox("checkBox")
    .setPosition(225, 450)
      .setColorForeground(color(colorDarkBlue))
        .setColorActive(color(colorRed))
            .setSize(125, 125)
            .setColorLabel(colorBackground)
              .setItemsPerRow(5)
                .setSpacingColumn(30)
                  .setSpacingRow(20)
                    .addItem("FThumb", 0)
                      .addItem("FIndex", 50)
                        .addItem("FMiddle", 100)
                          .addItem("FRing", 150)
                            .addItem("FPinky", 200)
                              .addItem("BThumb", 0)
                                .addItem("BIndex", 50)
                                  .addItem("BMiddle", 100)
                                    .addItem("BRing", 150)
                                      .addItem("BPinky", 200)
                                        ; 

}

