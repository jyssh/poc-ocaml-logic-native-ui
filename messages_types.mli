(** messages.proto Types *)



(** {2 Types} *)

type person = {
  name : string;
  id : int32;
  email : string option;
  phone : string list;
}


(** {2 Default values} *)

val default_person : 
  ?name:string ->
  ?id:int32 ->
  ?email:string option ->
  ?phone:string list ->
  unit ->
  person
(** [default_person ()] is the default value for type [person] *)
