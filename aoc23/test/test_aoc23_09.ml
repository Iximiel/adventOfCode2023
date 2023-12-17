let test_nextLine ls res () =
  Alcotest.(check @@ list int) "same list" res (Predictor.nextBySub ls)

let test_All ls res () =
  Alcotest.(check @@ list @@ list int)
    "same list" res (Predictor.getAllBySub ls)

let test_predictSub ls res () =
  Alcotest.(check int)
    "same res" res
    (Predictor.getAllBySub ls |> Predictor.predictBySub)

let () =
  let open Alcotest in
  run "TheMap"
    [
      ( "calculating thext sequences",
        [
          test_case "next line (equal)" `Quick
            (test_nextLine [ 0; 3; 6; 9; 12; 15 ] [ 3; 3; 3; 3; 3 ]);
          test_case "next line" `Quick
            (test_nextLine [ 1; 3; 6; 10; 15; 21 ] [ 2; 3; 4; 5; 6 ]);
          test_case "all (1 iter)" `Quick
            (test_All [ 0; 3; 6; 9; 12; 15 ]
               [ [ 0; 3; 6; 9; 12; 15 ]; [ 3; 3; 3; 3; 3 ] ]);
          test_case "all (2 iter)" `Quick
            (test_All [ 1; 3; 6; 10; 15; 21 ]
               [ [ 1; 3; 6; 10; 15; 21 ]; [ 2; 3; 4; 5; 6 ]; [ 1; 1; 1; 1 ] ]);
        ] );
      ( " predicting things",
        [
          test_case "example1" `Quick
            (test_predictSub [ 0; 3; 6; 9; 12; 15 ] 18);
          test_case "example2" `Quick
            (test_predictSub [ 1; 3; 6; 10; 15; 21 ] 28);
          test_case "example2" `Quick
            (test_predictSub [ 10; 13; 16; 21; 30; 45 ] 68);
        ] );
    ]
