let isgalaxy = Char.equal '#'

let rec expandRowsBy n = function
  | [] -> []
  | l :: lines ->
      let makeN l (_ : int) = l in
      if List.exists isgalaxy l then l :: expandRowsBy n lines
      else List.init (n + 1) (makeN l) @ expandRowsBy n lines

let expandRows = expandRowsBy 1

let expandBy n l =
  Utilities.rotate @@ expandRowsBy n @@ Utilities.rotate @@ expandRowsBy n l

let expand = expandBy 1
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

let getGlxs num lol = findGalaxies @@ expandBy num lol
let glxdiff g1 g2 = (fst g1 - fst g2, snd g1 - snd g2)
let glxsum g1 g2 = (fst g1 + fst g2, snd g1 + snd g2)
let glxmul s g2 = (s * fst g2, s * snd g2)
let expGlx n g1 g0 = glxmul n (glxdiff g1 g0)

let task2 num lol =
  let glxsWitexp0 = getGlxs 0 lol
  and glxsWitexp1 = getGlxs 1 lol
  and expand g1 g0 = glxsum g0 (expGlx num g1 g0) in
  let galaxies = List.map2 expand glxsWitexp1 glxsWitexp0 in
  Utilities.accumulateSum @@ listOfDist galaxies
