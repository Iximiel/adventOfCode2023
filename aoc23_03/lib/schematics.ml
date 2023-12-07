let numRegex = Str.regexp {|\b\([0-9]+\)\b|}

let checkOnline s lb la =
  let rec aux = function
    | Str.Text t :: (Delim d :: l as ld) ->
        if Str.last_chars t 1 != "." then int_of_string d :: aux l else aux ld
    | Str.Delim d :: (Text t :: _ as l) ->
        if Str.first_chars t 1 != "." then int_of_string d :: aux l else aux l
    | Delim _ :: [] -> []
    | Text _ :: [] -> []
    | [] -> []
    (* impossible matches *)
    | Delim _ :: Delim _ :: _ -> [ int_of_string lb ]
    | Text _ :: Text _ :: _ -> [ int_of_string la ]
  in
  Str.full_split numRegex s |> aux
