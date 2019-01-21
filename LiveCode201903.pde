import peasy.*;

// LiveCode201903 2019-01-20 10:59:36

boolean video = false;
PeasyCam cam;
PImage img1, img2, img3, img4;
Flattener flattener1, flattener2, flattener3, flattener4;

void setup() {
  size(800, 800, P3D);
  //cam = new PeasyCam(this, 500);
  flattener1 = new Flattener();
  flattener2 = new Flattener();
  flattener3 = new Flattener();
  flattener4 = new Flattener();
}

void draw() {

  img1 = flattener1.getImage(null);
  img2 = flattener2.getImage(img1);
  img3 = flattener3.getImage(img2);
  img4 = flattener4.getImage(img3);
  image(img4, 0, 0);

  // video stuff
  if (video) {
    saveFrame("frame#####.png");
    if (frameCount >= 180) {
      exit();
    }
  }
}

// save a snapshot on keypress
void keyPressed() {
  saveFrame("snap####.png");
}

class Flattener {
  
  final int MAX_SPEED = 3;
  PGraphics pg;
  color bg;
  color fg;

  int rx, ry, rz;
  int dx, dy, dz;
  PShape shape;
  
  Flattener() {
    rx = (int)random(360);
    ry = (int)random(360);
    rz = (int)random(360);
    dx = randomSpeed();
    dy = randomSpeed();
    dz = randomSpeed();
    pg = createGraphics(width, height, P3D);
    bg = 255; //color(random(0, 256), random(0, 256), random(0, 256));
    fg = 0; //color(random(0, 256), random(0, 256), random(0, 256));
    shape = createShape(BOX, 350);
  }
  
  PImage getImage(PImage img) {
    rx += dx;
    ry += dy;
    rz += dz;
    
    pg.beginDraw();
    pg.translate(pg.width / 2, pg.height / 2);
    pg.background(bg);
    pg.rotateX(radians(rx));
    pg.rotateY(radians(ry));
    pg.rotateZ(radians(rz));
    if (img == null) {
      // initial drawing
      pg.noFill();
      pg.stroke(0);
      pg.strokeWeight(5);
      pg.box(250);
    } else {
      // textured box
      shape.setStrokeWeight(5);
      shape.textureMode(IMAGE);
      shape.setTexture(img);
      pg.shape(shape);
    }
    pg.endDraw();

    return pg;
  }
  
  // picks a random speed
  int randomSpeed() {
    int[] speed = {-4, -2, 0, 2, 4};
    return speed[(int)random(speed.length)];
  }
}