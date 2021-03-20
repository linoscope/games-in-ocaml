type t = Played of Player.t | Empty [@@deriving equal]

let to_string = function
  | Empty -> "-"
  | Played p -> Player.to_string p
