let filename = "day09"
let lines = Utilities.read_lines filename

let linesParsed =
  let rec aux = function [] -> [] | a :: l -> int_of_string a :: aux l in

  let rec getLine = function
    | [] -> []
    | l :: ls -> (String.split_on_char ' ' l |> aux) :: getLine ls
  in
  getLine lines

let sumPrediction =
  let rec aux = function
    | [] -> 0
    | l :: ot -> (Predictor.getAllBySub l |> Predictor.predictBySub) + aux ot
  in
  aux linesParsed

let () = sumPrediction |> Printf.printf "Task1: %i\n"
