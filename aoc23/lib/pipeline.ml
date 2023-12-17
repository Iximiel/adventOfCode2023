(* ALL OF THIS WILL BE MADE WITH THE ASSUMPTION THAT THE PUZZLE MAKERS DID NOT MADE A TUBE THAT GOES OUTSIDE THE BORDERS*)

(*
   | is a vertical pipe connecting north and south.
   - is a horizontal pipe connecting east and west.
     L is a 90-degree bend connecting north and east.
     J is a 90-degree bend connecting north and west.
     7 is a 90-degree bend connecting south and west.
     F is a 90-degree bend connecting south and east.
     . is ground; there is no pipe in this tile.
     S is the starting position of the animal; there is a pipe on this tile, but your sketch doesn't show what shape the pipe has.
*)
type myDirection = Nord | South | East | West
type walker = { d : myDirection; x : int; y : int }

let equaldir (a : walker) (b : walker) = a.d == b.d && a.x == b.x && a.y = b.y

let string_of_mydirection = function
  | Nord -> "Nord"
  | South -> "South"
  | East -> "East"
  | West -> "West"

let ppdir ppf { d; x; y } =
  Fmt.pf ppf "%s (%i,%i)" (string_of_mydirection d) x y

let makewalker d xy =
  let x, y = xy in
  { d; x; y }

(* Direction is from me looking at the map, my brain does not process 'rc cars' controls (so that in Factorio I walk...) *)
let pipebend direction tube =
  match tube with
  (* | is a vertical pipe connecting north and south. *)
  | '|' -> Some direction
  (* - is a horizontal pipe connecting east and west. *)
  | '-' -> Some direction
  (* L is a 90-degree bend connecting north and east. *)
  | 'L' -> Some (if direction == South then East else Nord)
  (* J is a 90-degree bend connecting north and west. *)
  | 'J' -> Some (if direction == South then West else Nord)
  (* 7 is a 90-degree bend connecting south and west. *)
  | '7' -> Some (if direction == Nord then West else South)
  (* F is a 90-degree bend connecting south and east. *)
  | 'F' -> Some (if direction == Nord then East else South)
  | _ -> None

let pipeCompatibility direction tube =
  match tube with
  (* | is a vertical pipe connecting north and south. *)
  | '|' -> direction == Nord || direction == South
  (* - is a horizontal pipe connecting east and west. *)
  | '-' -> direction == East || direction == West
  (* L is a 90-degree bend connecting north and east. *)
  | 'L' -> direction == West || direction == South
  (* J is a 90-degree bend connecting north and west. *)
  | 'J' -> direction == East || direction == South
  (* 7 is a 90-degree bend connecting south and west. *)
  | '7' -> direction == Nord || direction == East
  (* F is a 90-degree bend connecting south and east. *)
  | 'F' -> direction == Nord || direction == West
  | _ -> false

(* .  *)
(* S  *)

let advance d xy =
  let x, y = xy in
  match d with
  (*the v axis is inverted*)
  | Nord -> (x, y - 1)
  | South -> (x, y + 1)
  | East -> (x + 1, y)
  | West -> (x - 1, y)

let advanceWalker walker =
  let x, y = (walker.x, walker.y) in
  match walker.d with
  (*the v axis is inverted*)
  | Nord -> { d = walker.d; x; y = y - 1 }
  | South -> { d = walker.d; x; y = y + 1 }
  | East -> { d = walker.d; x = x + 1; y }
  | West -> { d = walker.d; x = x - 1; y }

let findStart listOLines =
  let nth = List.nth listOLines and length = List.length listOLines in
  let rec aux i =
    if i >= length then raise Not_found
    else
      let l = nth i in
      match String.index_opt l 'S' with None -> aux (succ i) | Some j -> (j, i)
  in
  aux 0

let getPipe listOLines xy =
  let x, y = xy in
  String.get (List.nth listOLines y) x

let findInitialPoints listOLines =
  let xy = findStart listOLines and pipe = getPipe listOLines in
  let x, y = xy
  and height = List.length listOLines - 1
  and width = String.length (List.nth listOLines 0) - 1
  and adv d = advance d xy in
  let rec aux =
    let check d l =
      let myxy = adv d in
      if pipeCompatibility d (pipe myxy) then makewalker d myxy :: aux l
      else aux l
    in
    function
    | Nord :: l -> if y != 0 then check Nord l else aux l
    | South :: l -> if y != height then check South l else aux l
    | East :: l -> if x != width then check East l else aux l
    | West :: l -> if x != 0 then check West l else aux l
    | [] -> []
  in
  aux [ Nord; South; East; West ]
