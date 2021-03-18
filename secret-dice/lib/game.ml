open Base

type secret = Dice.t

type guess = Guess of Dice.t

type score = Score of int

type t =
    Unresolved of { valid_moves: guess list; secret: secret }
  | Resolved of score

type guess_result =
    Success of t
  | Error of string

let new_game () =
  let all_dices =  Dice.[One; Two; Three; Four; Five; Six] in
  let valid_moves = List.map all_dices ~f:(fun d -> Guess d) in
  Unresolved {
    secret = List.random_element_exn all_dices;
    valid_moves;
  }

let is_valid guess valid_moves =
  List.mem valid_moves guess ~equal:(fun (Guess d1) (Guess d2) -> Dice.equal d1 d2)

let make_guess t guess =
  match t with
  | Resolved _ -> Error "Guessing against resolved game"
  | Unresolved {secret; valid_moves} ->
    if not (is_valid guess valid_moves) then
      Error "Invalid move"
    else
      let Guess guessed_dice = guess in
      if Dice.equal guessed_dice secret then
        let score = List.length valid_moves in
        Success (Resolved (Score score))
      else
        let valid_moves = valid_moves |> List.filter ~f:(fun (Guess d) -> not (Dice.equal guessed_dice d)) in
        Success (Unresolved {secret; valid_moves})
