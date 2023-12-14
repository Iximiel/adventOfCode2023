let file = "day01"
let sum = ref 0

let () =
  (* Read file and display the first line *)
  let ic = open_in file in
  try
    while true do
      let line = input_line ic in
      (* read line, discard \n *)
      Printf.printf "%s %i\n" line (Trebuchet.getNumGeneric line);
      sum := !sum + Trebuchet.getNumGeneric line
      (* write on the underlying device now *)
    done;
    close_in ic (* close the input channel *)
  with End_of_file ->
    close_in ic;
    Printf.printf "SUM: %i\n" !sum
