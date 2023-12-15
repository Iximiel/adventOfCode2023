let integrate time speed = time * speed

(* speed = time button pressed, hence lost time *)
let racewin tottime distance speed =
  integrate (tottime - speed) speed > distance

let findFirstWin totalTime maxDist =
  let winning = racewin totalTime maxDist in
  let i = ref 0 in
  while not (winning !i) do
    i := !i + 1
  done;
  !i

let findLastWin totalTime maxDist =
  let winning = racewin totalTime maxDist in
  let i = ref totalTime in
  while not (winning !i) do
    i := !i - 1
  done;
  !i

let racePossibilities time distancetobeat =
  1 + findLastWin time distancetobeat - findFirstWin time distancetobeat
