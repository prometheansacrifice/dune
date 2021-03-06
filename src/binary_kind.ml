open! Stdune

type t =
  | Exe
  | Object
  | Shared_object

let dparse =
  let open Dsexp.Of_sexp in
  enum
    [ "exe"           , Exe
    ; "object"        , Object
    ; "shared_object" , Shared_object
    ]

let to_string = function
  | Exe -> "exe"
  | Object -> "object"
  | Shared_object -> "shared_object"

let pp fmt t =
  Format.pp_print_string fmt (to_string t)

let dgen t =
  Dsexp.unsafe_atom_of_string (to_string t)

let all = [Exe; Object; Shared_object]
