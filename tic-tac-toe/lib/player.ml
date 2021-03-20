type t = O | X [@@deriving equal]
let rev = function
    O -> X
  | X -> O
let to_string = function
  | O -> "O"
  | X -> "X"
