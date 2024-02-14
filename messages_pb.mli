(** messages.proto Binary Encoding *)


(** {2 Protobuf Encoding} *)

val encode_person : Messages_types.person -> Pbrt.Encoder.t -> unit
(** [encode_person v encoder] encodes [v] with the given [encoder] *)


(** {2 Protobuf Decoding} *)

val decode_person : Pbrt.Decoder.t -> Messages_types.person
(** [decode_person decoder] decodes a [person] value from [decoder] *)
