type secret

type score = Score of int

type guess = Guess of Dice.t

type t =
    Unresolved of { valid_moves: guess list; secret: secret }
  | Resolved of score

val new_game: unit -> t

val make_guess: t -> guess -> t
