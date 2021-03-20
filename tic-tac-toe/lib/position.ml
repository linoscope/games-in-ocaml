open Base

type horiz = Left | HMid | Right [@@deriving equal]
type vert  = Top  | VMid | Bottom [@@deriving equal]
type t = vert * horiz [@@deriving equal]

let of_int =
  function
    1 -> Some (Top, Left)
  | 2 -> Some (Top, HMid)
  | 3 -> Some (Top, Right)
  | 4 -> Some (VMid, Left)
  | 5 -> Some (VMid, HMid)
  | 6 -> Some (VMid, Right)
  | 7 -> Some (Bottom, Left)
  | 8 -> Some (Bottom, HMid)
  | 9 -> Some (Bottom, Right)
  | _ -> None

let all =
  let open List.Monad_infix in
  [Top; VMid; Bottom] >>= fun v ->
  [Left; HMid; Right] >>| fun h ->
  (v, h)

let rows =
  let open List.Monad_infix in
  [Top; VMid; Bottom] >>| fun v ->
  [Left; HMid; Right] >>| fun h ->
  (v, h)

let cols =
  let open List.Monad_infix in
  [Left; HMid; Right] >>| fun h ->
  [Top; VMid; Bottom] >>| fun v ->
  (v, h)

let diags =
  let left_to_right = List.zip_exn [Top; VMid; Bottom] [Left; HMid; Right] in
  let right_to_left = List.zip_exn [Top; VMid; Bottom] [Right; HMid; Left] in
  [left_to_right; right_to_left]
