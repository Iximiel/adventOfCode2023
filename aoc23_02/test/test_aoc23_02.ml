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
      ( "getColors",
        [
          test_case "3 red" `Quick (test_red "3 red" 3);
          test_case "31 red" `Quick (test_red "31 red" 31);
          test_case "not red" `Quick (test_red "3 blue" 0);
          test_case "3 green" `Quick (test_green "3 green" 3);
          test_case "31 green" `Quick (test_green "31 green" 31);
          test_case "not green" `Quick (test_green "3 blue" 0);
          test_case "3 blue" `Quick (test_blue "3 blue" 3);
          test_case "31 blue" `Quick (test_blue "31 blue" 31);
          test_case "not blue" `Quick (test_blue "3 green" 0);
        ] );
      ( "read extraction",
        [
          test_case "8 green, 6 blue, 20 red" `Quick
            (test_read " 8 green, 6 blue, 20 red" { r = 20; g = 8; b = 6 });
        ] );
    ]
