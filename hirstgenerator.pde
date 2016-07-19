import java.util.Random;

color[] dots;
int w;
int h;

Random rand = new Random();
Table colors;
int ccount;
boolean iscircular = false;

boolean animals = true;
Table animallist;
int acount;

Message msg;

void setup(){
  println(displayWidth + " , " + displayHeight);
  w = displayWidth / 20;
  h = displayHeight / 20;
  dots = new color[w * h];
  println(w + " , " + h);
  
  //from hirstanalyzer
  colors = loadTable("largehirstcolors.csv", "header");
  ccount = colors.getRowCount();
  println("no of colors: " + ccount);
  
  msg = new Message();
  if(animals){
    animallist = loadTable("animals.csv", "header");
    acount = animallist.getRowCount();
    msg.update("put your " + animallist.getString((int)random(acount), "Animal") + " in formaldehyde");
  }
  
  randomize();
  noCursor();
  noStroke();
  background(255, 255, 250);
  textSize(20);
  mousePressed();
}

void settings(){
  fullScreen();
}

void draw(){
  /*
  fill(255);
  rect(0, 0, 601, 62);
  for(int i = 0; i < 30; i ++){
    for(int j = 0; j < 3; j ++){
      fill(dots[i * h + j]);
      ellipse(13 + 20*i, 14 + 20*j, 12, 12);
    }
  }
  msg.render();
  */
}

void circular(){
  background(255);
  fill(dots[0]);
  circle(0, 0);
  
  for(int i = 0; i < 19; i ++){//ring
    for(int j = 0; j < 6 * i; j ++){//circle
      fill(dots[i*(i+1)*3 + j + 1]);
      circle(i * 20, TAU* j/(6*i));
    }
  }
}

void circle(float r, float theta){
  ellipse(displayWidth / 2 + r*cos(theta), displayHeight / 2 + r*sin(theta), 17, 17);
}

void refresh(){
  background(255);
  for(int i = 0; i < w; i ++){
    for(int j = 0; j < h; j ++){
      fill(dots[i * h + j]);
      ellipse(13 + 20*i, 14 + 20*j, 12, 12);
    }
  }
}

void randomize(){
  for(int i = 0; i < w; i ++){
    for(int j = 0; j < h; j ++){
      dots[i * h + j] = hirstian();
    }
  }
}

color hirstian(){
  int r, g, b;
  int i = (int)random(ccount);
  r = colors.getInt(i, "r");
  g = colors.getInt(i, "g");
  b = colors.getInt(i, "b");
  return color(r, g, b);
}

//generates color with ish the same distribution as Hirst's colors
color randomcolor(){
  int r, g, b;
  //red
  if(rand.nextFloat() < .45){
    r = rand.nextInt(200);
  }
  else{
    r = (int)(230 + 20 * rand.nextGaussian());
    if(r > 255)
      r = 0;
  }
  //green
  if(rand.nextFloat() < .55){
    g = rand.nextInt(200);
  }
  else{
    g = (int)(240 + 15 * rand.nextGaussian());
    if(g > 255)
      g = 255;
  }
  //blue
  if(rand.nextFloat() < .55){
    b = rand.nextInt(200);
  }
  else{
    b = (int)(230 + 30 * rand.nextGaussian());
    if(b > 255)
      b = 255;
  }
  
  return color(r, g, b);
}

void mousePressed(){
  randomize();
  if(iscircular){
    circular();
    //saveFrame("####.png");
  }
  else
    refresh();
  if(animals){
    msg.update("put your " + animallist.getString((int)random(acount), "Animal") + " in formaldehyde");
  }
}

void keyPressed(){
  if(key == ' '){
    iscircular = !iscircular;
    mousePressed();
  }
}