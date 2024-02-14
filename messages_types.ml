[@@@ocaml.warning "-27-30-39"]


type person = {
  name : string;
  id : int32;
  email : string option;
  phone : string list;
}

let rec default_person 
  ?name:((name:string) = "")
  ?id:((id:int32) = 0l)
  ?email:((email:string option) = None)
  ?phone:((phone:string list) = [])
  () : person  = {
  name;
  id;
  email;
  phone;
}
