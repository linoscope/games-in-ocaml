open Base
open Stdio
open Secret_dice_lib

let valid_moves_str valid_moves =
  valid_moves
  |> List.fold ~init:"" ~f:(fun acc (Game.Guess d) -> acc ^ (Printf.sprintf "%d, " (Dice.to_int d)))

let run () =
  printf "Starting game...\n";
  let rec loop game =
    printf "Guess a number from the following: [%s]\n%!" (valid_moves_str game.Game.valid_moves);
    match In_channel.input_line In_channel.stdin with
      None -> failwith "No input provided"
    | Some input_str ->
      let guess = Game.Guess (Dice.of_string_exn input_str) in
      match Game.make_guess game guess with
      | InProgress game -> loop game
      | Finished (Score score) -> printf "You won! Score: %d\n%!" score
      | Error msg -> failwith msg

  in
  let game = Game.new_game () in
  loop game

let () = run ()
