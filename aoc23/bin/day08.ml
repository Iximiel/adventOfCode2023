let filename = "day08"
let lines = Utilities.read_lines filename
let map = Themap.createMap (List.tl lines |> List.tl)
let itinerary = List.hd lines
let () = Themap.traverse map itinerary |> Printf.printf "Task1: %i\n"

(* let () = Themap.traverseInParallel map itinerary |> Printf.printf "Task2: %i\n" *)
let keys =
  Themap.StringsMap.filter Themap.isStart_ map
  |> Themap.StringsMap.to_list |> List.map fst

(* let printlist l =
   let rec aux = function [] -> " ]" | s :: lsn -> s ^ "; " ^ aux lsn in
   "[" ^ aux l *)

let firstLoop =
  let traverseKey k =
    let continueIf x = Themap.isEnd x |> not in
    Themap.traverseFrom k continueIf map itinerary
  in
  let rec aux = function
    | [] -> []
    | key :: lsn -> (key, traverseKey key) :: aux lsn
  in
  aux keys

let biggest = List.split firstLoop |> snd |> List.sort ( - ) |> List.hd

(* the squareroot is here becasue we want the only the prime divisors *)
let divisors = Utilities.findSomePrimes biggest

(* Utilities.findSomePrimes (float_of_int biggest |> sqrt |> int_of_float) *)

let primeDivisors =
  let rec t = function
    | [] -> []
    | tr :: ls -> Utilities.calculateDivisors divisors (snd tr) :: t ls
  in
  t firstLoop
(*
let () =
  Utilities.DivMap.iter (Printf.printf "%i^%i\n") (List.nth primeDivisors 0) *)

let () = Utilities.makemcm primeDivisors |> Printf.printf "Task2: %i\n"
(* let primes = Utilities.findSomePrimes biggest *)

(* let () =
   let checkPrime i = List.find_opt (( == ) i) primes != None in
   let rec t = function
     | [] -> ()
     | tr :: ls ->
         Printf.printf "Task2: %s, %i is %s prime\n" (fst tr) (snd tr)
           (if checkPrime (snd tr) then "" else "not ");
         t ls
   in
   t firstLoop *)
