type secret

type score = Score of int

type guess = Guess of Dice.t

type t =
    Unresolved of { valid_moves: guess list; secret: secret }
  | Resolved of score

type guess_result =
    Success of t
  | Error of string

val new_game: unit -> t

val make_guess: t -> guess -> guess_result
