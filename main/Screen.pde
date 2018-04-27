public class Screen{
  boolean[][] screen;
  boolean[][] differences;
  
  public Screen(int w,int h){
    screen=new boolean[w][h];
    differences=new boolean[w][h];
  }
  
  public void drawScreen(float size){
    for(int x=0;x<screen.length;x++){
      for(int y=0;y<screen[0].length;y++){
        noStroke();
        if(differences[x][y]){
          rect(x*size,y*size,size,size);
          fill((screen[x][y])?255:0);
        }
      }
    }
  }
  
  public void difference(boolean[][] s){
    for(int x=0;x<s.length;x++){
      for(int y=0;y<s[0].length;y++){
        differences[x][y]=false;
      } 
    }
    for(int x=0;x<s.length;x++){
      for(int y=0;y<s[0].length;y++){
        if(s[x][y]!=screen[x][y]){
          differences[x][y]=true;
        }
      } 
    }
  }
  
  public void updateScreen(boolean[][] s){
    for(int i=0;i<s.length;i++){
      arrayCopy(s[i],screen[i]);
    }
  }
}