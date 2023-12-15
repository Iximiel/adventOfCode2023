(* input
   Time:        41     77     70     96
   Distance:   249   1362   1127   1011
*)
let time = [ 41; 77; 70; 96 ]
let distance = [ 249; 1362; 1127; 1011 ]
let time2 = 41777096
let distance2 = 249136211271011
let rec doMul = function [] -> 1 | i :: l -> i * doMul l

let () =
  List.map2 Raceboat.racePossibilities time distance
  |> doMul
  |> Printf.printf "Task 1 : %i\n";
  Raceboat.racePossibilities time2 distance2 |> Printf.printf "Task 2 : %i\n"
