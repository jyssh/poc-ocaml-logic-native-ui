/* File modwrap.c -- wrappers around the OCaml functions */

#include <stdio.h>
#include <string.h>
#include <caml/mlvalues.h>
#include <caml/memory.h>
#include <caml/alloc.h>
#include <caml/callback.h>
#include <caml/custom.h>

typedef struct Message {
    char * type;
    unsigned char * data;
    unsigned int length;
} Message;

// #define Message_val(v) (*((Message **) Data_custom_val(v)))

static struct custom_operations comm_message = {
  "net.jysh.abi.message",
  custom_finalize_default,
  custom_compare_default,
  custom_hash_default,
  custom_serialize_default,
  custom_deserialize_default,
  custom_compare_ext_default,
  custom_fixed_length_default
};

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
  msg_data = caml_alloc_initialized_string(data_length, (char *) data);
  
  result = caml_callback2(*closure, msg_type, msg_data);

  CAMLreturnT (char *, strdup(String_val(result)));
}

// char * message2(Message * msg) {
//   CAMLparam0();
//   CAMLlocal4(value_msg, msg_type, msg_data, result);

//   static const value * closure = NULL;
//   if (closure == NULL) {
//     closure = caml_named_value("message");
//   }

//   value_msg = caml_alloc_custom(&comm_message, sizeof(Message), 0, 1);

//   // Message_val(value_msg) = msg;

//   if(value_msg) {
//     Message * m = (Message *)Data_custom_val(res);
//     m->type = msg->type;
//     m->
//   }

//   msg_type = caml_copy_string(value_msg->type);
//   msg_data = caml_alloc_initialized_string(value_msg->data_length, (char *) value_msg->data);

//   result = caml_callback2(*closure, msg_type, msg_data);

//   CAMLreturnT (char *, strdup(String_val(result)));
// }

char * message2(Message * msg) {
  CAMLparam0();
  CAMLlocal3(msg_type, msg_data, result);

  static const value * closure = NULL;
  if (closure == NULL) {
    closure = caml_named_value("message");
  }

  msg_type = caml_copy_string(msg->type);
  msg_data = caml_alloc_initialized_string(msg->length, (char *) msg->data);

  result = caml_callback2(*closure, msg_type, msg_data);

  CAMLreturnT (char *, strdup(String_val(result)));
}