let filename = "day07"
let lines = Utilities.read_lines filename
let () = Cards.game lines |> Printf.printf "Task1: %i\n"
(* 247671088 is wrong *)
