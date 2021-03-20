type t = Played of Player.t | Empty [@@deriving equal]

val to_string: t -> string
