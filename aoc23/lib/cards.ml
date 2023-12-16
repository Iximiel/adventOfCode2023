let card = function
  | 'A' -> 14 + int_of_char '0'
  | 'K' -> 13 + int_of_char '0'
  | 'Q' -> 12 + int_of_char '0'
  | 'J' -> 11 + int_of_char '0'
  | 'T' -> 10 + int_of_char '0'
  | i -> int_of_char i

let cmpCards a b = card a - card b

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

let reorderHand h =
  let cmpCardsReorder a b = card b - card a in
  chars_of_string h |> List.sort cmpCardsReorder |> string_of_chars

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

let handStrength h =
  let hand = reorderHand h in
  let ne = numEquals hand |> List.sort ( - ) in
  (*look up table -sorta-*)
  match ne with
  | [ 5 ] -> 25
  | [ 4 ] -> 20
  | [ 3; 2 ] -> 17
  | [ 3 ] -> 15
  | [ 2; 2 ] -> 12
  | [ 2 ] -> 10
  | [] -> 0
  | _ -> 0

let orderCompare h1 h2 =
  (*unrolled*)
  if h1.[0] != h2.[0] then cmpCards h1.[0] h2.[0]
  else if h1.[1] != h2.[1] then cmpCards h1.[1] h2.[1]
  else if h1.[2] != h2.[2] then cmpCards h1.[2] h2.[2]
  else if h1.[3] != h2.[3] then cmpCards h1.[3] h2.[3]
  else cmpCards h1.[4] h2.[4]

let orderCompareII h1 h2 =
  let aux i = cmpCards h1.[i] h2.[i] in
  let i = ref 0 in
  while aux !i == 0 do
    i := !i + 1
  done;
  aux !i

let orderCompareIII h1 h2 =
  let l1 = chars_of_string h1 and l2 = chars_of_string h2 in
  let rec aux a b =
    match (a, b) with
    | x :: l1, y :: l2 ->
        let r = cmpCards x y in
        if r == 0 then aux l1 l2 else r
    | _ -> 0
  in
  aux l1 l2

let powerCompare h1 h2 =
  let pow1 = handStrength h1 and pow2 = handStrength h2 in
  if pow1 == pow2 then orderCompareIII h1 h2 else pow1 - pow2

let cbCompare cb1 cb2 = powerCompare (fst cb1) (fst cb2)

exception CardError of string

let game ls =
  let rec aux s =
    match s with
    | l :: ls ->
        let t = String.split_on_char ' ' l in
        (* if String.length (List.nth t 0) != 5 then *)
        (* raise (CardError ("Error in reading hand" ^ List.nth t 0)); *)
        (List.nth t 0, int_of_string @@ List.nth t 1) :: aux ls
    | [] -> []
  in
  let cards_bets = aux ls |> List.sort cbCompare in
  let rec multiplypower cbs i pow =
    match cbs with
    | cb :: cbsl ->
        (* Printf.printf "%s %i %i\n" (fst cb) i (snd cb); *)
        multiplypower cbsl (i + 1) (pow + (i * snd cb))
    | [] -> pow
  in
  multiplypower cards_bets 1 0
