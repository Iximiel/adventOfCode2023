(*
Time:      7  15   30
Distance:  9  40  200 
*)

let test_low t d res () =
  Alcotest.(check int) "same result" res (Raceboat.findFirstWin t d)

let test_up t d res () =
  Alcotest.(check int) "same result" res (Raceboat.findLastWin t d)

let test_combine t d res () =
  Alcotest.(check int) "same result" res (Raceboat.racePossibilities t d)

let () =
  let open Alcotest in
  run "Utils"
    [
      ( "lows",
        [
          test_case "check low" `Quick (test_low 7 9 2);
          test_case "check low" `Quick (test_low 15 40 4);
        ] );
      ( "ups",
        [
          test_case "check up" `Quick (test_up 7 9 5);
          test_case "check up" `Quick (test_up 15 40 11);
        ] );
      ( "combine",
        [
          test_case "check num" `Quick (test_combine 7 9 4);
          test_case "check num" `Quick (test_combine 15 40 8);
        ] );
    ]
