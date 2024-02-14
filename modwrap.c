/* File modwrap.c -- wrappers around the OCaml functions */

#include <stdio.h>
#include <string.h>
#include <caml/mlvalues.h>
#include <caml/memory.h>
#include <caml/alloc.h>
#include <caml/callback.h>

int fib(int n)
{
  static const value * fib_closure = NULL;
  if (fib_closure == NULL) {
    fib_closure = caml_named_value("fib");
  }
  return Int_val(caml_callback(*fib_closure, Val_int(n)));
}

char * say_hello(char * s)
{
  static const value * closure = NULL;
  if (closure == NULL) {
    closure = caml_named_value("say_hello");
  }
  value str = caml_alloc_initialized_string(strlen(s), s);
  return strdup(String_val(caml_callback(*closure, str)));
  /* We copy the C string returned by String_val to the C heap
     so that it remains valid after garbage collection. */
}

char * message(char * typ, unsigned char * data, int data_length)
{
  CAMLparam0();
  CAMLlocal3(msg_type, msg_data, result);

  static const value * closure = NULL;
  if (closure == NULL) {
    closure = caml_named_value("message");
  }
  
  msg_type = caml_copy_string(typ);
  // msg_data = caml_copy_string((char *) data);
  msg_data = caml_alloc_initialized_string(data_length, (char *) data);
  
  result = caml_callback2(*closure, msg_type, msg_data);

  CAMLreturnT (char *, strdup(String_val(result)));
}
