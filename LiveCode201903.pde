import peasy.*;

// LiveCode201903 2019-01-20 10:59:36

boolean video = false;
float rx, ry, rz;
float dx, dy, dz;
float r2x, r2y, r2z;
float d2x, d2y, d2z;
PShape shape;
PGraphics img;
PeasyCam cam;

void setup() {
  size(600, 600, P3D);
  cam = new PeasyCam(this, 500);
  img = createGraphics(400, 400, P3D);
  dx = random(-.04, .04);
  dy = random(-.04, .04);
  dz = random(-.04, .04);
  d2x = random(-.03, .03);
  d2y = random(-.03, .03);
  d2z = random(-.03, .03);
}

void draw() {

  rx += dx;
  ry += dy;
  rz += dz;
  r2x += d2x;
  r2y += d2y;
  r2z += d2z;
  
  img.beginDraw();
  img.background(255, 0, 0);
  img.noFill();
  img.stroke(255);
  img.strokeWeight(5);
  img.translate(img.width / 2, img.height / 2);
  img.rotateX(rx);
  img.rotateY(ry);
  img.rotateZ(rz);
  img.box(200);
  img.endDraw();
  
  background(0);
  rotateX(r2x);
  rotateY(r2y);
  rotateZ(r2z);
  shape = createShape(BOX, 100);
  shape.textureMode(IMAGE);
  shape.setTexture(img);
  shape.setStroke(false);
  shape(shape);

  //image(img, 0, 0, 100, 100);

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