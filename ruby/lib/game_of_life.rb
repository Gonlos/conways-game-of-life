module GameOfLife
  def self.get_generation(cells, generations = 1)
    return cells if generations <= 0

    cells_with_bounds = add_borders(cells)
    next_cells_with_bounds = next_generation(cells_with_bounds)
    next_cells = clean_borders(next_cells_with_bounds)

    get_generation(next_cells,generations - 1)
  end

  def self.add_borders(cells)
    up_down = []
    width = cells.first.count + 2
    width.times{up_down << 0}

    new_cells = cells.map do |row|
      row.insert(0,0).push(0)
    end

    new_cells.insert(0,up_down).push(up_down)
  end

  def self.next_generation(cells)
    nex_generation=[]

    cells.each_with_index do |row,row_index|
      nex_generation << []
      row.each_with_index do |_cell,col_index|
        if must_life?(cells,row_index,col_index)
          nex_generation[row_index] << 1
        else
          nex_generation[row_index] << 0
        end
      end
    end

    nex_generation
  end

  def self.clean_borders(cells)
    cells.shift while cells.first.reduce(:+) == 0
    cells.pop while cells.last.reduce(:+) == 0

    min = cells.first.count
    max = 0

    cells.each do |row|
      min_temp = row.find_index(1)
      max_temp = row.rindex(1)
      min = min_temp if min_temp && min_temp <  min
      max = max_temp if max_temp && max_temp > max
    end

    cells.map do |row|
      row.slice(min, max - min + 1)
    end
  end

  def self.must_life?(cells,row,collumn)
    num = neigthbours(cells,row,collumn)

    case num
    when 2
      cells[row][collumn] == 1
    when 3
      true
    else
      false
    end
  end

  def self.neigthbours(cells,row,collumn)
    row_min = (row > 0)? row - 1 : 0
    row_max = (row < cells.count-1)?row + 1: cells.count-1
    col_min = (collumn > 0)? collumn - 1 : 0
    col_max = (collumn < cells.first.count-1)?collumn + 1 : cells.first.count-1
    count = 0

    (row_min..row_max).each do |ro|
      (col_min..col_max).each do |col|
        count = count + cells[ro][col]
      end
    end

    count - cells[row][collumn]
  end
end
