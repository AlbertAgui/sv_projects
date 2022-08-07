#include <iostream>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <unistd.h>
#include <string>
#include <bits/stdc++.h>
#include <ctype.h>
#include <set>
#include <stdio.h>
#include <ncursesw/curses.h>

using namespace std;

int width = 10;
int height = 10;

int x = 0;
int y = 0;

void move_player(char key){
    if(key == 'w')
    {
      if(y>0)
      {
      --y;
      }
    }
    else if (key == 's')
    {
      if(y < (height-1))
      {
      ++y;
      }
    }
    else if (key == 'a')
    {
      if(x > 0)
      {
      --x;
      }
    }
    else if (key == 'd')
    {
      if(x < (width-1))
      {
      ++x;
      }
    }
}


/*string read_line(int fd){
  char car;
  string line = "";
  while(((read(fd, &car, 1)) > 0) & (car != '\n'))//millorar
  {
    line += car;
  }
  return line;
}

int get_fd_size(int fd){
  int pos = lseek(fd,0,SEEK_CUR);
  int size = lseek(fd, 0, SEEK_END);
  lseek(fd,pos,SEEK_SET);
  return size;
}*/


int main(int argc, char * argv[]) {
  
  //..map
  char floor = '-';

  //..player
  char player = 'P';
  int key;

  //const char *f = argv[1];
  //int fd_find = open (f,O_RDWR);
  //int fd_find = open (f,O_RDONLY);

  //..read map
  //int size = get_fd_size(fd);
  //string header = read_line(fd);
   
  while(1){
  while((key = getch()) != 1){}
   //getch();
    //system("clear");
    cout << key << endl;
    //move_player(key);

    /*for(int i=0; i<height; ++i)
    {
      for(int j=0; j<width; ++j)
      {
        if((i == y) && (j == x))
	{
	  cout << player;
	}
	else
	{
	  cout << floor;
	}
      }
        cout << '\n';
    }*/
  }
}
