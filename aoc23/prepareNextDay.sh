#!/bin/bash

#crappy script for crating the next day
day=$1
libname=$2
#input
touch "day${day}"
#bin
touch "bin/day${day}.ml"
cat <<EOF >> bin/dune

(executable
 (public_name aoc23_${day})
 (name day${day})
 (modules day${day})
 (libraries $libname))
EOF
#test
touch "test/test_aoc23_${day}.ml"
cat <<EOF >> test/dune

(test
 (name test_aoc23_${day})
 (modules test_aoc23_${day})
 (libraries alcotest $libname))
EOF
#lib
touch "lib/${libname}.ml"
cat <<EOF >> lib/dune

(library
 (name ${libname})
 (modules ${libname}))
EOF
