open Base

type t = {
  turn: Player.t;
  board: Board.t
}

type winner = Winner of Player.t

type move_result =
    InProgress of t
  | Finished of winner
  | Tied
  | AlreadyPlaced

let initial = {
  turn = Player.O;
  board = Board.empty
}

let board t = t.board

let turn t = t.turn

let filled_by_player board (line: Position.t list): Player.t option =
  let cells = Board.cells_in_line board line in
  let is_all_o =
    cells |> List.for_all ~f:(fun cell -> Cell.equal cell (Played (Player.O)))
  in
  let is_all_x =
    cells |> List.for_all ~f:(fun cell -> Cell.equal cell (Played (Player.X)))
  in
  if is_all_o then
    Some Player.O
  else if is_all_x then
    Some Player.X
  else
    None

let lines_to_check = Position.rows @ Position.cols @ Position.diags

let move {turn; board} pos =
  match Board.place board turn pos with
    None -> AlreadyPlaced
  | Some board ->
    let all_filled =
      Board.all_cells board
      |> List.for_all ~f:(fun cell -> not (Cell.equal cell Cell.Empty))
    in
    let line_filled_by =
      lines_to_check
      |> List.map ~f:(fun line -> filled_by_player board line)
      |> List.filter_map ~f:Fn.id
      |> List.hd
    in
    match (all_filled, line_filled_by) with
    | true, _ -> Tied
    | false, None -> InProgress {board; turn = Player.rev turn}
    | false, Some p -> Finished (Winner p)
