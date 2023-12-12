let firstInt = Str.regexp "[0-9]"
let getFirstnum r s = Char.code s.[Str.search_forward r s 0] - 48

let getLastnum r s =
  Char.code s.[Str.search_backward r s (String.length s)] - 48

let getNum s = (10 * getFirstnum firstInt s) + getLastnum firstInt s

let genericDigit =
  Str.regexp {|[0-9]\|one\|two\|three\|four\|five\|six\|seven\|eight\|nine|}

let myStrToInt x =
  match x with
  | "one" -> 1
  | "two" -> 2
  | "three" -> 3
  | "four" -> 4
  | "five" -> 5
  | "six" -> 6
  | "seven" -> 7
  | "eight" -> 8
  | "nine" -> 9
  | _ -> Char.code x.[0] - 48

let getFirstnumG r s =
  let id = Str.search_forward r s 0 in
  let x = if id > -1 then Str.matched_string s else String.make 1 s.[id] in
  myStrToInt x

let getLastnumG r s =
  let id = Str.search_backward r s (String.length s) in
  let x = if id > -1 then Str.matched_string s else String.make 1 s.[id] in
  myStrToInt x

let getNumGeneric s =
  (10 * getFirstnumG genericDigit s) + getLastnumG genericDigit s
