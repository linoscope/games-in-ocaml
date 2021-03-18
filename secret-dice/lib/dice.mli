type t = One | Two | Three | Four | Five | Six [@@deriving compare, equal, show]

val to_int: t -> int
val to_string: t -> string
val of_int_exn: int -> t
val of_string_exn: string -> t
