let numRegex = Str.regexp {|\b[0-9]+\b|}
let dotOrNUm = Str.regexp {|[\.0-9]|}

let checkL line pos len =
  if String.equal line "" then false
  else
    let maxlen = min (len + 2) (String.length line - max 0 (pos - 1)) in
    let substr = String.sub line (max 0 (pos - 1)) maxlen in
    String.length (Str.global_replace dotOrNUm "" substr) > 0

let checkOnline s lb la =
  let checkLB pos t d =
    checkL lb
      (pos + String.length t)
      (String.length d - if pos == 0 then 1 else 0)
  in
  let checkLA pos t d =
    checkL la
      (pos + String.length t)
      (String.length d - if pos == 0 then 1 else 0)
  in
  let checkLAB pos t d = checkLA pos t d || checkLB pos t d in
  let rec aux reres pos =
    match reres with
    | Str.Text t :: (Delim d :: l as ld) ->
        if not @@ String.ends_with ~suffix:"." t then
          int_of_string d :: aux l (pos + String.length t + String.length d)
        else if checkLAB pos t d then
          int_of_string d :: aux l (pos + String.length t + String.length d)
        else aux ld (pos + String.length t)
    | Str.Delim d :: (Text t :: _ as l) ->
        if not @@ String.starts_with ~prefix:"." t then
          int_of_string d :: aux l (pos + String.length d)
        else if checkLAB pos "" d then
          int_of_string d :: aux l (pos + String.length d)
        else aux l (pos + String.length d) (*THIS LINE BLOCKED EVERITHING*)
    | Delim d :: [] -> if checkLAB pos "" d then [ int_of_string d ] else []
    | Text _ :: [] -> []
    | [] -> []
    (* impossible matches *)
    | Delim _ :: Delim _ :: _ -> []
    | Text _ :: Text _ :: _ -> []
  in
  aux (Str.full_split numRegex s) 0

let rec checkWholeSchema schema =
  match schema with
  | lb :: (l :: la :: _ as nextLine) ->
      List.append (checkOnline l lb la) (checkWholeSchema nextLine)
  | [ lb; l ] -> checkOnline l lb ""
  | [ l ] -> checkOnline l "" ""
  | [] -> []
