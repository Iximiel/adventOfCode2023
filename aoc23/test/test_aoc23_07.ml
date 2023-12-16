let example = [ "32T3K 765"; "T55J5 684"; "KK677 28"; "KTJJT 220"; "QQQJA 483" ]

let test_tolchars s res () =
  Alcotest.(check @@ list char) "same result" res (Cards.chars_of_string s)

let test_reorderhand s res () =
  Alcotest.(check string) "same result" res (Cards.reorderHand s)

let test_equals s res () =
  Alcotest.(check @@ list int)
    "same result" res
    (Cards.numEquals @@ Cards.reorderHand s)

let test_game ls res () = Alcotest.(check int) "same result" res (Cards.game ls)

let test_powercompare a b res () =
  Alcotest.(check int) "same result" res (Cards.powerCompare a b)

let () =
  let open Alcotest in
  run "Utils"
    [
      ( "test_tolchars",
        [
          test_case "check to charL" `Quick
            (test_tolchars "test" [ 't'; 'e'; 's'; 't' ]);
          test_case "check charL" `Quick
            (test_tolchars "ciao" [ 'c'; 'i'; 'a'; 'o' ]);
          test_case "check reorder" `Quick (test_reorderhand "9K33A" "AK933");
          test_case "check reorder" `Quick (test_reorderhand "5432A" "A5432");
          test_case "check equals" `Quick (test_equals "9K33A" [ 2 ]);
          test_case "check equals" `Quick (test_equals "9933A" [ 2; 2 ]);
          test_case "check equals" `Quick (test_equals "33399" [ 2; 3 ]);
          test_case "check equals" `Quick (test_equals "33K39" [ 3 ]);
          test_case "check equals" `Quick (test_equals "KKKKK" [ 5 ]);
          test_case "check equals" `Quick (test_equals "34567" []);
          test_case "check equals" `Quick (test_equals "AJKQT" []);
          test_case "check equals" `Quick (test_equals "KKQKK" [ 4 ]);
          test_case "check equals" `Quick (test_powercompare "77888" "77788" 1);
          test_case "check equals" `Quick
            (test_powercompare "2AAAA" "33332" (-1));
          test_case "check game" `Quick (test_game example 6440);
        ] );
    ]
