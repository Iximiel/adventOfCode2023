let example = [ "32T3K 765"; "T55J5 684"; "KK677 28"; "KTJJT 220"; "QQQJA 483" ]

let test_tolchars s res () =
  Alcotest.(check @@ list char) "same result" res (Cards.chars_of_string s)

let test_reorderhand s res () =
  Alcotest.(check string) "same result" res (Cards.reorderHand s)

let test_orderhands lh res () =
  Alcotest.(check @@ list string)
    "same result" res
    (List.sort Cards.powerCompare lh)

let test_handStrenght s res () =
  Alcotest.(check int) "same result" res (Cards.handStrength s)

let test_game ls res () =
  Alcotest.(check int64) "same result" res (Cards.game ls)

let test_powercompare a b res () =
  Alcotest.(check int) "same result" res (Cards.powerCompare a b)

let () =
  let open Alcotest in
  run "Utils"
    [
      ( "test_tolchars",
        [
          test_case "check to charL" `Quick
            (test_tolchars "test1" [ 't'; 'e'; 's'; 't'; '1' ]);
          test_case "check charL" `Quick
            (test_tolchars "ciao!" [ 'c'; 'i'; 'a'; 'o'; '!' ]);
          test_case "check reorder" `Quick (test_reorderhand "9K33A" "AK933");
          test_case "check reorder" `Quick (test_reorderhand "5432A" "A5432");
          test_case "check reorder" `Quick (test_reorderhand "32323" "33322");
          test_case "check reorderFULL" `Quick
            (test_reorderhand "23456789TJQKA" "AKQJT98765432");
          test_case "check handStrenght" `Quick
            (test_handStrenght "9K33A" Cards.couple);
          test_case "check handStrenght" `Quick
            (test_handStrenght "9933A" Cards.double);
          test_case "check handStrenght" `Quick
            (test_handStrenght "33399" Cards.full);
          test_case "check handStrenght" `Quick
            (test_handStrenght "33K39" Cards.three);
          test_case "check handStrenght" `Quick
            (test_handStrenght "KKKKK" Cards.five);
          test_case "check handStrenght" `Quick
            (test_handStrenght "34567" Cards.high);
          test_case "check handStrenght" `Quick
            (test_handStrenght "AJKQT" Cards.high);
          test_case "check handStrenght" `Quick
            (test_handStrenght "KKQKK" Cards.four);
          test_case "check handStrenght" `Quick
            (test_handStrenght "32323" Cards.full);
        ] );
      ( "test_applications",
        [
          test_case "check equals" `Quick (test_powercompare "77888" "77788" 1);
          test_case "check equals" `Quick
            (test_powercompare "2AAAA" "33332" (-1));
          test_case "check order" `Quick
            (test_orderhands
               [
                 "22222";
                 "24562";
                 "32632";
                 "AQQQQ";
                 "QQAQQ";
                 "Q3345";
                 "32323";
                 "43414";
                 "AKQJT";
               ]
               [
                 "AKQJT";
                 "24562";
                 "Q3345";
                 "32632";
                 "43414";
                 "32323";
                 "QQAQQ";
                 "AQQQQ";
                 "22222";
               ]);
          test_case "check game" `Quick (test_game example 6440L);
        ] );
    ]
