open Base
open Stdio
open Secret_dice_lib

let valid_moves_str valid_moves =
  valid_moves
  |> List.fold ~init:"" ~f:(fun acc (Game.Guess d) -> acc ^ (Printf.sprintf "%d, " (Dice.to_int d)))

let run () =
  printf "Starting game...\n";
  let rec loop game =
    match game with
    | Game.Resolved (Game.Score score) -> printf "You won! score:%d\n%!" score
    | Game.Unresolved { valid_moves; _} ->
      printf "Guess a number from the following: [%s]\n%!" (valid_moves_str valid_moves);
      match In_channel.input_line In_channel.stdin with
        None -> failwith "No input provided"
      | Some input_str ->
        let guess = Game.Guess (Dice.of_string_exn input_str) in
        match Game.make_guess game guess with
        | Error msg -> failwith msg
        | Success game -> loop game
  in
  let game = Game.new_game () in
  loop game

let () = run ()
