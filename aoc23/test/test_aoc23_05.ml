let example =
  [
    "seeds: 79 14 55 13";
    "";
    "seed-to-soil map:";
    "50 98 2";
    "52 50 48";
    "";
    "soil-to-fertilizer map:";
    "0 15 37";
    "37 52 2";
    "39 0 15";
    "";
    "fertilizer-to-water map:";
    "49 53 8";
    "0 11 42";
    "42 0 7";
    "57 7 4";
    "";
    "water-to-light map:";
    "88 18 7";
    "18 25 70";
    "";
    "light-to-temperature map:";
    "45 77 23";
    "81 45 19";
    "68 64 13";
    "";
    "temperature-to-humidity map:";
    "0 69 1";
    "1 0 69";
    "";
    "humidity-to-location map:";
    "60 56 37";
    "56 93 4";
  ]

(* let interval = Alcotest.testable Gardener.ppint Gardener.equalint *)
let fromTo = Alcotest.testable Gardener.ppft Gardener.equalft

let test_isIn myint num () =
  Alcotest.(check bool) "same result" true (Gardener.isIn myint num)

let test_isNotIn myint num () =
  Alcotest.(check bool) "same result" false (Gardener.isIn myint num)

let test_parseFT s res () =
  Alcotest.(check fromTo) "same result" res (Gardener.strToFromTo s)

let test_parseFTM ls res () =
  Alcotest.(check @@ list fromTo) "same result" res (Gardener.getMap ls)

let test_convert ls i res () =
  Alcotest.(check int)
    "same result" res
    (Gardener.convert (Gardener.getMap ls) i)

let ttt () =
  Alcotest.(check @@ list fromTo)
    "same result"
    (Gardener.getMap [ "45 77 23"; "81 45 19"; "68 64 13" ])
    (Gardener.reader example).li2t

let test_game () =
  Alcotest.(check int)
    "same result" 35
    (Gardener.getLocations (Gardener.reader example)
    |> List.sort ( - ) |> List.hd)

let test_game2 () =
  Alcotest.(check int)
    "same result" 46
    (Gardener.getLocations (Gardener.correctReader example)
    |> List.sort ( - ) |> List.hd)

let () =
  let open Alcotest in
  run "Utils"
    [
      ( "intervals",
        [
          test_case "is in" `Quick (test_isIn { low = 2; up = 3 } 3);
          test_case "is in" `Quick (test_isIn { low = 1; up = 3 } 1);
          test_case "is not in" `Quick (test_isNotIn { low = 1; up = 3 } 4);
        ] );
      ( "FromTo",
        [
          test_case "parser" `Quick
            (test_parseFT "80 30 5"
               { source = { low = 30; up = 34 }; dest = { low = 80; up = 84 } });
          test_case "parser" `Quick
            (test_parseFT "80 30 1"
               { source = { low = 30; up = 30 }; dest = { low = 80; up = 80 } });
          test_case "parser" `Quick
            (test_parseFT "45 79 5"
               { source = { low = 79; up = 83 }; dest = { low = 45; up = 49 } });
          test_case "parser list" `Quick
            (test_parseFTM [ "30 80 5"; "79 45 5" ]
               [
                 {
                   source = { low = 45; up = 49 };
                   dest = { low = 79; up = 83 };
                 };
                 {
                   source = { low = 80; up = 84 };
                   dest = { low = 30; up = 34 };
                 };
               ]);
          test_case "converter" `Quick
            (test_convert [ "30 80 5"; "79 45 5" ] 10 10);
          test_case "converter" `Quick
            (test_convert [ "30 80 5"; "79 45 5" ] 81 31);
          test_case "converter" `Quick
            (test_convert [ "30 80 5"; "79 45 5" ] 46 80);
          test_case "converter" `Quick
            (test_convert [ "50 98 2"; "52 50 48" ] 79 81);
        ] );
      ( "reader",
        [
          test_case "reader" `Quick ttt;
          test_case "task1" `Quick test_game;
          test_case "task2" `Quick test_game2;
        ] );
    ]
