let () =
  let filename = "day4" in
  let mysum = ref 0 in
  let chan = open_in filename in
  try
    while true do
      let line = input_line chan in
      mysum := !mysum + (Scratcher.getObjAndGame line |> Scratcher.getWinning)
    done
  with End_of_file ->
    close_in chan;
    print_string "task 1: ";
    print_int !mysum;
    print_endline "";
    print_string "task 2: ";
    (* print_int !mypow; *)
    print_endline ""
