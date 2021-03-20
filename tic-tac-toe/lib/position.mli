type t [@@deriving equal]

val of_int: int -> t option

val all: t list
val rows: t list list
val cols: t list list
val diags: t list list
