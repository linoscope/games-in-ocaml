type t
val empty: t
val place: t -> Player.t -> Position.t -> t option
val to_string: t -> string
val all_cells: t -> Cell.t list
val cells_in_line: t -> Position.t list -> Cell.t list
