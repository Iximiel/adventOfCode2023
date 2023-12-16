let card = function
  | 'A' -> 14 + int_of_char '0'
  | 'K' -> 13 + int_of_char '0'
  | 'Q' -> 12 + int_of_char '0'
  | 'J' -> 11 + int_of_char '0'
  | 'T' -> 10 + int_of_char '0'
  | i -> int_of_char i

let cardjk = function
  | 'A' -> 14 + int_of_char '0'
  | 'K' -> 13 + int_of_char '0'
  | 'Q' -> 12 + int_of_char '0'
  | 'J' -> 0
  | 'T' -> 10 + int_of_char '0'
  | i -> int_of_char i

let cmp fn a b = fn a - fn b
let cmpCards = cmp card
let cmpCardsjk = cmp cardjk

(*stolen from https://stackoverflow.com/a/29957532 *)
let string_of_chars chars =
  let buf = Buffer.create 16 in
  List.iter (Buffer.add_char buf) chars;
  Buffer.contents buf

let chars_of_string s =
  let rec aux st i =
    if i == String.length s - 1 then [ st.[i] ] else st.[i] :: aux st (i + 1)
  in
  aux s 0
(* let's be explicit: wha have only 5 cards*)
(* [ s.[0]; s.[1]; s.[2]; s.[3]; s.[4] ] *)

let reorderHandbase crd h =
  let cmpCardsReorder a b = crd b - crd a in
  chars_of_string h |> List.sort cmpCardsReorder |> string_of_chars

let reorderHand = reorderHandbase card
let reorderHandjk = reorderHandbase cardjk

let numEquals s =
  let rec aux st c ne =
    match st with
    | [] -> if ne > 1 then [ ne ] else []
    | nc :: str ->
        if nc == c then aux str nc (ne + 1)
        else if ne > 1 then ne :: aux str nc 1
        else aux str nc 1
  in
  aux (chars_of_string s) s.[0] 0

let five = 25
let four = 16
let full = 10
let three = 6
let double = 4
let couple = 2
let high = 0

let handStrength h =
  let hand = reorderHand h in
  let ne = numEquals hand in
  (*look up table -sorta-*)
  match ne with
  | [ 5 ] -> five
  | [ 4 ] -> four
  | [ 3; 2 ] -> full
  (* Reoerdering did not work, so I explicited the case *)
  | [ 2; 3 ] -> full
  | [ 3 ] -> three
  | [ 2; 2 ] -> double
  | [ 2 ] -> couple
  | [] -> high
  | _ -> 0

let countJK h = List.filter (Char.equal 'J') @@ chars_of_string h |> List.length

let handStrengthjk h =
  let jk = countJK h in
  if jk == 0 then handStrength h
  else
    let hand = reorderHand h in
    let ne = numEquals hand in
    (*look up table -sorta-*)
    match ne with
    | [ 5 ] -> five (*JJJJJ*)
    | [ 4 ] -> five (*JJJJX*)
    | [ 3; 2 ] -> five (*JJJXX or XXXJJ*)
    | [ 2; 3 ] -> five
    | [ 3 ] -> four (*JXXXY, JJXXX is above*)
    | [ 2; 2 ] -> if jk == 1 then full else four
    | [ 2 ] -> three (*2;2 and 2;3 are already done *)
    | [] -> couple (*J1234*)
    | _ -> 0

let orderCompareBase cmp h1 h2 =
  let l1 = chars_of_string h1 and l2 = chars_of_string h2 in
  let rec aux a b =
    match (a, b) with
    | x :: l1, y :: l2 ->
        let r = cmp x y in
        if r == 0 then aux l1 l2 else r
    | _ -> 0
  in
  (* ac C++ programmer I'm addung an UB here *proud of myself* : i do NOT expect any case to be completely equal *)
  (* if aux l1 l2 > 0 then 1 else -1 *)
  aux l1 l2

let orderCompare = orderCompareBase cmpCards
let orderComparejk = orderCompareBase cmpCardsjk

let powerCompareBase oc hs h1 h2 =
  let pow1 = hs h1 and pow2 = hs h2 in
  if pow1 == pow2 then oc h1 h2 else pow1 - pow2

let powerCompare = powerCompareBase orderCompare handStrength
let powerComparejk = powerCompareBase orderComparejk handStrengthjk
let cbCompare cb1 cb2 = powerCompare (fst cb1) (fst cb2)
let cbComparejk cb1 cb2 = powerComparejk (fst cb1) (fst cb2)

exception CardError of string

let basegame cbCMP ls =
  let rec aux s =
    match s with
    | l :: ls ->
        let t = String.split_on_char ' ' l in
        (* if String.length (List.nth t 0) != 5 then *)
        (* raise (CardError ("Error in reading hand: " ^ List.nth t 0)); *)
        (* if List.length t != 2 then
           raise (CardError ("Error in reading line: " ^ l)); *)
        (List.nth t 0, int_of_string @@ List.nth t 1) :: aux ls
    | [] -> []
  in
  let rec multiplypower cbs (i : int64) (pow : int64) =
    match cbs with
    | cb :: cbsl ->
        (* Printf.printf "%s %i %i\n" (fst cb) i (snd cb); *)
        multiplypower cbsl (Int64.succ i)
          (Int64.add pow (Int64.mul i @@ Int64.of_int (snd cb)))
    | [] -> pow
  in
  let cards_bets = aux ls |> List.sort cbCMP in
  multiplypower cards_bets 1L 0L

let game = basegame cbCompare
let gamejk = basegame cbComparejk
