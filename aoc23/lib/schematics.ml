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
        else aux l (pos + String.length d) (*THIS Next LINE BLOCKED EVERITHING*)
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

let iistringmul s1 s2 = int_of_string s1 * int_of_string s2

let charIsNum c =
  let n = Char.code c in
  48 <= n && n <= 57

let searchAbCog line cogPos =
  if String.equal line "" then []
  else
    let rec gfn n =
      match n with
      | 0 -> 0
      | i -> if charIsNum (String.get line i) then gfn (i - 1) else i
    in
    let start = gfn (max 0 (cogPos - 1)) in
    let maxnum = String.length line in
    let rec gfn n =
      if n == maxnum then maxnum
      else if charIsNum (String.get line n) then gfn (n + 1)
      else n
    in
    let endS = gfn (min maxnum (cogPos + 1)) in
    let len = endS - start in
    let rec aux = function
      | [] -> []
      | Str.Delim x :: l -> int_of_string x :: aux l
      | Text _ :: l -> aux l
    in
    aux @@ Str.full_split (Str.regexp "[0-9]+") (String.sub line start len)

let star = '*'

let rec tranverse_it line searchStart lb la =
  if String.contains_from line searchStart star then
    let id = String.index_from line searchStart star in
    let parts =
      List.concat [ searchAbCog line id; searchAbCog lb id; searchAbCog la id ]
    in
    let getN = List.nth parts in
    if List.length parts == 2 then
      (getN 1 * getN 0) :: tranverse_it line (id + 1) lb la
    else tranverse_it line (id + 1) lb la
  else []

let tranverse line lb la = tranverse_it line 0 lb la

let rec checkWholeT2 schema =
  match schema with
  | lb :: (l :: la :: _ as nextLine) ->
      List.append (tranverse l lb la) (checkWholeT2 nextLine)
  | [ lb; l ] -> tranverse l lb ""
  | [ l ] -> tranverse l "" ""
  | [] -> []
