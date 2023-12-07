let isvalidgame = BagOcubes.isPossibleGame 12 13 14

let () =
  let filename = "day2" in
  let mysum = ref 0 in
  let chan = open_in filename in
  try
    while true do
      let line = input_line chan in
      print_string "Game ";
      let gameId = BagOcubes.getGameID line in
      print_int gameId;
      print_string ": ";
      let extractions = BagOcubes.getExtractions line in
      List.iter (BagOcubes.pp Format.std_formatter) extractions;
      mysum := !mysum + if isvalidgame line then gameId else 0;
      print_endline ""
    done
  with End_of_file ->
    close_in chan;
    print_int !mysum;
    print_endline ""
