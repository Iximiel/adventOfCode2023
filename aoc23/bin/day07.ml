let filename = "day07"
let lines = Utilities.read_lines filename
let () = Cards.game lines |> Printf.printf "Task1: %Ld\n"
let () = Cards.gamejk lines |> Printf.printf "Task2: %Ld\n"

(* 247671088 is wrong *)
