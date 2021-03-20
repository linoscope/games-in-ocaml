open Tic_tac_toe_lib
open Base
open Stdio

let run () =
  printf "Starting game...\n";
  let rec loop game =
    printf "%s\n%!" (Game.board game |> Board.to_string);
    printf "Choose cell (1~9): \n%!";
    match In_channel.input_line In_channel.stdin with
      None -> failwith "No input provided"
    | Some input_str ->
      match input_str |> Int.of_string |> Position.of_int with
        None -> failwith "invalid input"
      | Some pos ->
        let open Game in
        match move game pos with
        | Finished (Winner p) ->
          printf "Player %s won!\n" (Player.to_string p)
        | In_progress new_game -> loop new_game
        | Tied -> printf "Tied!!\n"
        | Already_placed -> failwith "Already placed"
  in
  loop Game.initial

let () = run ()
