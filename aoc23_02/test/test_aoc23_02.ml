(* The tests *)
let test_color getColor s res () =
  Alcotest.(check int) "same result" res (getColor s)

let test_game s res () =
  Alcotest.(check int) "same result" res (BagOcubes.getGameID s)

let test_red = test_color BagOcubes.getRed
let test_green = test_color BagOcubes.getGreen
let test_blue = test_color BagOcubes.getBlue
let extraction = Alcotest.testable BagOcubes.pp BagOcubes.equal

let test_read s res () =
  Alcotest.(check extraction) "same extraction" res (BagOcubes.makeExtraction s)

let test_possibleExtraction10_10_10 s res () =
  Alcotest.(check bool)
    "same extraction" res
    (BagOcubes.isPossibleExtraction 10 10 10 s)

let test_gameExtr s res () =
  Alcotest.(check (list extraction))
    "same extraction" res
    (BagOcubes.getExtractions s)

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
      ( "Games id",
        [
          test_case "Game 1: 3 blue, 4 red; 1 red, 2 green, 6 blue; 2 green"
            `Quick
            (test_game "Game 1: 3 blue, 4 red; 1 red, 2 green, 6 blue; 2 green"
               1);
          test_case
            "Game 2: 1 blue, 2 green; 3 green, 4 blue, 1 red; 1 green, 1 blue"
            `Quick
            (test_game
               "Game 2: 1 blue, 2 green; 3 green, 4 blue, 1 red; 1 green, 1 \
                blue"
               2);
          test_case
            "Game 3: 8 green, 6 blue, 20 red; 5 blue, 4 red, 13 green; 5 \
             green, 1 red"
            `Quick
            (test_game
               "Game 3: 8 green, 6 blue, 20 red; 5 blue, 4 red, 13 green; 5 \
                green, 1 red"
               3);
          test_case
            "Game 4: 1 green, 3 red, 6 blue; 3 green, 6 red; 3 green, 15 blue, \
             14 red"
            `Quick
            (test_game
               "Game 4: 1 green, 3 red, 6 blue; 3 green, 6 red; 3 green, 15 \
                blue, 14 red"
               4);
          test_case "Game 5: 6 red, 1 blue, 3 green; 2 blue, 1 red, 2 green"
            `Quick
            (test_game "Game 5: 6 red, 1 blue, 3 green; 2 blue, 1 red, 2 green"
               5);
        ] );
      ( "test_gameExtr",
        [
          test_case "Game 5: 6 red, 1 blue, 3 green; 2 blue, 1 red, 2 green"
            `Quick
            (test_gameExtr
               "Game 5: 6 red, 1 blue, 3 green; 2 blue, 1 red, 2 green"
               [
                 BagOcubes.makeExtraction "6 red, 1 blue, 3 green";
                 BagOcubes.makeExtraction "2 blue, 1 red, 2 green";
               ]);
          test_case
            "Game 3: 8 green, 6 blue, 20 red; 5 blue, 4 red, 13 green; 5 \
             green, 1 red"
            `Quick
            (test_gameExtr
               "Game 3: 8 green, 6 blue, 20 red; 5 blue, 4 red, 13 green; 5 \
                green, 1 red"
               [
                 BagOcubes.makeExtraction "8 green, 6 blue, 20 red";
                 BagOcubes.makeExtraction "5 blue, 4 red, 13 green";
                 BagOcubes.makeExtraction "5 green, 1 red";
               ]);
        ] );
      ( "test_possibleGames",
        [
          test_case "2 blue, 1 red, 2 green" `Quick
            (test_possibleExtraction10_10_10
               (BagOcubes.makeExtraction "2 blue, 1 red, 2 green")
               true);
          test_case "6 red, 1 blue, 3 green" `Quick
            (test_possibleExtraction10_10_10
               (BagOcubes.makeExtraction "6 red, 1 blue, 3 green")
               true);
          test_case "8 green, 6 blue, 20 red" `Quick
            (test_possibleExtraction10_10_10
               (BagOcubes.makeExtraction "8 green, 6 blue, 20 red")
               false);
          test_case "5 blue, 4 red, 13 green" `Quick
            (test_possibleExtraction10_10_10
               (BagOcubes.makeExtraction "5 blue, 4 red, 13 green")
               false);
          test_case "5 green, 1 red" `Quick
            (test_possibleExtraction10_10_10
               (BagOcubes.makeExtraction "5 green, 1 red")
               true);
        ] );
    ]
