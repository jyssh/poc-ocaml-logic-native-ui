[@@@ocaml.warning "-27-30-39"]

type person_mutable = {
  mutable name : string;
  mutable id : int32;
  mutable email : string option;
  mutable phone : string list;
}

let default_person_mutable () : person_mutable = {
  name = "";
  id = 0l;
  email = None;
  phone = [];
}


let rec decode_person d =
  let v = default_person_mutable () in
  let continue__= ref true in
  let id_is_set = ref false in
  let name_is_set = ref false in
  while !continue__ do
    match Pbrt.Decoder.key d with
    | None -> (
      v.phone <- List.rev v.phone;
    ); continue__ := false
    | Some (1, Pbrt.Bytes) -> begin
      v.name <- Pbrt.Decoder.string d; name_is_set := true;
    end
    | Some (1, pk) -> 
      Pbrt.Decoder.unexpected_payload "Message(person), field(1)" pk
    | Some (2, Pbrt.Varint) -> begin
      v.id <- Pbrt.Decoder.int32_as_varint d; id_is_set := true;
    end
    | Some (2, pk) -> 
      Pbrt.Decoder.unexpected_payload "Message(person), field(2)" pk
    | Some (3, Pbrt.Bytes) -> begin
      v.email <- Some (Pbrt.Decoder.string d);
    end
    | Some (3, pk) -> 
      Pbrt.Decoder.unexpected_payload "Message(person), field(3)" pk
    | Some (4, Pbrt.Bytes) -> begin
      v.phone <- (Pbrt.Decoder.string d) :: v.phone;
    end
    | Some (4, pk) -> 
      Pbrt.Decoder.unexpected_payload "Message(person), field(4)" pk
    | Some (_, payload_kind) -> Pbrt.Decoder.skip d payload_kind
  done;
  begin if not !id_is_set then Pbrt.Decoder.missing_field "id" end;
  begin if not !name_is_set then Pbrt.Decoder.missing_field "name" end;
  ({
    Messages_types.name = v.name;
    Messages_types.id = v.id;
    Messages_types.email = v.email;
    Messages_types.phone = v.phone;
  } : Messages_types.person)

let rec encode_person (v:Messages_types.person) encoder = 
  Pbrt.Encoder.key (1, Pbrt.Bytes) encoder; 
  Pbrt.Encoder.string v.Messages_types.name encoder;
  Pbrt.Encoder.key (2, Pbrt.Varint) encoder; 
  Pbrt.Encoder.int32_as_varint v.Messages_types.id encoder;
  begin match v.Messages_types.email with
  | Some x -> 
    Pbrt.Encoder.key (3, Pbrt.Bytes) encoder; 
    Pbrt.Encoder.string x encoder;
  | None -> ();
  end;
  List.iter (fun x -> 
    Pbrt.Encoder.key (4, Pbrt.Bytes) encoder; 
    Pbrt.Encoder.string x encoder;
  ) v.Messages_types.phone;
  ()
