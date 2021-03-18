open Base

type secret = Dice.t

type guess = Guess of Dice.t

type score = Score of int

type t =
    Unresolved of { valid_moves: guess list; secret: secret }
  | Resolved of score

let new_game () =
  let all_dices =  Dice.[One; Two; Three; Four; Five; Six] in
  let valid_moves = List.map all_dices ~f:(fun d -> Guess d) in
  Unresolved {
    secret = List.random_element_exn all_dices;
    valid_moves;
  }

let make_guess t guess =
  match t with
  | Resolved _ -> raise (Invalid_argument "Guessing against resolved game")
  | Unresolved {secret; valid_moves} ->
    let Guess guessed_dice = guess in
    if Dice.equal guessed_dice secret then
      let score = List.length valid_moves in
      Resolved (Score score)
    else
      let valid_moves = valid_moves |> List.filter ~f:(fun (Guess d) -> not (Dice.equal guessed_dice d)) in
      Unresolved {secret; valid_moves}
