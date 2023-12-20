let filename = "day11"
let map = Utilities.read_lines filename |> List.map Utilities.chars_of_string
let () = Galaxies.task1 map |> Printf.printf "Task1 : %i\n"
let () = Galaxies.task2 (1000000 - 1) map |> Printf.printf "Task2 : %i\n"
