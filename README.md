# Conway's Game of Life Kata

Let's go to make a kata about the [Conway's Game of Life](https://en.wikipedia.org/wiki/Conway%27s_Game_of_Life) based the codewars kata [Conway's Game of Life - Unlimited Edition](https://www.codewars.com/kata/conways-game-of-life-unlimited-edition/train/javascript). We must make a method that receives a grid array with the cells and a number of generations and returns another grid array cropped around all of the living cells before the generations.

## Rules

The universe of the Game of Life is an infinite, two-dimensional orthogonal grid of square cells, each of which is in one of two possible states, alive or dead, (or populated and unpopulated, respectively). Every cell interacts with its eight neighbours, which are the cells that are horizontally, vertically, or diagonally adjacent. At each step in time, the following transitions occur:

1. Any live cell with fewer than two live neighbours dies, as if by underpopulation.
1. Any live cell with two or three live neighbours lives on to the next generation.
1. Any live cell with more than three live neighbours dies, as if by overpopulation.
1. Any dead cell with exactly three live neighbours becomes a live cell, as if by reproduction.

The initial pattern constitutes the seed of the system. The first generation is created by applying the above rules simultaneously to every cell in the seed; births and deaths occur simultaneously, and the discrete moment at which this happens is sometimes called a tick. Each generation is a pure function of the preceding one. The rules continue to be applied repeatedly to create further generations.

Given a 2D array and a number of generations, compute n timesteps of Conway's Game of Life.
