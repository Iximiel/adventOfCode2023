let test_numGetter s res () =
  Alcotest.(check (list int)) "same result" res (Scratcher.getNumList s)

let scratchcard = Alcotest.testable Scratcher.pp Scratcher.equal

let test_gameGetter s res () =
  Alcotest.(check scratchcard) "same result" res (Scratcher.getObjAndGame s)

let test_card s res () =
  Alcotest.(check int)
    "same result" res
    (Scratcher.getObjAndGame s |> Scratcher.getWinning)

let test_incrementer l num rep res () =
  Alcotest.(check @@ list int)
    "same list" res
    (Scratcher.headIncrementer l num rep)

let test_task2 s res () =
  Alcotest.(check int)
    "same result" res
    (let rec doSum = function [] -> 0 | i :: l -> i + doSum l in
     List.map Scratcher.getObjAndGame s
     |> Scratcher.calculateWinning |> Scratcher.elaborateWinning |> doSum)

let () =
  let open Alcotest in
  run "Utils"
    [
      ( "get nums",
        [
          test_case "getNums" `Quick
            (test_numGetter " 41 48 83 86 17" [ 41; 48; 83; 86; 17 ]);
        ] );
      ( "get Game",
        [
          test_case "getNums" `Quick
            (test_gameGetter "Card 1: 41 48 83 86 17 | 83 86  6 31 17  9 48 53"
               {
                 obj = [ 41; 48; 83; 86; 17 ];
                 game = [ 83; 86; 6; 31; 17; 9; 48; 53 ];
               });
        ] );
      ( "test Game",
        [
          test_case "card 1" `Quick
            (test_card "Card 1: 41 48 83 86 17 | 83 86  6 31 17  9 48 53" 8);
          test_case "card 2" `Quick
            (test_card "Card 2: 13 32 20 16 61 | 61 30 68 82 17 32 24 19" 2);
          test_case "card 3" `Quick
            (test_card "Card 3:  1 21 53 59 44 | 69 82 63 72 16 21 14  1" 2);
          test_case "card 4" `Quick
            (test_card "Card 4: 41 92 73 84 69 | 59 84 76 51 58  5 54 83" 1);
          test_case "card 5" `Quick
            (test_card "Card 5: 87 83 26 28 32 | 88 30 70 12 93 22 82 36" 0);
          test_case "card 6" `Quick
            (test_card "Card 6: 31 18 13 56 72 | 74 77 10 23 35 67 36 11" 0);
        ] );
      ( "Test task2",
        [
          test_case "test incrementer" `Quick
            (test_incrementer [ 1; 1; 1; 1 ] 1 2 [ 2; 2; 1; 1 ]);
          test_case "test incrementer" `Quick
            (test_incrementer [ 1; 1; 1; 1 ] 2 3 [ 3; 3; 3; 1 ]);
          test_case "test incrementer" `Quick
            (test_incrementer [ 1; 1; 1; 1 ] 2 0 [ 1; 1; 1; 1 ]);
          test_case "task2" `Quick
            (test_task2
               [
                 "Card 1: 41 48 83 86 17 | 83 86  6 31 17  9 48 53";
                 "Card 2: 13 32 20 16 61 | 61 30 68 82 17 32 24 19";
                 "Card 3:  1 21 53 59 44 | 69 82 63 72 16 21 14  1";
                 "Card 4: 41 92 73 84 69 | 59 84 76 51 58  5 54 83";
                 "Card 5: 87 83 26 28 32 | 88 30 70 12 93 22 82 36";
                 "Card 6: 31 18 13 56 72 | 74 77 10 23 35 67 36 11";
               ]
               30);
        ] );
    ]
