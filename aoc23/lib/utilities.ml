let read_lines (file_name : string) : string list =
  In_channel.with_open_text file_name In_channel.input_lines

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

let rec canDivideby divisors num =
  match divisors with
  | [] -> false
  | d :: divs -> if num mod d == 0 then true else canDivideby divs num

let findSomePrimes high =
  (* few precalculated*)
  let known =
    [
      2;
      3;
      5;
      7;
      11;
      13;
      17;
      19;
      23;
      29;
      31;
      37;
      41;
      43;
      47;
      53;
      59;
      61;
      67;
      71;
      73;
      79;
      83;
      89;
      97;
      101;
      103;
      107;
      109;
      113;
      127;
      131;
      137;
      139;
      149;
      151;
      157;
      163;
      167;
      173;
      179;
      181;
      191;
      193;
      197;
      199;
      211;
      223;
      227;
      229;
      233;
      239;
      241;
      251;
      257;
      263;
      269;
      271;
    ]
  in
  if high < 271 then
    let lessThanHigh x = x < high in
    List.filter lessThanHigh known
  else
    let rec aux ret current =
      if current > high then ret
      else if canDivideby ret current then aux ret (current + 2)
      else current :: aux ret (current + 2)
    in
    aux known 277 |> List.sort Int.compare

let divideByMultiple divisor num =
  let rec aux d = if num mod d == 0 then 1 + aux (d * divisor) else 0 in
  aux divisor

module IntMap = struct
  type t = int

  let compare x0 x1 = Int.compare x0 x1
end

module DivMap = Map.Make (IntMap)

let calculateDivisors candidates x =
  let rec aux divs map =
    match divs with
    | [] -> map
    | d :: div -> aux div (map |> DivMap.add d (divideByMultiple d x))
  in
  aux candidates DivMap.empty

let rec pow i p = match p with 0 -> 1 | 1 -> i | pp -> i * pow i (pp - 1)

let makemcm divisorList =
  (*assuming that all the divisor list have the same list of divisor*)
  let driver = List.hd divisorList and others = List.tl divisorList in
  let rec getMaxPow dvl i power =
    match dvl with
    | [] -> power
    | d :: divs -> getMaxPow divs i (max power @@ DivMap.find i d)
  in
  let rec forgemcm = function
    | [] -> 1
    | pa :: ls ->
        (* Printf.printf "%i^%i\n" (fst pa) (snd pa); *)
        pow (fst pa) (snd pa) * forgemcm ls
  in
  DivMap.mapi (getMaxPow others) driver |> DivMap.to_list |> forgemcm

let accumulate op init =
  let rec aux = function [] -> init | i :: l -> op i (aux l) in
  aux

let accumulateSum = accumulate ( + ) 0
