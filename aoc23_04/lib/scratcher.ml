let getNumList s =
  let notEmpty str = String.equal String.empty str |> not in
  String.split_on_char ' ' s |> List.filter notEmpty |> List.map int_of_string

type scratchcard = { obj : int list; game : int list }

let equal (a : scratchcard) (b : scratchcard) =
  List.for_all2 ( == ) a.obj b.obj && List.for_all2 ( == ) a.game b.game

let pp ppf { obj; game } =
  let ltos l = String.concat " " (List.map string_of_int l) in
  Fmt.pf ppf "obj= [%s], game =[%s]" (ltos obj) (ltos game)

let getObjAndGame s =
  let res =
    List.nth (String.split_on_char ':' s) 1
    |> String.split_on_char '|' |> List.map getNumList
  in
  { obj = List.nth res 0; game = List.nth res 1 }

let getWinning card =
  let rec aux = function
    | [] -> 0
    | a :: l -> (if List.exists (Int.equal a) card.game then 1 else 0) + aux l
  in
  let num = aux card.obj in
  if num > 0 then Int.shift_left 1 (num - 1) else 0
