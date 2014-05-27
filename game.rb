#!/usr/bin/env ruby
class Field
  attr_accessor :field_columns, :up, :right, :down, :left

  def initialize
    self.field_columns = Array.new(4){ Array.new(4){" "}}
    self.up, self.right, self.down, self.left = "w", "d", "s", "a"
  end

  def output
    system("clear")
    puts self
    puts "(#{self.up})up|(#{self.left})left|"+
      "(#{self.down})down|(#{self.right})right"
    print "Input:"
  end

  def spawn_random_number(count)
    numbers = [2, 2, 4, 2, 4, 2, 2].shuffle
    spawn_numbers = [1, 2, 3, 0, 1, 2, 3, 0, 1, 2, 3, 0].shuffle
    x_rand, y_rand = spawn_numbers[rand(12)], spawn_numbers[rand(12)]
    if self.field_columns[x_rand][y_rand] == " "
      count = 0
      self.field_columns[x_rand][y_rand] = numbers[rand(5)]
    else
      if count < 16
        spawn_random_number(count+1)
      end
    end
  end

  def compare_fields(check_array, x, x1, y, y1)
    puts "Feld #{check_array[x][y]} mit #{check_array[x1][y1]}"
    if check_array[x1][y1] == nil
      return {1 => "break", 2 => check_array}
    elsif check_array[x1][y1] == " "
      return {1 => "redo", 2 => check_array}
    elsif check_array[x][y] == check_array[x1][y1]
      check_array[x][y] += check_array[x1][y1]
      check_array[x1][y1] = " "
      return {1 => "break", 2 => check_array}
    elsif check_array[x1][y1].integer? && check_array[x][y] == " "
      check_array[x][y], check_array[x1][y1] = check_array[x1][y1], " "
      return {1 => "redo", 2 => check_array}
    end
    return {1 => "break", 2 => check_array}
  end

  # fd = first_dimension = x | sd = second_dimension = y
  def check_neigbour_number(check_array, fd, sd, fd_dir, sd_dir, direction)
    i = 0
    while i < self.field_columns.first.length do
      x, x1 = fd, sd
      while true do
        y, y1 = x+fd_dir, x1+sd_dir
      puts "Vergleich X:#{x} Y:#{y} X1:#{x1} Y1:#{y1}"
        break if (x1 < 0) || (y1 < 0) || (x1 > self.field_columns.length) ||
          (x1 > self.field_columns.length)
        wh_nex = compare_fields(check_array, x, x1, y, y1)
        if wh_nex[1] == "redo"
          check_array = wh_nex[2]
          redo
        else
          check_array = wh_nex[2]
          break
        end
      end
      x += direction
      y += sd_dir
      i += 1
    end
    return check_array
  end

  def choose_direction
  next_step = gets.chomp
    case next_step
      when self.up
      when self.right
      when self.down
      when self.left
        check_neigbour_number(self.field_columns, 0, 0, 0, 1, 1)
      else
        output
        choose_direction
    end
  end

  def column
    "-+" * self.field_columns.length
  end

  def to_s
    column + "\n" + self.field_columns.map { |row| row.join("+")}.join("|\n") +
      "|\n" + column
  end
end


@field = Field.new
i = true
while i == true do
  i = true
  @field.spawn_random_number(0)
  @field.output
  puts i
  @field.choose_direction
end
