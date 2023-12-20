let test_decode expr res () =
  Alcotest.(check @@ list int) "same list" res (Nonogram1d.decode expr)

let test_possibilitiles expr hint res () =
  Alcotest.(check int) "same list" res (Nonogram1d.possibilities expr hint)

let () =
  let open Alcotest in
  run "Nonogram1D"
    [
      ( "Decode",
        [
          test_case "correct decode" `Quick (test_decode "#.#.###" [ 1; 1; 3 ]);
          test_case "correct decode" `Quick
            (test_decode ".#...#....###." [ 1; 1; 3 ]);
          test_case "correct decode" `Quick
            (test_decode ".#.###.#.######" [ 1; 3; 1; 6 ]);
          test_case "correct decode" `Quick
            (test_decode "####.#...#..." [ 4; 1; 1 ]);
          test_case "correct decode" `Quick
            (test_decode "#....######..#####." [ 1; 6; 5 ]);
          test_case "correct decode" `Quick
            (test_decode ".###.##....#" [ 3; 2; 1 ]);
        ] );
      ( "Find Combinations",
        [
          test_case "number of possibilities" `Quick
            (test_possibilitiles "???.###" [ 1; 1; 3 ] 1);
          test_case "number of possibilities" `Quick
            (test_possibilitiles ".??..??...?##." [ 1; 1; 3 ] 4);
          test_case "number of possibilities" `Quick
            (test_possibilitiles "?#?#?#?#?#?#?#?" [ 1; 3; 1; 6 ] 1);
          test_case "number of possibilities" `Quick
            (test_possibilitiles "????.#...#..." [ 4; 1; 1 ] 1);
          test_case "number of possibilities" `Quick
            (test_possibilitiles "????.######..#####." [ 1; 6; 5 ] 4);
          test_case "number of possibilities" `Quick
            (test_possibilitiles "?###????????" [ 3; 2; 1 ] 10);
        ] );
    ]
