# Rovers just for "fun"ctional programming

## Rule of the game
A squad of robotic rovers are to be landed on a plateau. This plateau, which is curiously rectangular, must be navigated by the rovers so that their on-board cameras can get a complete view of the surrounding terrain to send back to Earth.

A rover's position and location is represented by a combination of x and y co-ordinates and a letter representing one of the four cardinal compass points. The plateau is divided up into a grid to simplify navigation. An example position might be 0, 0, N, which means the rover is in the bottom left corner and facing North.

In order to control a rover, it sends a simple string of letters. The possible letters are 'L', 'R' and 'M'. 'L' and 'R' makes the rover spin 90 degrees left or right respectively, without moving from its current spot. 'M' means move forward one grid point, and maintain the same heading. Assume that the square directly North from (x, y) is (x, y+1).

INPUT
* The first line of input is the upper-right coordinates of the plateau, the lower-left coordinates are assumed to be 0,0.
* The rest of the input is information pertaining to the rovers that have been deployed. Each rover has two lines of input. The first line gives the rover's position, and the second line is a series of instructions telling the rover how to explore the plateau.
* The position is made up of two integers and a letter separated by spaces, corresponding to the x and y co-ordinates and the rover's orientation.
* Each rover will be finished sequentially, which means that the second rover won't start to move until the first one has finished moving.

OUTPUT

The output for each rover should be its final co-ordinates and heading.

INPUT AND OUTPUT

Test Input:

5 5

1 2 N

LMLMLMLMM

3 3 E

MMRMMRMRRM

Expected Output:

1 3 N

5 1 E

## Simple libraries used
* interpolate - similar to Scala's string interpolation by using `QuasiQuotes` pragma.
* hspecs, QuickCheck

## Assumption
* If the command `M` will move the rover out of the plateau, the rover will stay on the same spot with the same heading.
* To make the solution slighly simpler, if the command `M` will move the rover to a spot already occupied by another rover, it will continue to move.  Therefore assumes the input file will provide appropriate commands to avoid "crashing".

## How to run
After building the executable, run it by passing the name of the command file.
```Haskell
stack exec rovers-exe -- src/resources/commandFile.txt 
(1, 3) N
(5, 1) E
(7, 4) E
```
```Haskell
stack exec rovers-exe -- test/resources/OutOfPlateau.txt
(3, 6) not within (0, 0) to (5, 5)
```

## Unit-test
```Haskell
stack build rovers:test:rovers-test
```

## Addtional thing to be done
Avoid crashing.