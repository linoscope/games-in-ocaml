type score = Score of int

type guess = Guess of Dice.t

type t

type guess_result =
    InCorrect of t
  | Correct of score
  | Error of string

val new_game: unit -> t

val make_guess: t -> guess -> guess_result

val unattempted: t -> guess list
