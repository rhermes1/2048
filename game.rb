#!/usr/bin/env ruby
class Field
  attr_accessor :field_columns, :up, :right, :down, :left

  def initialize
    self.field_columns = Array.new(4){ Array.new(4){nil}}
    self.up, self.right, self.down, self.left = "w", "d", "s", "a"
  end

  def spawn_random_number
    numbers = [2, 2, 4, 2, 4, 2, 2].shuffle
    spawn_numbers = [1, 2, 3, 0, 1, 2, 3, 0, 1, 2, 3, 0].shuffle
    x_rand, y_rand = spawn_numbers[rand(12)], spawn_numbers[rand(12)]
    if self.field_columns[x_rand][y_rand] == nil
      self.field_columns[x_rand][y_rand] = numbers[rand(5)]
    else
      spawn_random_number
    end
  end

  def move_direction
  next_step = gets.chomp
    case next_step
      when self.up
        puts "up"
      when self.right
        puts "right"
      when self.down
        puts "down"
      when self.left
        puts "left"
      else
        system("clear")
        puts self
        puts "Nothing defined, repeat:"
        move_direction
    end
  end

  def to_s
    self.field_columns.map { |row| row.join }.join("\n")
  end

end

@field = Field.new
i = 0
while i < 8 do
  @field.spawn_random_number
  system("clear")
  puts @field
  print "Input:"
  @field.move_direction
  i += 1
end
