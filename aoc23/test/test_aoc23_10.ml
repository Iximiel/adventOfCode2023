(*
..F7.
.FJ|.
SJ.L7
|F--J
LJ...
*)
let example1 = [ "..F7."; ".FJ|."; "SJ.L7"; "|F--J"; "LJ..." ]

(*
.....
.S-7.
.|.|.
.L-J.
.....
*)
let examplesimple = [ "....."; ".S-7."; ".|.|."; ".L-J."; "....." ]

(*
...........
.S-------7.
.|F-----7|.
.||.....||.
.||.....||.
.|L-7.F-J|.
.|..|.|..|.
.L--J.L--J.
...........
*)
let exampleAreaSimple =
  [
    (* "..........."; *)
    ".S-------7.";
    ".|F-----7|.";
    ".||.....||.";
    ".||.....||.";
    ".|L-7.F-J|.";
    ".|..|.|..|.";
    ".L--J.L--J.";
    (* "..........."; *)
  ]

let exampleSimpleSmaller =
  [
    "..........";
    ".S------7.";
    ".|F----7|.";
    ".||OOOO||.";
    ".||OOOO||.";
    ".|L-7F-J|.";
    ".|II||II|.";
    ".L--JL--J.";
    "..........";
  ]

let exampleAreaComplex =
  [
    ".F----7F7F7F7F-7....";
    ".|F--7||||||||FJ....";
    ".||.FJ||||||||L7....";
    "FJL7L7LJLJ||LJ.L-7..";
    "L--J.L7...LJS7F-7L7.";
    "....F-J..F7FJ|L7L7L7";
    "....L7.F7||L7|.L7L7|";
    ".....|FJLJ|FJ|F7|.LJ";
    "....FJL-7.||.||||...";
    "....L---J.LJ.LJLJ...";
  ]

let walker = Alcotest.testable Pipeline.Walker.pp Pipeline.Walker.equal

let test_FindS map res () =
  Alcotest.(check @@ pair int int)
    "same starting position" res (Pipeline.findStart map)

let test_InitialPoints map res () =
  Alcotest.(check @@ list walker)
    "same walkers" res
    (Pipeline.findInitialPoints map)

let test_Task1 map res () =
  Alcotest.(check int) "same distance" res (Pipeline.walkForTask1 map)

let test_Task2 map res () =
  Alcotest.(check int) "same area" res (Pipeline.walkForTask2 map)

let () =
  let open Alcotest in
  run "Pipeline"
    [
      ( "Support",
        [
          test_case "find start (simple)" `Quick
            (test_FindS examplesimple (1, 1));
          test_case "find start" `Quick (test_FindS example1 (0, 2));
          test_case "find starting Walkers (simple)" `Quick
            (test_InitialPoints examplesimple
               [ { d = South; x = 1; y = 2 }; { d = East; x = 2; y = 1 } ]);
          test_case "find  starting Walkers" `Quick
            (test_InitialPoints example1
               [ { d = South; x = 0; y = 3 }; { d = East; x = 1; y = 2 } ]);
        ] );
      ( "Task check",
        [
          test_case "find path (simple)" `Quick (test_Task1 examplesimple 4);
          test_case "find path" `Quick (test_Task1 example1 8);
          (* test_case "find path" `Quick (test_Task2 examplesimple 1); *)
          test_case "find path" `Quick (test_Task2 exampleAreaSimple 4);
          test_case "find path" `Quick (test_Task2 exampleSimpleSmaller 4);
          test_case "find path" `Quick (test_Task2 exampleAreaComplex 8);
        ] );
    ]
