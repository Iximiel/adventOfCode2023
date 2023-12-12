let read_lines (file_name : string) : string list =
  In_channel.with_open_text file_name In_channel.input_lines

let rec doSum = function [] -> 0 | i :: l -> i + doSum l

let () =
  let filename = "day4" in

  let lines = read_lines filename in
  print_string "task 1: ";

  doSum (List.map Scratcher.getObjAndGame lines |> Scratcher.calculateWinning)
  |> print_int;
  print_endline "";
  print_string "task 2: ";
  doSum
    (List.map Scratcher.getObjAndGame lines
    |> Scratcher.calculateMatches |> Scratcher.elaborateWinning)
  |> print_int;
  print_endline ""
