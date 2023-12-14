(* represent a closed [] interval *)
type interval = { low : int; up : int }
type fromTo = { source : interval; dest : interval }
type intervalPos = UNDER | IN | ABOVE

let equalint (a : interval) (b : interval) = a.low == b.low && a.up == b.up
let ppint ppf { low; up } = Fmt.pf ppf "[%i, %i]" low up

let equalft (a : fromTo) (b : fromTo) =
  equalint a.source b.source && equalint a.dest b.dest

let ppft ppf { source; dest } =
  Fmt.pf ppf "[%i, %i] -> [%i, %i]" source.low source.up dest.low dest.up

(* compare x y returns 0 if x is equal to y,
   a negative integer if x is less than y,
    and a positive integer if x is greater than y.
    This ASSUMES that all the intervals here are not overlapped*)
let compare (a : fromTo) (b : fromTo) = a.source.low - b.source.low
(* if a.low < b.low then -1 else if a.low > b.low then 1 else 0 *)

let isIn intv i = intv.low <= i && i <= intv.up

let getPos intv i =
  if i < intv.low then UNDER else if intv.up < i then ABOVE else IN

let getShift intv i = i - intv.low
let mapTo intvTo intvFrom i = intvTo.low + getShift intvFrom i

let strToFromTo s =
  (*strings are sourcelow destLow interval*)
  let notEmpty str = String.equal String.empty str |> not in
  let splitted = String.split_on_char ' ' s |> List.filter notEmpty in
  let get = List.nth splitted in
  let sl = get 0 |> int_of_string in
  let dl = get 1 |> int_of_string in
  let myint = get 2 |> int_of_string in
  {
    source = { low = sl; up = sl + myint };
    dest = { low = dl; up = dl + myint };
  }
