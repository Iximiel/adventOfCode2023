let test_tolchars s res () =
  Alcotest.(check @@ list char) "same result" res (Utilities.chars_of_string s)

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
        ] );
    ]
