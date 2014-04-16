#!/usr/bin/env ruby
class Field
  attr_accessor :field

  def create_game_field
    self.field = Array.new(5){ Array.new(5) {"2"}}
  end

  def to_s
    self.field.map { |row| row.join }.join("\n")
  end
end

field = Field.new
field.create_game_field
puts field
