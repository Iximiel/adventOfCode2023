let example1 =
  [
    "RL";
    "";
    "AAA = (BBB, CCC)";
    "BBB = (DDD, EEE)";
    "CCC = (ZZZ, GGG)";
    "DDD = (DDD, DDD)";
    "EEE = (EEE, EEE)";
    "GGG = (GGG, GGG)";
    "ZZZ = (ZZZ, ZZZ)";
  ]

let example2 =
  [ "LLR"; ""; "AAA = (BBB, BBB)"; "BBB = (AAA, ZZZ)"; "ZZZ = (ZZZ, ZZZ)" ]

let example3 =
  [
    "LR";
    "";
    "11A = (11B, XXX)";
    "11B = (XXX, 11Z)";
    "11Z = (11B, XXX)";
    "22A = (22B, XXX)";
    "22B = (22C, 22C)";
    "22C = (22Z, 22Z)";
    "22Z = (22B, 22B)";
    "XXX = (XXX, XXX)";
  ]

let examplemap1 = Themap.createMap (List.tl example1 |> List.tl)
let examplemap2 = Themap.createMap (List.tl example2 |> List.tl)
let examplemap3 = Themap.createMap (List.tl example3 |> List.tl)

let test_getRAAA tm res () =
  Alcotest.(check string) "same result" res (Themap.getR tm "AAA")

let test_walk tm itinery res () =
  Alcotest.(check int) "same result" res (Themap.traverse tm itinery)

let test_walkParallel tm itinery res () =
  Alcotest.(check int) "same result" res (Themap.traverseInParallel tm itinery)

let () =
  let open Alcotest in
  run "TheMap"
    [
      ( "makin gmaps",
        [
          test_case "get r from AAA (1)" `Quick (test_getRAAA examplemap1 "CCC");
          test_case "get r from AAA (2)" `Quick (test_getRAAA examplemap2 "BBB");
        ] );
      ( "walking maps",
        [
          test_case "walk map1" `Quick
            (test_walk examplemap1 (List.hd example1) 2);
          test_case "walk map2" `Quick
            (test_walk examplemap2 (List.hd example2) 6);
          test_case "walk map2" `Quick
            (test_walkParallel examplemap3 (List.hd example3) 6);
        ] );
    ]
