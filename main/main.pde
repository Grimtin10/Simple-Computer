/*char[] rom = {0x04,0x00,0x00,0x05,0x01,0x00,0x06,0x00,0x00,0x14,0x00,0x00,0x0D,0x00,0x00,
0x19,0x00,0x00,0x15,0x01,0x00,0x02,0x01,0x00,0x1D,0x00,0x00,0x18,0x00,0x00,0x1B,0x00,0x00,
0x07,0x00,0x00,0x12,0x2A,0x00,0x11,0x09,0x00,0x11,0x00,0x00}; //33*/
//char[] rom = {0x04,0x01,0x00,0x05,0xFE,0x00,0x0B,0x00,0x00,0x13,0x00,0x00,0x02,0x00,0x00};
//char[] rom = {0x03,0x00,0x00,0x04,0x00,0x00,0x05,0x00,0x00,0x08,0x01,0x00,0x12,0x15,0x00,
//0x07,0x00,0x00,0x11,0x09,0x00,0x09,0x01,0x00,0x04,0x00,0x00,0x12,0x00,0x00,0x07,0x00,0x00,0x11,0x09,0x00};
char[] rom = {0x20,0x82,0x00,0x20,0x82,0x01,0x20,0x82,0x02,0x20,0xFE,0x03,0x20,0xFE,0x04,
0x20,0x82,0x05,0x20,0x82,0x06,0x20,0x82,0x07,0x21,0x00,0x00,0x20,0xFF,0x08,0x20,0x30,0x09
,0x20,0x30,0x0A,0x20,0x30,0x0B,0x20,0x30,0x0C,0x20,0x30,0x0D,0x20,0x30,0x0E,0x20,0xFF,0x0F,0x08,0x08,0x00,0x21,0x08,0x00};
CPU cpu = new CPU(256,256,24);
Screen screen = new Screen(256,256);
boolean[][] s = new boolean[256][256];

void setup(){
  size(1024,1024);
  cpu.loadRom(rom);
  frameRate(1000);
  screen.updateScreen(s);
  background(0);
}

void draw(){
  if(!cpu.hlt){
    cpu.clock(false);
    screen.difference(s);
    screen.updateScreen(s);
    screen.drawScreen(4);
    surface.setTitle("FPS: "+frameRate);
  }
}

public void toggle(int x,int y){
  s[x][y]=!s[x][y];
}