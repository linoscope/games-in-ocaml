type t

type winner = Winner of Player.t

type move_result =
    InProgress of t
  | Finished of winner
  | Tied
  | AlreadyPlaced

val initial: t

val move: t -> Position.t -> move_result

val board: t -> Board.t

val turn: t -> Player.t
