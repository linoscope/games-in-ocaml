type t = One | Two | Three | Four | Five | Six [@@deriving compare, equal, show]

let to_int = function
    One -> 1
  | Two -> 2
  | Three -> 3
  | Four -> 4
  | Five -> 5
  | Six -> 6

let to_string t = t |> to_int |> Int.to_string

let of_int_exn = function
  | 1 -> One
  | 2 -> Two
  | 3 -> Three
  | 4 -> Four
  | 5 -> Five
  | 6 -> Six
  | _ -> assert false

let of_string_exn s =
  int_of_string s |> of_int_exn
