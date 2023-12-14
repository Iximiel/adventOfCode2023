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

let _ = example

(* let interval = Alcotest.testable Gardener.ppint Gardener.equalint *)
let fromTo = Alcotest.testable Gardener.ppft Gardener.equalft

let test_isIn myint num () =
  Alcotest.(check bool) "same result" true (Gardener.isIn myint num)

let test_isNotIn myint num () =
  Alcotest.(check bool) "same result" false (Gardener.isIn myint num)

let test_parseFT s res () =
  Alcotest.(check fromTo) "same result" res (Gardener.strToFromTo s)

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
      ( "FromTp",
        [
          test_case "parser" `Quick
            (test_parseFT "80 30 5"
               { source = { low = 80; up = 85 }; dest = { low = 30; up = 35 } });
        ] );
    ]
