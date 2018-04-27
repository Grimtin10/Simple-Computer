public class CPU{
  public boolean hlt=false;
  
  char[] ram;
  char[] rom;
  char[] stack;
  char[] spriteMem;
  
  public CPU(int ramSize,int romSize,int stackSize){
    ram=new char[ramSize];
    rom=new char[romSize];
    stack=new char[stackSize];
    spriteMem=new char[0xFF*0xFF];
  }
  
  char pc=0x0000;
  char sp=0x00;
  char a=0x00;
  char b=0x00;
  char c=0x00;
  boolean overflow;
  boolean jmp=false;
  
  public void loadRom(char[] rom){
    this.rom=rom;
  }
  
  public void clock(boolean debug){
    if(pc<rom.length&&pc<=0xFFFF){
      jmp=false;
      char command = rom[pc];
      char inputs = (char) (((rom[pc+1] << 8) | (rom[pc+2] << 0)));
      if(debug){
        print("Opcode: " + Integer.toHexString(command) + " with inputs: " + Integer.toHexString(inputs) + " at " + (int)(pc) + " : ");
      }
      switch(command){
        case 0x00:
          if(debug){
          println("NO-OP");
          }
        break;
        case 0x01:
          if(debug){
            println("Storing: "+((inputs&0xFF00)>>8)+" at "+(inputs&0x00FF));
          }
          ram[inputs&0x00FF]=(char)((inputs&0xFF00)>>8);
        break;
        case 0x02:
          println("Ram at: "+((inputs&0xFF00)>>8)+" is "+(int)ram[((inputs&0x00FF)>>8)]);
        break;
        case 0x03:
          if(debug){
            println("Toggling pixel at x: "+((inputs&0xFF00)>>8)+" y: "+(inputs&0x00FF));
          }
          toggle(((inputs&0xFF00)>>8),(inputs&0x00FF));
        break;
        case 0x04:
          if(debug){
            println("Storing: "+((inputs&0xFF00)>>8)+" into register a");
          }
          a=(char)((inputs&0xFF00)>>8);
        break;
        case 0x05:
          if(debug){
            println("Storing: "+((inputs&0xFF00)>>8)+" into register b");
          }
          b=(char)((inputs&0xFF00)>>8);
        break;
        case 0x06:
          if(debug){
            println("Storing: "+((inputs&0xFF00)>>8)+" into register c");
          }
          c=(char)((inputs&0xFF00)>>8);
        break;
        case 0x07:
          if(debug){
            println("Toggling pixel at x: "+(int)a+" y: "+(int)b);
          }
          toggle(a,b);
        break;
        case 0x08:
          if(debug){
            println("Adding "+((inputs&0xFF00)>>8)+" into register a result: "+(int)(a+((inputs&0xFF00)>>8)));
          }
          if((a+((inputs&0xFF00)>>8))<=255){
            a+=((inputs&0xFF00)>>8);
            overflow=false;
          } else {
            overflow=true;
          }
        break;
        case 0x09:
          if(debug){
            println("Adding "+((inputs&0xFF00)>>8)+" into register b result: "+(int)(b+((inputs&0xFF00)>>8)));
          }
          if((b+((inputs&0xFF00)>>8))<=255){
            b+=((inputs&0xFF00)>>8);
            overflow=false;
          } else {
            overflow=true;
          }
        break;
        case 0x0A:
          if(debug){
            println("Adding "+((inputs&0xFF00)>>8)+" into register c");
          }
          if((c+((inputs&0xFF00)>>8))<=255){
            c+=((inputs&0xFF00)>>8);
            overflow=false;
          } else {
            overflow=true;
          }
        break;
        case 0x0B:
          if(debug){
            println("Adding register b into register a");
          }
          if((a+b)<=255){
            a+=b;
            overflow=false;
          } else {
            overflow=true;
          }
        break;
        case 0x0C:
          if(debug){
            println("Adding register c into register a");
          }
          if((a+c)<=255){
            a+=c;
            overflow=false;
          } else {
            overflow=true;
          }
        break;
        case 0x0D:
          if(debug){
            println("Adding register a into register b");
          }
          if((b+a)<=255){
            b+=a;
            overflow=false;
          } else {
            overflow=true;
          }
        break;
        case 0x0E:
          if(debug){
            println("Adding register c into register b");
          }
          if((b+c)<=255){
            b+=c;
            overflow=false;
          } else {
            overflow=true;
          }
        break;
        case 0x0F:
          if(debug){
            println("Adding register a into register c");
          }
          if((c+a)<=255){
            c+=a;
            overflow=false;
          } else {
            overflow=true;
          }
        break;
        case 0x10:
          if(debug){
            println("Adding register b into register c");
          }
          if((c+b)<=255){
            c+=b;
            overflow=false;
          } else {
            overflow=true;
          }
        break;
        case 0x11:
          if(debug){
            println("Jumping to: "+(int)inputs);
          }
          pc=inputs;
          jmp=true;
        break;
        case 0x12:
          if(overflow){
           if(debug){
             println("Jumping to: "+(int)inputs);
           }
           pc=inputs;
           jmp=true;
          } else if(debug){
            println("Overflow not enabled, not jumping.");
          }
        break;
        case 0x13:
          if(debug){
            println("Storing: register A at "+Integer.toHexString(inputs));
          }
          ram[inputs]=a;
        break;
        case 0x14:
          if(debug){
            println("Storing: register B at "+Integer.toHexString(inputs));
          }
          ram[inputs]=b;
        break;
        case 0x15:
          if(debug){
            println("Storing: register C at "+Integer.toHexString(inputs));
          }
          ram[inputs]=c;
        break;
        case 0x16:
          if(debug){
            println("Setting B to A");
          }
          b=a;
        break;
        case 0x17:
          if(debug){
            println("Setting C to A");
          }
          c=a;
        break;
        case 0x18:
          if(debug){
            println("Setting A to B");
          }
          a=b;
        break;
        case 0x19:
          if(debug){
            println("Setting C to B");
          }
          c=b;
        break;
        case 0x1A:
          if(debug){
            println("Setting A to C");
          }
          a=c;
        break;
        case 0x1B:
          if(debug){
            println("Setting B to C");
          }
          b=c;
        break;
        case 0x1C:
          if(debug){
            println("Loading: register A from ram at "+Integer.toHexString((inputs&0xFF00)>>8));
          }
          a=ram[((inputs&0xFF00)>>8)];
        break;
        case 0x1D:
          if(debug){
            println("Loading: register B from ram at "+Integer.toHexString((inputs&0xFF00)>>8));
          }
          b=ram[((inputs&0xFF00)>>8)];
        break;
        case 0x1E:
          if(debug){
            println("Loading: register C from ram at "+Integer.toHexString((inputs&0xFF00)>>8));
          }
          c=ram[((inputs&0xFF00)>>8)];
        break;
        case 0x1F:
          println("Halting");
          exit();
        break;
        case 0x20:
          if(debug){
            println("Storing sprite info at row: "+(inputs&0x00FF));
          }
          spriteMem[(inputs&0x00FF)]=(char)((inputs&0xFF00)>>8);
        break;
        case 0x21:
          if(debug){
            println("Drawing sprite at x:"+(int)a+" y: "+(int)b);
          }
          boolean[][] sprite = new boolean[8][8];
          for(int x=0;x<8;x++){
            for(int y=0;y<8;y++){
              //println(Integer.toBinaryString(spriteMem[((inputs&0xFF00)>>8)+y]).length(),Integer.toBinaryString(spriteMem[((inputs&0xFF00)>>8)+y]).charAt(x));
              sprite[x][y]=false;
              String binary = Integer.toBinaryString(spriteMem[((inputs&0xFF00)>>8)+y]);
              binary = checkBinary(binary,8);
              if(binary.charAt(x)=='1'){
                sprite[x][y]=true;
              }
            }
          }
          for(int x=0;x<sprite.length;x++){
            for(int y=0;y<sprite[0].length;y++){
              if(sprite[x][y]){
               toggle(a+x,b+y);
             }
           }
         }
        break;
        default:
          if(debug){
            println("Operation not implemented!");
          }
          exit();
        break;
      }
      if(!jmp){
        pc+=3;
      }
    } else {
      hlt=true;
    }
  }
  
  String checkBinary(String binary, int desiredLength) {
    String newBinary = binary;
    
    if(binary.length()<desiredLength){
      for(int i=desiredLength-binary.length();i>=0;i--){
        newBinary = insert(newBinary,'0',0);
      }
    }
    
    return newBinary;
  }
  
  String insert(String original,char toInsert,int position){
    String p1 = original.substring(0,position);
    String p2 = original.substring(position);
    return p1 + toInsert + p2;
  }
}