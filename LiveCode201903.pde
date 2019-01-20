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
    if (frameCount > 500) {
      exit();
    }
  }
}

// save a snapshot on keypress
void keyPressed() {
  saveFrame("snap####.png");
}

class Flattener {
  
  final float MAX_SPEED = .02;
  PGraphics pg;
  color bg;
  color fg;

  float rx, ry, rz;
  float dx, dy, dz;
  PShape shape;
  
  Flattener() {
    rx = random(TWO_PI);
    ry = random(TWO_PI);
    rz = random(TWO_PI);
    dx = random(-MAX_SPEED, MAX_SPEED);
    dy = random(-MAX_SPEED, MAX_SPEED);
    dz = random(-MAX_SPEED, MAX_SPEED);
    pg = createGraphics(width, height, P3D);
    bg = color(random(0, 256), random(0, 256), random(0, 256));
    fg = color(random(0, 256), random(0, 256), random(0, 256));
    shape = createShape(BOX, 350);
  }
  
  PImage getImage(PImage img) {
    rx += dx;
    ry += dy;
    rz += dz;
    
    pg.beginDraw();
    pg.translate(pg.width / 2, pg.height / 2);
    pg.background(bg);
    pg.rotateX(rx);
    pg.rotateY(ry);
    pg.rotateZ(rz);
    if (img == null) {
      // initial drawing
      pg.noFill();
      pg.stroke(fg);
      pg.strokeWeight(5);
      pg.box(200);
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
}