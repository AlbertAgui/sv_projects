#include <iostream>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <unistd.h>
#include <string>
#include <bits/stdc++.h>
#include <ctype.h>
#include <set>

using namespace std;
void reverseStr(string& str)
{
    int n = str.length();

    for (int i = 0; i < n / 2; i++)
        swap(str[i], str[n - i - 1]);
}

char * str_to_char(string &str) {
  char * cstr = new char[str.length()+1];
  strcpy (cstr, str.c_str());
  return cstr;
}

string r_param(string line, int pos, string sig, int s_size){
	//agafar nom entre ()
  //cout << "0123456789ABCDEFGHIJKLMNOP" << '\n' << "0    5    10   15   20" << '\n';
  //cout << "r_param" << '\n';

  string sig_temp = ""; 
  int i = pos + s_size; //.s^ (?)
  int size = line.size();
  while((i < size) and (line[i] != '(')) {
    ++i;
  }
  ++i;
  while((i < size) and (line[i] == ' ')) {
    ++i;
  }
  while((i < size) and (line[i] != ')') and (line[i] != ' ') ) {
    sig_temp += line[i];
    ++i;
  }
  while((i < size) and (line[i] != ')')) {
    ++i;
  }
  if((i >= size) or (line[i] != ')')) {
     return "";
  }
  return sig_temp;
}

string r_port(string line, int pos, string sig, int s_size){
	//agafar nom entre .(
  //cout << "0123456789ABCDEFGHIJKLMNOP" << '\n' << "0    5    10   15   20" << '\n';
  //cout << "r-port" << '\n';
  string sig_temp = "";
  int i = pos-1;//.? ^(s)

  while((i > -1) and (line[i] == ' ')) {
    --i;
  }
  while((i > -1) and (line[i] != '.') and (line[i] != ' ') ) {
    sig_temp += line[i];
    --i;
  }
  while((i > -1) and line[i] == ' ') {
    --i;
  }
  if((i<=-1) or (line[i] != '.')) {
    return "";
  }
  reverseStr(sig_temp);
  return sig_temp;
}

string read_line(int fd){
  char car;
  string line = "";
  while(((read(fd, &car, 1)) > 0) & (car != '\n'))//millorar
  {
    line += car;
  }
  return line;
}

string line_work(int fd, string sig)
{
  int ini = 0, i = 0;
  string line = read_line(fd);
  //cout << line;
  cout << "line:" << line << '\n';
  if((i = line.find(sig)) == -1)return "";
  ini = i; 
  cout << line << '\n';

  --i;
  while(i != -1)
  {
    char car =  line[i];
    if(car == ' ');
    else if(car == '.') return r_param(line,ini,sig,sig.size());//ini
    else if(car == '(') return r_port(line,i,sig,sig.size());//i
    else return "";
    --i;
  }
  return "";
}

int get_fd_size(int fd){
  int pos = lseek(fd,0,SEEK_CUR);
  int size = lseek(fd, 0, SEEK_END);
  lseek(fd,pos,SEEK_SET);
  return size;
}

bool sig_find(const set<string> &s_find_sig, const string& sig) {
  return s_find_sig.find(sig) != s_find_sig.end();
}

void add_sig_file(int fd, string sig) {
  char *str = str_to_char(sig);
  int pos = lseek(fd,0,SEEK_CUR);
  if(pos != 0)
    write(fd,"\n", strlen("\n"));
  write(fd, str, strlen(str));
}

void mv_fd_to_set(int fd, set<string> &Set) {
  int size = get_fd_size(fd);
  while ((lseek(fd,0,SEEK_CUR)) != size) {
    string sig = read_line(fd);
    Set.insert(sig);
  }
}

int main(int argc, char * argv[])
{
  const char *f1 = argv[1]; //input lanes
  const char *f2 = argv[2]; //input signals
  const char *f3 = argv[3]; //input finded signals
  const char *f4 = argv[4]; //output signals
  
  int fd_in_lan = open(f1,O_RDONLY);
  int fd_in_sig = open(f2,O_RDONLY);
  int fd_find = open (f3,O_RDWR);
  int fd_out_sig = open(f4,O_WRONLY|O_TRUNC|O_CREAT,0777);
  
  set<string> s_find, s_in_sig;
  mv_fd_to_set(fd_find, s_find);//init set of finded signals
  mv_fd_to_set(fd_in_sig, s_in_sig);
  lseek(fd_find,-1,SEEK_END);//to insert new values
  set<string>::iterator it = s_in_sig.begin();

  int size = get_fd_size(fd_in_lan);
  string name, sig;
  
  while(it != s_in_sig.end()) {
    cout << "sig: " << (*it) << '\n';
    sig = (*it);
    while ((lseek(fd_in_lan,0,SEEK_CUR)) != size)//work in al lanes
    {
      name = line_work(fd_in_lan, sig);

      if(name.compare("") != 0) {//if we have a new signal
        cout << "name1: " << name << '\n';
        if(not sig_find(s_find, name)) {//sig was find previously?
	  s_find.insert(name);
          cout << "name2: " << name << '\n';
          add_sig_file(fd_find, name);
          add_sig_file(fd_out_sig, name);//add new sig to find
        }
     }
    }
    ++it;
  }
  close(fd_in_lan);
  close(fd_in_sig);
  close(fd_find);
  close(fd_out_sig);
}
