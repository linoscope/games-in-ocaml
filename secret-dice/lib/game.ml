open Base

type guess = Guess of Dice.t

type score = Score of int

type t = { secret: Dice.t; unattempted: guess list }

type guess_result =
    InCorrect of t
  | Correct of score
  | Error of string

let new_game () =
  let all_dices =  Dice.[One; Two; Three; Four; Five; Six] in
  let unattempted = List.map all_dices ~f:(fun d -> Guess d) in
  let secret = List.random_element_exn all_dices in
  { secret; unattempted; }

let is_unattempted guess unattempted =
  List.mem unattempted guess ~equal:(fun (Guess d1) (Guess d2) -> Dice.equal d1 d2)

let unattempted t = t.unattempted

let make_guess {secret; unattempted} guess =
  if not (is_unattempted guess unattempted) then
    Error "Already guessed that before"
  else
    let Guess guessed_dice = guess in
    if Dice.equal guessed_dice secret then
      let score = List.length unattempted in
      Correct (Score score)
    else
      let unattempted =
        unattempted
        |> List.filter ~f:(fun (Guess d) -> not (Dice.equal guessed_dice d))
      in
      InCorrect {secret; unattempted}
