(* The tests *)
let test_color getColor s res () =
  Alcotest.(check int) "same string" res (getColor s)

let test_red = test_color BagOcubes.getRed
let test_green = test_color BagOcubes.getGreen
let test_blue = test_color BagOcubes.getBlue
let extraction = Alcotest.testable BagOcubes.pp BagOcubes.equal

let test_read s res () =
  Alcotest.(check extraction) "same extraction" res (BagOcubes.makeExtraction s)

(* Run it *)
let () =
  let open Alcotest in
  run "Utils"
    [
      ( "getRed",
        [
          test_case ", 3 red" `Quick (test_red " 3 red" 3);
          test_case "31 red" `Quick (test_red "31 red" 31);
          test_case "not red" `Quick (test_red "3 blue" 0);
          test_case " get red in \"8 green, 6 blue, 20 red\"" `Quick
            (test_red "8 green, 6 blue, 20 red" 20);
        ] );
      ( "getGreen",
        [
          test_case "3 green" `Quick (test_green "3 green" 3);
          test_case "31 green" `Quick (test_green "4 red, 31 green" 31);
          test_case "not green" `Quick (test_green "3 blue" 0);
          test_case " get green in \"8 green, 6 blue, 20 red\"" `Quick
            (test_green "8 green, 6 blue, 20 red" 8);
        ] );
      ( "getBlue",
        [
          test_case "3 blue" `Quick (test_blue "3 blue, 4 red" 3);
          test_case "31 blue" `Quick (test_blue "31 blue" 31);
          test_case "not blue" `Quick (test_blue "3 green" 0);
          test_case " get blue in \"8 green, 6 blue, 20 red\"" `Quick
            (test_blue "8 green, 6 blue, 20 red" 6);
        ] );
      ( "read extraction",
        [
          test_case "8 green, 6 blue, 20 red" `Quick
            (test_read " 8 green, 6 blue, 20 red" { r = 20; g = 8; b = 6 });
          test_case "5 blue, 4 red, 13 green" `Quick
            (test_read "5 blue, 4 red, 13 green" { r = 4; g = 13; b = 5 });
          test_case "2 blue, 1 red, 2 green" `Quick
            (test_read "2 blue, 1 red, 2 green" { r = 1; g = 2; b = 2 });
        ] );
    ]
