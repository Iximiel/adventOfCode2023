# My take on the Advent of Code 2023

This is my try to partecipate at the advent of code 2023.

I can define myself a C++ dev, (sometimes I also do some Python), so I am using Ocaml :smile:
:camel:

Let's see if I can learn something

Day 1 is on my other PC (I decided later to set up a git repo), I'll add it hera as soon I go back home

While doing day3 I'm starting to think that I am using a bit too much regex.
## Day 1
## Day 2
Task 1 is simply a game of elaborating the text and check if the game is valid (meaning if the number of cubes extracted per color respects the game).

For task 2 you use the parser of task1 t get the varios extractions per game, then you max the highest count of red, blue and green for each game and multiply the triplette.

## Day 3
I solved task 1 by loooking if any number is adiacent to any symbol, I don't like it, because is a bit too clunky and not clear enough.

For task 2 instead, I seached for the `*` and looked if they have exactly 2 adiacent number, by looking the 8 charaters around them and the expandin the string in the direction of the numbers until i do not fine any more digit, then I regex the number ot of the found substrings. I should have used this solutio also for task1, I think it may be more clear

## Day 4

Input looks easier, maybe this time no regex

Day 4 task 1 was far mor easier than day3, no need to explain, the task description is how the program works :smile: