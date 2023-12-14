(* represent a closed [] interval *)
type interval = { low : int; up : int }
type intervalPos = UNDER | IN | ABOVE

let equalint (a : interval) (b : interval) = a.low == b.up && a.low == b.up
let ppint ppf { low; up } = Fmt.pf ppf "[%i, %i]" low up

(* compare x y returns 0 if x is equal to y,
   a negative integer if x is less than y,
    and a positive integer if x is greater than y.
    This ASSUMES that all the intervals here are not overlapped*)
let compare (a : interval) (b : interval) = a.low - b.low
(* if a.low < b.low then -1 else if a.low > b.low then 1 else 0 *)

let isIn intv i = intv.low <= i && i <= intv.up

let getPos intv i =
  if i < intv.low then UNDER else if intv.up < i then ABOVE else IN

let getShift intv i = i - intv.low
let mapTo intvTo intvFrom i = intvTo.low + getShift intvFrom i
