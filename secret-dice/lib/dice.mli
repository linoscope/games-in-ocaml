type t = One | Two | Three | Four | Five | Six [@@deriving equal]

val to_int: t -> int
val to_string: t -> string
val of_int: int -> t option
val of_string: string -> t option
