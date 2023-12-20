# My take on the Advent of Code 2023

This is my try to partecipate at the advent of code 2023.

I can define myself a C++ dev, (sometimes I also do some Python), so I am using Ocaml :smile:
:camel:

Let's see if I can learn something

While doing day3 I'm starting to think that I am using a bit too much regex.

At day 5 i decide to move everithing in a single project, this may be a bad idea, fut I think I can reutilize some code with no repetition

At some point I decide to write a statement before task1, after task1 and after task2 , and sometime before task2, making this a sort of diary, enjoy

I am quite happy: if I go at this rate I may solve all the puzzle before the next year edition (lol).

## Day 1
My solution was to regex all the problems away.
Ocaml makes finding regex quite easy (apart thata strange  way or declaring raw strings`{||}`)
s
## Day 2
Task 1 is simply a game of elaborating the text and check if the game is valid (meaning if the number of cubes extracted per color respects the game).

For task 2 you use the parser of task1 t get the varios extractions per game, then you max the highest count of red, blue and green for each game and multiply the triplette.

## Day 3
I solved task 1 by loooking if any number is adiacent to any symbol, I don't like it, because is a bit too clunky and not clear enough.

For task 2 instead, I seached for the `*` and looked if they have exactly 2 adiacent number, by looking the 8 charaters around them and the expandin the string in the direction of the numbers until i do not fine any more digit, then I regex the number ot of the found substrings. I should have used this solutio also for task1, I think it may be more clear

## Day 4

Input looks easier, maybe this time no regex

Day 4 task 1 was far mor easier than day3, no need to explain, the task description is how the program works :smile:

Task2 was complex until i read how to increment the head of a list , then it got worse until I stopped using the calculated winning of task 1 as match...

I did also a beautiful refactor of task 1

## Day 5

Day 5 looks like is a nested decodification sequence, I think the only long thing will be preparing the input
It took more than I tough for task1

for task2 the organizer wants me to learn tail recursion to avoid a stack overflow (the error, not the site)

It's the least efficient solution, but hey is there :smile: let's gooo

## Day 6

Toh! A minimization (maximization) problem, I love minimization problem, I'll have to learn minimization problems on Ocaml...

I think I bruteforced it, I started to be elegant and then i recovered to something like this...

Task 2 was easier than expected, wow, this means that I didn't see the most obvious solution for task 1 ?

## Day 7

Ok, I need to set order, for the cards and then recognise patterns

I must have put a bug in the test, because the aswer is wrong...
Ok, I can't lookuptable... task 1 done, I should concentrate tests on edge cases next times

I lookuptable'd task2, brute frce solutions are best solutions xD (until someone expands the pool, but they make you feel clever)

## Day 8

This looks like a tree to me (or a complexer graph?)

I think i learned how to make the map?
I did not commit the win of task1, this day looks easier (or I've been too imperative?)

Bruteforcing task2 must not be a good idea, I cheated a bit, on reddit I read that someone has tried the mcm, this may work if the paths loop without overlapping, meaning that each start has ONLY one end.
I'll try to resolve it by assuming, instead of verifyin, because I am lazy tha the paths do not overlap,

I did a wrong assumption on the smallest divisor for the mcm, and i ended up wrogning a bit.

In the end while i was woking on the mcm the bruteforece is still working... well that's a lesson

# Day 9

Looks like task 1 is fully explained by their description, it may be so that task 2 will be too difficult?

Let's play with triangles, hoping this do not become a fibonacci-like thing in task2...

Task 1 was simple, but i feel I've been walk-trough'd by the puzzle writers....

I have set up task 1 functions to be flexible in away that seems different from what is needed for task2...

O.o

I did it, in few minutes...

Looks like this puzzle has written FUNCTIONAL on it... :smile:, actually is all about string manipulations

I just removed a List.rev from the toolchain and inverted a number...

## Day10

Double digit, finally

I never touched anything similar in my previos work (or maybe that time on counting clusters), but now is time to sleep.
To me, looks like a sort of pathfinding algorithm, I might have to read someting, fortunately there ar no three or four way junctions.
So I'll have to make only two walkers

I'm working with the hope that the goodwill of the puzzlemaker did not create tubes that are going outside

Task1 done, simply making 2 walker go intoeach other did the trick, now i have to calculate THE AREA

(but before a little refaftor to make the thing more functional)

Task 2 was blocking for me:
3 days to come up to Green's integrals and a evebing to peek solution and get to this Pick's theorem correctio, I am a mess..
I wanted to floodfill, then the algorithm looked to me rather boring to implement (not because is borign, but because in ocaml looked to me too long)

## Day11

A map of the sky to be modified and then searching for the shortest path between point in it
I think that I may use the manhattan  distance, at least for task 1, and hope that it will work for task 2

Manatthan distance was the way :smile:, at leas one fast after day10 :sad:

Task2 is too easy, could be a matter of a simple refactor?
Ok, no simple refactor I need to be more clever and efficient
maybe is just matter of seing how much the distances change with expansion and extrapolate

I simply calculate the difference between expasion1 and expansion 0 for each galaxy and added that number to the coordinates, multiplied by 1000000-1... the -1 made me fail the tests and block my self on a non-problem yay

I wonder if I should make the repo private for the sake of my cv... :laugh: