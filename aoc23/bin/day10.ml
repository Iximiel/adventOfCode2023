let filename = "day10"
let map = Utilities.read_lines filename
let () = Pipeline.walkForTask1 map |> Printf.printf "Task2: %i\n"
