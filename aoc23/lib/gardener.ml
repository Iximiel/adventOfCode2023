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
let compareft (a : fromTo) (b : fromTo) = a.source.low - b.source.low
(* if a.low < b.low then -1 else if a.low > b.low then 1 else 0 *)

let isIn intv i = intv.low <= i && i <= intv.up

let getPos intv i =
  if i < intv.low then UNDER else if intv.up < i then ABOVE else IN

let getShift intv i = i - intv.low
let mapTo intvFrom intvTo i = intvTo.low + getShift intvFrom i

let strToFromTo s =
  (*strings are sourcelow destLow interval*)
  let notEmpty str = String.equal String.empty str |> not in
  let splitted = String.split_on_char ' ' s |> List.filter notEmpty in
  let get = List.nth splitted in
  let sl = get 1 |> int_of_string in
  let dl = get 0 |> int_of_string in
  (* the interval is of myint, without the -1 i will get one more number in*)
  let myint = (get 2 |> int_of_string) - 1 in
  {
    source = { low = sl; up = sl + myint };
    dest = { low = dl; up = dl + myint };
  }

let getMap ls = List.map strToFromTo ls |> List.sort compareft

let convert map i =
  let rec aux m =
    match m with
    | [] -> i
    | intv :: lm ->
        if isIn intv.source i then mapTo intv.source intv.dest i else aux lm
  in
  aux map

(* reader *)
type completeMap = {
  seeds : int list;
  se2so : fromTo list;
  so2f : fromTo list;
  f2w : fromTo list;
  w2li : fromTo list;
  li2t : fromTo list;
  t2h : fromTo list;
  h2lo : fromTo list;
}

let reader ls =
  let rec aux l r =
    match l with
    | [] -> [ List.rev r ]
    | "" :: ll -> List.rev r :: aux ll []
    | any :: ll -> aux ll (any :: r)
  in
  let mm = aux (List.tl ls) [] in
  let notEmpty str = String.equal String.empty str |> not in
  let tmp =
    String.split_on_char ' ' (List.hd ls)
    |> List.filter notEmpty |> List.tl |> List.map int_of_string
  in
  {
    seeds = tmp;
    (*skips the first blank line*)
    se2so = getMap @@ List.tl @@ List.nth mm 1;
    so2f = getMap @@ List.tl @@ List.nth mm 2;
    f2w = getMap @@ List.tl @@ List.nth mm 3;
    w2li = getMap @@ List.tl @@ List.nth mm 4;
    li2t = getMap @@ List.tl @@ List.nth mm 5;
    t2h = getMap @@ List.tl @@ List.nth mm 6;
    h2lo = getMap @@ List.tl @@ List.nth mm 7;
  }

let getLocations myMap =
  let translator i =
    convert myMap.se2so i |> convert myMap.so2f |> convert myMap.f2w
    |> convert myMap.w2li |> convert myMap.li2t |> convert myMap.t2h
    |> convert myMap.h2lo
  in
  List.map translator myMap.seeds
