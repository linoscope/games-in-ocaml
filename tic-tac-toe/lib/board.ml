open Base

type cell_with_pos = {
  pos: Position.t;
  cell: Cell.t
}

type t = cell_with_pos list

let can_place t pos =
  List.exists t ~f:(fun {pos = p; cell} -> Position.equal p pos && (Cell.equal cell Cell.Empty))

let place t player pos =
  if not (can_place t pos) then
    None
  else
    let new_cell = {pos = pos; cell = Played player} in
    let substitute_new_cell old_cell =
      if Position.equal old_cell.pos new_cell.pos then
        new_cell
      else
        old_cell
    in
    Some (t |> List.map ~f:substitute_new_cell)

let all_cells t = t |> List.map ~f:(fun {cell; _} -> cell)

let cells_in_line t (line: Position.t list) =
  t
  |> List.filter ~f:(fun {pos; _} -> List.mem line pos ~equal:Position.equal)
  |> List.map ~f:(fun {cell; _} -> cell)

let to_string t =
  let row_to_string row =
    cells_in_line t row
    |> List.map ~f:Cell.to_string
    |> String.concat ~sep:" | "
  in
  Position.rows
  |> List.map ~f:row_to_string
  |> String.concat ~sep:"\n_________\n"

let empty =
  Position.all |> List.map ~f:(fun pos -> {pos; cell = Empty})
