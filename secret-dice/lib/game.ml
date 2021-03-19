open Base

type guess = Guess of Dice.t

type score = Score of int

type t = { secret: Dice.t; valid_moves: guess list }

type guess_result =
    InProgress of t
  | Finished of score
  | Error of string

let new_game () =
  let all_dices =  Dice.[One; Two; Three; Four; Five; Six] in
  let valid_moves = List.map all_dices ~f:(fun d -> Guess d) in
  let secret = List.random_element_exn all_dices in
  { secret; valid_moves; }

let is_valid guess valid_moves =
  List.mem valid_moves guess ~equal:(fun (Guess d1) (Guess d2) -> Dice.equal d1 d2)

let valid_moves t = t.valid_moves

let make_guess {secret; valid_moves} guess =
  if not (is_valid guess valid_moves) then
    Error "Invalid move"
  else
    let Guess guessed_dice = guess in
    if Dice.equal guessed_dice secret then
      let score = List.length valid_moves in
      Finished (Score score)
    else
      let valid_moves =
        valid_moves
        |> List.filter ~f:(fun (Guess d) -> not (Dice.equal guessed_dice d))
      in
      InProgress {secret; valid_moves}
