let () =
  let filename = "day05" in

  let lines = Utilities.read_lines filename in
  print_string "task 1: ";
  let myMap = Gardener.reader lines in
  Gardener.getLocations myMap |> List.sort ( - ) |> List.hd |> print_int;
  print_endline "";
  print_string "task 2: ";
  let converter = Gardener.createconverter myMap in
  Gardener.getLocationsBetter converter myMap.seeds
  |> List.sort ( - ) |> List.hd |> print_int;
  print_endline ""
