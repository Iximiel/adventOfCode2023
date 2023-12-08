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

let exampleres = [ 467; 35; 633; 617; 592; 755; 664; 598 ]
let exampleLine = List.nth example

let test_full mylist res () =
  Alcotest.(check (list int))
    "same list" res
    (Schematics.checkWholeSchema ("" :: mylist))

let test_numberlist s lb la res () =
  Alcotest.(check (list int)) "same list" res (Schematics.checkOnline s lb la)

let test_numberlist_sl s res () = test_numberlist s "" "" res ()
let test_numberlist_lb s lb res () = test_numberlist s lb "" res ()
let test_numberlist_la s la res () = test_numberlist s "" la res ()

let () =
  let open Alcotest in
  run "Utils"
    [
      ( "singleline",
        [
          test_case "single match" `Quick
            (test_numberlist_sl (exampleLine 4) [ 617 ]);
          test_case "no match" `Quick (test_numberlist_sl (exampleLine 2) []);
          test_case "no match" `Quick (test_numberlist_sl ".5." []);
          test_case "single match" `Quick (test_numberlist_sl "*617" [ 617 ]);
          test_case "single match" `Quick
            (test_numberlist_sl ".3*617" [ 3; 617 ]);
          test_case "double match" `Quick
            (test_numberlist_sl "..617*...]89..." [ 617; 89 ]);
        ] );
      ( "line before",
        [
          test_case "no match" `Quick (test_numberlist_lb ".35..." "....*." []);
          test_case "no match" `Quick (test_numberlist_lb "...35." ".*...." []);
          test_case "single match" `Quick
            (test_numberlist_lb "35..." "..*.." [ 35 ]);
          test_case "single match" `Quick
            (test_numberlist_lb (exampleLine 2) "123*5678901" [ 35 ]);
          test_case "single match" `Quick
            (test_numberlist_lb (exampleLine 2) (exampleLine 1) [ 35 ]);
        ] );
      ( "line after",
        [
          test_case "no match" `Quick (test_numberlist_la ".35..." "....*." []);
          test_case "no match" `Quick (test_numberlist_la "...35." ".*...." []);
          test_case "single match" `Quick
            (test_numberlist_la "35..." "..*.." [ 35 ]);
          test_case "single match" `Quick
            (test_numberlist_la (exampleLine 2) "123*5678901" [ 35 ]);
          test_case "single match" `Quick
            (test_numberlist_la (exampleLine 2) (exampleLine 3) [ 633 ]);
        ] );
      ("example", [ test_case "full run" `Quick (test_full example exampleres) ]);
    ]
