type extraction = { r : int; g : int; b : int }

let equal (a : extraction) (b : extraction) =
  a.r == b.r && a.g == b.g && a.b = b.b

let pp ppf { r; g; b } = Fmt.pf ppf "%i red, %i green, %i blue" r g b

(*  *)
let isPossible r g b extr = r == extr.r && g == extr.g && b == extr.b
let redRegex = Str.regexp {|.*\b\([0-9]+\)\b red.*|}
let greenRegex = Str.regexp {|.*\b\([0-9]+\)\b green.*|}
let blueRegex = Str.regexp {|.*\b\([0-9]+\)\b blue.*|}

let numFromString r s =
  if Str.string_match r s 0 then int_of_string (Str.matched_group 1 s) else 0

let getRed = numFromString redRegex
let getBlue = numFromString blueRegex
let getGreen = numFromString greenRegex
let makeExtraction s = { r = getRed s; g = getGreen s; b = getBlue s }
let isPossibleGame r g b extr = r >= extr.r && g >= extr.g && b >= extr.b
let gameRegex = Str.regexp {|Game \b\([0-9]+\)\b:|}
let getGameID = numFromString gameRegex

let getExtractions gameString =
  let gameAndExtr = String.split_on_char ':' gameString in
  let extractions = String.split_on_char ';' (List.nth gameAndExtr 1) in
  List.map makeExtraction extractions
