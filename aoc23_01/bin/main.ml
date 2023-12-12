let file = "input"
let sum = ref 0

let () =
  (* Read file and display the first line *)
  let ic = open_in file in
  try
    while true do
      let line = input_line ic in
      (* read line, discard \n *)
      Printf.printf "%s %i\n" line (Puzzle.getNumGeneric line);
      sum := !sum + Puzzle.getNumGeneric line
      (* write on the underlying device now *)
    done;
    close_in ic (* close the input channel *)
  with End_of_file ->
    close_in ic;
    Printf.printf "SUM: %i\n" !sum
