let checkint mystring myres () =
  Alcotest.(check int) "same int" myres (Trebuchet.getNum mystring)

let checkint_better mystring myres () =
  Alcotest.(check int) "same int" myres (Trebuchet.getNumGeneric mystring)

let () =
  let open Alcotest in
  run "List"
    [
      ( "List",
        [
          test_case "1abc2" `Quick (checkint "1abc2" 12);
          test_case "pqr3stu8vwx" `Quick (checkint "pqr3stu8vwx" 38);
          test_case "a1b2c3d4e5f" `Quick (checkint "a1b2c3d4e5f" 15);
          test_case "treb7uchet" `Quick (checkint "treb7uchet" 77);
          test_case "two1nine" `Quick (checkint_better "two1nine" 29);
          test_case "eightwothree" `Quick (checkint_better "eightwothree" 83);
          test_case "abcone2threexyz" `Quick
            (checkint_better "abcone2threexyz" 13);
          test_case "xtwone3four" `Quick (checkint_better "xtwone3four" 24);
          test_case "4nineeightseven2" `Quick
            (checkint_better "4nineeightseven2" 42);
          test_case "zoneight234" `Quick (checkint_better "zoneight234" 14);
          test_case "7pqrstsixteen" `Quick (checkint_better "7pqrstsixteen" 76);
        ] );
    ]
