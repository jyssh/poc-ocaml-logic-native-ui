void caml_startup(char ** argv);
int fib(int n);
char * say_hello(char * name);
char * message(char * typ, unsigned char * data, int data_length);

typedef struct Message {
    char * type;
    unsigned char * data;
    unsigned int length;
} Message;

char * message2(Message * msg);

