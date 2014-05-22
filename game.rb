#!/usr/bin/env ruby
class Field
  attr_accessor :field_columns, :up, :right, :down, :left

  def initialize
    self.field_columns = Array.new(4){ Array.new(4){" "}}
    self.up, self.right, self.down, self.left = "w", "d", "s", "a"
  end

  def spawn_random_number
    numbers = [2, 2, 4, 2, 4, 2, 2].shuffle
    spawn_numbers = [1, 2, 3, 0, 1, 2, 3, 0, 1, 2, 3, 0].shuffle
    x_rand, y_rand = spawn_numbers[rand(12)], spawn_numbers[rand(12)]
    if self.field_columns[x_rand][y_rand] == " "
      self.field_columns[x_rand][y_rand] = numbers[rand(5)]
    else
      spawn_random_number
    end
  end

  def compare_fields(check_array,x, y)
    if check_array[y] == nil
      return {1 => "break", 2 => check_array}
    elsif check_array[y] == " "
      return {1 => "redo", 2 => check_array}
    elsif check_array[x] == check_array[y]
      check_array[x] += check_array[y]
      check_array[y] = " "
      return {1 => "break", 2 => check_array}
    elsif check_array[y].integer? && check_array[x] == " "
      check_array[x], check_array[y] = check_array[y], " "
      return {1 => "redo", 2 => check_array}
    end
  end

  def check_neigbour_number(check_array, x, x_dir)
    puts "-------"
    p check_array
    puts "-------"
    z, i = x_dir, 0
    while i < check_array.length do
      y = x
      while true do
        y += x_dir
        wh_nex = compare_fields(check_array, x, y)
        if wh_nex[1] == "redo"
          check_array = wh_nex[2]
          redo
        else
          check_array = wh_nex[2]
          break
        end
      end
      x += x_dir
      z += x_dir
      i += 1
    end
    p check_array
  end

  def move_direction(start)
    self.field_columns.each do |row|
      p row
      case start
        when("left")
          check_neigbour_number(row, 0, 1)
        when("right")
          check_neigbour_number(row.reverse, 0, 1)
      end
    end
  end

  def choose_direction
  next_step = gets.chomp
    case next_step
      when self.up
        move_direction("up")
      when self.right
        move_direction("right")
      when self.down
        move_direction("up")
      when self.left
        move_direction("left")
      else
        puts self + "Nothing defined, repeat:"
        choose_direction
    end
  end

  def to_s
    self.field_columns.map { |row| row.join("|") }.join("|\n") + "|"
  end
end

@field = Field.new
i = 0
while i < 100 do
  @field.spawn_random_number
  puts @field
  print "Input:"
  @field.choose_direction
  i += 1
end
