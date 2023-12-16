# My take on the Advent of Code 2023

This is my try to partecipate at the advent of code 2023.

I can define myself a C++ dev, (sometimes I also do some Python), so I am using Ocaml :smile:
:camel:

Let's see if I can learn something

While doing day3 I'm starting to think that I am using a bit too much regex.

At day 5 i decide to move everithing in a single project, this may be a bad idea, fut I think I can reutilize some code with no repetition

At some point I decide to write a statement before task1, after task1 and after task2 , and sometime before task2, making this a sort of diary, enjoy

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
