let filename = "day08"
let lines = Utilities.read_lines filename
let map = Themap.createMap (List.tl lines |> List.tl)
let itinerary = List.hd lines
let () = Themap.traverse map itinerary |> Printf.printf "Task1: %i\n"
let () = Themap.traverseInParallel map itinerary |> Printf.printf "Task2: %i\n"
