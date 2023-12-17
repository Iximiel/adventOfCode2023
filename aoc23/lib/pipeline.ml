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

let string_of_mydirection = function
  | Nord -> "Nord"
  | South -> "South"
  | East -> "East"
  | West -> "West"

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

module Walker = struct
  type walker = { d : myDirection; x : int; y : int }

  let equal (a : walker) (b : walker) = a.d == b.d && a.x == b.x && a.y = b.y
  let equalPlace (a : walker) (b : walker) = a.x == b.x && a.y = b.y
  let pp ppf { d; x; y } = Fmt.pf ppf "%s (%i,%i)" (string_of_mydirection d) x y

  let string_of_walker { d; x; y } =
    string_of_mydirection d ^ " (" ^ string_of_int x ^ ", " ^ string_of_int y
    ^ ")"

  let create d xy =
    let x, y = xy in
    { d; x; y }

  let weight maxwidth w = w.x + (w.y * maxwidth)
  let gety y w = y == w.y
  let getx x w = x == w.x

  let advance walker pipe =
    match pipebend walker.d pipe with
    | None -> None
    | Some newd -> (
        let x, y = (walker.x, walker.y) in
        match newd with
        (*the v axis is inverted*)
        | Nord -> Some { d = newd; x; y = y - 1 }
        | South -> Some { d = newd; x; y = y + 1 }
        | East -> Some { d = newd; x = x + 1; y }
        | West -> Some { d = newd; x = x - 1; y })
end

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
  and width = String.length (List.nth listOLines 0) - 1 in
  let adv d =
    match d with
    (*the v axis is inverted*)
    | Nord -> (x, y - 1)
    | South -> (x, y + 1)
    | East -> (x + 1, y)
    | West -> (x - 1, y)
  in
  let rec aux =
    let check d l =
      let myxy = adv d in
      if pipeCompatibility d (pipe myxy) then Walker.create d myxy :: aux l
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

let walkPipes pipemap walkers =
  let open Walker in
  let adv w =
    match Walker.advance w @@ getPipe pipemap (w.x, w.y) with
    | None -> raise Not_found
    | Some w -> w
  in
  let rec aux w ret =
    let toret = w :: ret in
    if getPipe pipemap (w.x, w.y) == 'S' then toret else aux (adv w) toret
  in
  (*this returns the perimeter :)*)
  aux (List.nth walkers 0) []

let walkForTask1 pipemap =
  (findInitialPoints pipemap |> walkPipes pipemap |> List.length) / 2

let rec makeAlist elementMaker maxL l =
  if l < maxL then elementMaker l :: makeAlist elementMaker maxL (l + 1) else []

let mapOfPipes map path =
  let height = List.length map and width = String.length (List.nth map 0) in
  let compare w1 w2 =
    let sortWeight = Walker.weight width in
    sortWeight w1 - sortWeight w2
  in
  let sortedPath = List.sort compare path in
  let rec aux h =
    if h < height then
      let hpart = List.filter (Walker.gety h) sortedPath in
      let rec makeRow w =
        if w < width then
          (if List.exists (Walker.getx w) hpart then 'x' else '.')
          :: makeRow (w + 1)
        else []
      in
      (makeRow 0 |> Utilities.string_of_chars) :: aux (h + 1)
    else []
  in
  aux 0
(* let makeRow =
   let maker w =(if List.exists (Walker.getx w) hpart then 'x' else '.') in
   makeAlist maker width *)
