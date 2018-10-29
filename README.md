This is the Sudoku generator developed in Ruby.

To generate a Sudoku puzzle, I develop a function that generates a complete
Sudoku filled with number from 1 to 9.

To prove that the complete Sudoku is correct, I develop a test that verifies
the conformity of this Sudoku.

Then I remove randomly 64 numbers, the rest is a Sudoku puzzle.

I also provide a function to print the puzzle in html format that has borders.

Clone this file from here:
https://github.com/thucdat/Sudoku-puzzle-generator/

There is only one file: sudokugenerator.rb.

At the end of this file, there is a sample execution which produces the presentation
of the Sudoku puzzle.

Future enhancement includes a Sudoku solver that reuses part of the function generate_sudoku_puzzle,
much more impressive is a show how the puzzle is solved directly on the html table.

Indeed, the function generate_sudoku_puzzle can generate randomly any Sudoku puzzle, the number of
the square to be filled can also be varied to increase the level of difficulty.
