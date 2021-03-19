type secret

type score = Score of int

type guess = Guess of Dice.t

type t = { secret: secret; valid_moves: guess list }

type guess_result =
    InProgress of t
  | Finished of score
  | Error of string

val new_game: unit -> t

val make_guess: t -> guess -> guess_result
