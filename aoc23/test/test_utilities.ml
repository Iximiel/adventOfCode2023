let test_tolchars s res () =
  Alcotest.(check @@ list char) "same result" res (Utilities.chars_of_string s)

let primes = Utilities.findSomePrimes 40

let test_divisors num res () =
  let notZero x = snd x != 0 in
  Alcotest.(check @@ list (pair int int))
    "same result" res
    (Utilities.calculateDivisors primes num
    |> Utilities.DivMap.to_list |> List.filter notZero)

let () =
  let open Alcotest in
  run "Utils"
    [
      ( "string to list chars",
        [
          test_case "check to charL" `Quick
            (test_tolchars "test1" [ 't'; 'e'; 's'; 't'; '1' ]);
          test_case "check charL" `Quick
            (test_tolchars "ciao!" [ 'c'; 'i'; 'a'; 'o'; '!' ]);
        ] );
      ( "maths",
        [ test_case "divisors" `Quick (test_divisors 40 [ (2, 3); (5, 1) ]) ] );
    ]
