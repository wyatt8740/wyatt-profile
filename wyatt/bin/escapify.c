#include <stdio.h>
#include <string.h>
int main(int argc, char **argv)
{
  char c='\0';
  int i=0;
  if(argc == 2)
  {
    while(i<strlen(argv[1]))
    {
      c=argv[1][i];
      /* this switch has no breaks on purpose. */
      switch(c)
      {
      case ';':
      case '\'':
      case ' ':
      case '!':
      case '"':
      case '#':
      case '$':
      case '&':
      case '(':
      case ')':
      case '|':
      case '*':
      case ',':
      case '<':
      case '>':
      case '[':
      case ']':
      case '\\':
      case '^':
      case '`':
      case '{':
      case '}':
        putchar('\\');
      default:
        putchar(c);
      }
      i++;
    }
  }
  else
  {
    fprintf(stderr,"Error: Exactly one argument should be given: a string to shell-escape.\n");
  }
  /* newline at end */
  putchar ('\n');
  return 0;
}
