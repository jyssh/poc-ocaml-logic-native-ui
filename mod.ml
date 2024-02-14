let rec fib n = if n < 2 then 1 else fib(n-1) + fib(n-2)

let say_hello name = match name with
| "" -> "Hello, world!"
| v -> "Hello, " ^ v ^ "!" 


let handle_greet data =
  let person = data |> Pbrt.Decoder.of_bytes |> Messages_pb.decode_person in
  "Hello, " ^ person.name ^ "!"

let message typ data =
  match typ with
  | "greet" -> handle_greet data
  | _ -> "Invalid message"

(* Export functions to C *)

let _ = Callback.register "fib" fib
let _ = Callback.register "say_hello" say_hello
let _ = Callback.register "message" message
