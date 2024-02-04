let rec fib n = if n < 2 then 1 else fib(n-1) + fib(n-2)

let format_result n = Printf.sprintf "Result is: %d\n" n

let say_hello name = match name with
| "" -> "Hello, world!"
| v -> "Hello, " ^ v ^ "!" 

(* Export those two functions to C *)

let _ = Callback.register "fib" fib
let _ = Callback.register "say_hello" say_hello
let _ = Callback.register "format_result" format_result

