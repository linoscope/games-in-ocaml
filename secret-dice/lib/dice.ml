open Base

type t = One | Two | Three | Four | Five | Six [@@deriving equal]

let to_int = function
    One -> 1
  | Two -> 2
  | Three -> 3
  | Four -> 4
  | Five -> 5
  | Six -> 6

let to_string t = t |> to_int |> Printf.sprintf "[%d]"

let of_int = function
  | 1 -> Some One
  | 2 -> Some Two
  | 3 -> Some Three
  | 4 -> Some Four
  | 5 -> Some Five
  | 6 -> Some Six
  | _ -> None

let of_string s =
  let open Option.Monad_infix in
  Caml.int_of_string_opt s >>= of_int
