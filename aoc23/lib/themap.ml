module StrMap = struct
  type t = string

  let compare x0 x1 = String.compare x0 x1
end

module StringsMap = Map.Make (StrMap)

type node = { l : string; r : string }

let decodeline = Str.regexp {|\([A-Z0-9]*\) = (\([A-Z0-9]*\), \([A-Z0-9]*\))|}
let linedecoder s = Str.string_match decodeline s 0

let createMap l =
  let rec aux input map =
    match input with
    | [] -> map
    | line :: lines ->
        if linedecoder line then
          let key = Str.matched_group 1 line
          and llink = Str.matched_group 2 line
          and rlink = Str.matched_group 3 line in
          aux lines (StringsMap.add key { l = llink; r = rlink } map)
        else raise (Invalid_argument ("failed to read" ^ line))
  in
  aux l StringsMap.empty

let getR map s = (StringsMap.find s map).r
let getL map s = (StringsMap.find s map).l

let traverseFrom start obj map steps =
  let walk = ref 0
  and key = ref start
  and lturn = getL map
  and rturn = getR map
  and moduloSteps x = x mod String.length steps in
  while obj !key do
    key := if steps.[moduloSteps !walk] == 'L' then lturn !key else rturn !key;
    walk := succ !walk
  done;
  !walk

let traverse =
  let check x = String.compare "ZZZ" x != 0 in
  traverseFrom "AAA" check

let isStart s = 'A' == s.[2]
let isStart_ s _ = 'A' == s.[2]
let isEnd s = 'Z' == s.[2]
let isEnd_ s _ = 'Z' == s.[2]
let createRef pair = ref (fst pair)

let traverseInParallel map steps =
  let walk = ref 0
  and lturn = getL map
  and rturn = getR map
  and moduloSteps x = x mod String.length steps in
  let keys =
    StringsMap.filter isStart_ map |> StringsMap.to_list |> List.map createRef
  in
  let rec buddies refs =
    match refs with
    | [] -> ()
    | r :: others ->
        r := if steps.[moduloSteps !walk] == 'L' then lturn !r else rturn !r;
        buddies others
  in
  let rec buddyCheck refs =
    match refs with
    | [] -> true (*this is actually a bad idea*)
    | r :: others -> isEnd !r && buddyCheck others
  in
  while not @@ buddyCheck keys do
    buddies keys;

    walk := succ !walk;
    if !walk mod 10000 == 0 then
      Printf.printf "%i, (%i)\b\r%!" !walk (List.length keys)
  done;
  !walk
