#include <curses.h>
#include <stdio.h>

int main(void)
{
    // use the correct type, see https://linux.die.net/man/3/getch
    int k;

    // init curses:
    initscr();

    // in curses, you have to use curses functions for all terminal I/O
    addstr("How are you?");

    k = getch();

    // end curses:
    endwin();

    printf("You entered %c\n", k);

    return 0;
}