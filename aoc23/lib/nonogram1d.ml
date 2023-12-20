(*I am not ready for sequences
  let decode s =
   let rec aux prev n l () =
     match l () with
     | Seq.Nil -> Seq.Cons (n, ())
     | Seq.Cons ('#', seq) when '#' == prev -> aux '#' (n + 1) seq ()
     | Seq.Cons (x, seq) when x != prev -> Seq.Cons (n + 1, aux x 0 seq)
     | Seq.Cons (x, seq) -> aux x 0 seq ()
   in
   aux '#' 0 (String.to_seq s) |> List.of_seq *)

(* I just  learned when  *)
let decode s =
  let rec aux prev n l =
    match l with
    | [] when n > 0 -> [ n ]
    | [] -> []
    | '#' :: seq -> aux '#' (n + 1) seq
    | x :: seq when '#' == prev -> n :: aux x 0 seq
    | x :: seq -> aux x 0 seq
  in
  aux '.' 0 (Utilities.chars_of_string s)

  let possibilities n 