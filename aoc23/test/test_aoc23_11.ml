let example =
  List.map Utilities.chars_of_string
    [
      "...#......";
      ".......#..";
      "#.........";
      "..........";
      "......#...";
      ".#........";
      ".........#";
      "..........";
      ".......#..";
      "#...#.....";
    ]

let exampleExpanded =
  List.map Utilities.chars_of_string
    [
      "....#........";
      ".........#...";
      "#............";
      ".............";
      ".............";
      "........#....";
      ".#...........";
      "............#";
      ".............";
      ".............";
      ".........#...";
      "#....#.......";
      (*01234567890*)
    ]

let test_testExpansion () =
  Alcotest.(check @@ list @@ list char)
    "same list" exampleExpanded (Galaxies.expand example)

let test_FindGalaxies () =
  Alcotest.(check @@ list @@ pair int int)
    "same list"
    [
      (5, 11); (0, 11); (9, 10); (12, 7); (1, 6); (8, 5); (0, 2); (9, 1); (4, 0);
    ]
    (Galaxies.findGalaxies exampleExpanded)

let test_task1 () =
  Alcotest.(check int) "same list" 374 (Galaxies.task1 example)

let test_task2 exp res () =
  Alcotest.(check int) "same list" res (Galaxies.task2 exp example)

let () =
  let open Alcotest in
  run "Pipeline"
    [
      ( "Support",
        [
          test_case "correct expansion" `Quick test_testExpansion;
          test_case "correct find" `Quick test_FindGalaxies;
          test_case "correct task1" `Quick test_task1;
          test_case "correct task2 by 10" `Quick (test_task2 10 1030);
          test_case "correct task2 by 100" `Quick (test_task2 100 8410);
        ] );
    ]
