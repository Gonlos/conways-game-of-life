#This is a unrefactored version of the Conway Game of Life.

require 'pry'

class Cell
  def initialize(alive: false)
    @alive = alive
  end

  def alive?
    @alive
  end

  def dead?
    !@alive
  end
end

class GameOfLife
  class << self
    def get_generation(cells, generations = 1)
      parsed_cells = input_parser(cells)
      last_gen = parsed_cells
      1.upto(generations).each do |_gen|
        last_gen_with_borders = generation(last_gen)
        last_gen = clean_borders(last_gen_with_borders)
      end
      output_parser(last_gen)
    end

    def generation(cells)
      cells_with_zero_borders = add_borders(cells)
      cells_with_zero_borders.each_with_index.map do |row, row_index|
        row.each_with_index.map do |cell, column_index|
          living_neigh = living_neighboours(cells_with_zero_borders, row_index, column_index)
          if cell.alive? && (living_neigh < 2 || living_neigh > 3)
            Cell.new
          elsif cell.dead? && living_neigh == 3
            Cell.new(alive: true)
          else
            cell
          end
        end
      end
    end

    def input_parser(cells)
      cells.map do |row|
        row.map { |int_cell| Cell.new(alive: int_cell == 1) }
      end
    end

    def output_parser(cells)
      cells.map do |row|
        row.map { |cell| cell.alive? ? 1 : 0 }
      end
      # cells_as_int.reject { |row| row.all?(&:zero?) }
    end

    def living_neighboours(cells, x_pos, y_pos)
      count = 0
      row_start = x_pos.zero? ? 0 : x_pos - 1
      column_start = y_pos.zero? ? 0 : y_pos - 1
      row_end = x_pos == (cells.size - 1) ? cells.size - 1 : x_pos + 1
      column_end = y_pos == (cells[0].size - 1) ? cells[0].size - 1 : y_pos + 1
      cells[row_start..row_end].each do |row|
        row[column_start..column_end].each do |cell|
          count += 1 if cell && cell.alive?
        end
      end
      count -= 1 if cells[x_pos][y_pos].alive?
      count
    end

    def add_borders(cells)
      columns = cells[0].size
      empty_line = Array.new(columns + 2, Cell.new)
      empty_columns_cells = cells.map { |row| [Cell.new] + row + [Cell.new] }
      [empty_line] + empty_columns_cells + [empty_line]
    end

    def clean_borders(cells)
      rows_cutted = clean_rows(cells)
      clean_columns(rows_cutted)
    end

    def clean_rows(cells)
      result = cells.dup
      result.shift while result.first.all?(&:dead?)
      result.pop while result.last.all?(&:dead?)
      result
    end

    def clean_columns(cells)
      result = cells.dup
      result.each(&:shift) while result.map(&:first).all?(&:dead?)
      result.each(&:pop) while result.map(&:last).all?(&:dead?)
      result
    end
  end
end
