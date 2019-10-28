# frozen_string_literal: true

class GameOfLife
  class << self
    # [[0, 1, 0], [0, 1, 0], [0, 1, 0]]
    #  0 0 0    0 1 0
    #  0 1 0 -> 0 1 0 -> [[1, 1, 1]]
    #  0 0 0    0 0 0
    def get_generation(cells, generations = 1)
      game_of_life = new(cells, generations)
      generations.times { game_of_life.generation }

      game_of_life.cells
    end
  end

  DEAD  = 0
  ALIVE = 1

  attr_accessor :cells

  def initialize(cells, generations)
    @cells = cells
    @generations = generations
  end

  def generation
    add_extra_circunference # Because the board is infinite

    @cells = @cells.each_with_index.map do |row, row_index|
      row.each_with_index.map do |cell, cell_index|
        neighboors = neighboors_of(row_index, cell_index)
        live_cells = neighboors.count { |neighboor| alive?(neighboor) }

        if alive?(cell)
          live_cells < 2 || live_cells > 3 ? DEAD : ALIVE
        else
          live_cells == 3 ? ALIVE : DEAD
        end
      end
    end

    clean_up
  end

  ## Human readable representation to use in console
  # . . . . . . . . .
  # . * * . . . . . .
  # . . . . . . . . .
  # . * . . * . . . .
  # . . . . * . * * .
  # . . . * . . . * .
  # . . . . * * * . .
  # . . . . . * . . .
  def to_s(cells = @cells)
    result = ''
    cells.each do |row|
      result += "\n"
      row.each do |cell|
        result += " #{alive?(cell) ? '*' : '.'}"
      end
    end

    result
  end

  ## Add extra empty rows around the initial board, aka new circunference
  # This is done because we are in a scenario of a infinite board and in the
  # process of calculating a generation cells may come to life outside the
  # given board
  def add_extra_circunference
    @cells.map! do |row|
      [0] + row + [0]
    end

    new_empty_row = Array.new(@cells.first.size, 0)
    @cells.unshift(new_empty_row)
    @cells.push(new_empty_row)

    ## Update max values from previous generations
    max_row_pos! && max_cell_pos!
  end

  ## Removes empty rows
  # A row is considered empty when it only contains 0s
  # either horizontal or vertical
  def clean_up
    # Remove empty all horizontal lines that only contains 0s
    # At the start
    @cells.slice!(0) while @cells.first.all?(&:zero?)
    # At the end
    @cells.pop(1) while @cells.last.all?(&:zero?)

    # Every first element is zero (checking first column)
    @cells.map! { |row| row.drop(1) } while @cells.all? { |row| row.first.zero? }

    # Every last element is zero (checking last column)
    @cells.map! { |row| row.pop(1) && row } while @cells.all? { |row| row.last.zero? }

    @cells
  end

  def neighboors_of(row, cell)
    neighboors = []
    if row.positive?
      neighboors.push(@cells[row - 1][cell - 1]) if cell.positive?
      neighboors.push(@cells[row - 1][cell + 1]) if cell < max_cell_pos
      neighboors.push(@cells[row - 1][cell])
    end

    if cell.positive?
      neighboors.push(@cells[row][cell - 1])
      neighboors.push(@cells[row + 1][cell - 1]) if row < max_row_pos
    end

    if cell < max_cell_pos
      neighboors.push(@cells[row][cell + 1])
      neighboors.push(@cells[row + 1][cell + 1]) if row < max_row_pos
    end

    neighboors.push(@cells[row + 1][cell]) if row < max_row_pos

    neighboors
  end

  def alive?(cell)
    cell == ALIVE
  end

  def max_row_pos!
    @max_row_pos = @cells.size - 1
  end

  def max_cell_pos!
    @max_cell_pos = @cells.first.size - 1
  end

  def max_row_pos
    @max_row_pos || max_row_pos!
  end

  def max_cell_pos
    @max_cell_pos || max_cell_pos!
  end
end
