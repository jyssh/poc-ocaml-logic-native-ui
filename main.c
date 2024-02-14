/* File main.c -- a sample client for the OCaml functions */

#include <stdio.h>
#include <caml/callback.h>

extern int fib(int n);
extern char * say_hello(char * name);
extern char * message(char * typ, unsigned char * data);

int main(int argc, char ** argv)
{
  int result;

  /* Initialize OCaml code */
  caml_startup(argv);
  /* Do some computation */
  result = fib(10);
  printf("fib(10) = %d\n", result);
  printf("%s\n", say_hello("Jayesh"));
  printf("%s\n", message("greet", "hello"));
  return 0;
}
