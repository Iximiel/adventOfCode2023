(* https://stackoverflow.com/a/77625257 *)

let () =
  (* List.iter print_endline ("" :: schema) *)
  let parts = Schematics.checkWholeSchema Day3input.day3Input in
  (* print_int @@ List.nth parts 0 *)
  let sum = List.fold_left ( + ) 0 parts in
  print_endline ("Task 1: " ^ string_of_int sum);

  let parts = Schematics.checkWholeT2 Day3input.day3Input in
  let sum = List.fold_left ( + ) 0 parts in
  print_endline ("Task 2: " ^ string_of_int sum)
