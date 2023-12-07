let example =
  [
    "467..114..";
    "...*......";
    "..35..633.";
    "......#...";
    "617*......";
    ".....+.58.";
    "..592.....";
    "......755.";
    "...$.*....";
    ".664.598..";
  ]

let exampleLine = List.nth example

let test_numberlist_sl s res () =
  Alcotest.(check (list int))
    "same extraction" res
    (Schematics.checkOnline s "" "")

let () =
  let open Alcotest in
  run "Utils"
    [
      ( "singleline",
        [
          test_case "single match" `Quick
            (test_numberlist_sl (exampleLine 4) [ 617 ]);
          test_case "double match" `Quick
            (test_numberlist_sl "..617*...]89..." [ 617; 89 ]);
        ] );
    ]
