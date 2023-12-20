let isgalaxy = Char.equal '#'

let rec expandRowsBy n = function
  | [] -> []
  | l :: lines ->
      let makeN l (_ : int) = l in
      if List.exists isgalaxy l then l :: expandRowsBy n lines
      else List.init n (makeN l) @ expandRowsBy n lines

let expandRows = expandRowsBy 2

let expandBy n l =
  Utilities.rotate @@ expandRowsBy n @@ Utilities.rotate @@ expandRowsBy n l

let expand = expandBy 2
let manhattanD xy xy2 = abs (fst xy - fst xy2) + abs (snd xy - snd xy2)
let findAgalaxy hindex thing = if isgalaxy thing then Some hindex else None

let findGalaxies gmap =
  let makecoord y x = (x, y) in
  let rec galOnRow hindex res = function
    | [] -> res
    | c :: s ->
        if isgalaxy c then galOnRow (hindex + 1) (hindex :: res) s
        else galOnRow (hindex + 1) res s
  in
  let rec aux ln h ret =
    match ln with
    | [] -> ret
    | l :: lines ->
        aux lines (h + 1) @@ (List.map (makecoord h) @@ galOnRow 0 [] l) @ ret
  in
  aux gmap 0 []

let listOfDist galaxylist =
  let rec outerLoop gl glm1 =
    match gl with
    | [] -> []
    | [ _ ] -> [] (*glm1 is []*)
    | galaxy :: gm ->
        let rec innerloop = function
          | [] -> []
          | other :: gls -> manhattanD other galaxy :: innerloop gls
        in
        innerloop glm1 @ outerLoop gm @@ List.tl glm1
  in
  outerLoop galaxylist @@ List.tl galaxylist

let task1 lol =
  Utilities.accumulateSum @@ listOfDist @@ findGalaxies @@ expand lol

let task2 num lol =
  Utilities.accumulateSum @@ listOfDist @@ findGalaxies @@ expandBy num lol
