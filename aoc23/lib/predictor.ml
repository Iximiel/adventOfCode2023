let rec nextSequence op mylist =
  match mylist with
  | [] -> []
  | _ :: [] -> []
  | a :: (b :: _ as l) -> op b a :: nextSequence op l

let getAllSeqs op mylist =
  let rec aux ls =
    if List.for_all (( == ) 0) ls then [] else ls :: aux (nextSequence op ls)
  in
  aux mylist

let predictor op myDecodedList =
  let fromLowerUp = List.rev myDecodedList in
  let setNext res num = op res num in
  let rec navigate list res =
    match list with
    | [] -> res
    | l :: ls -> navigate ls @@ setNext (l |> List.rev |> List.hd) res
  in
  navigate fromLowerUp 0

let nextBySub = nextSequence ( - )
let getAllBySub = getAllSeqs ( - )
let predictBySub = predictor ( + )
