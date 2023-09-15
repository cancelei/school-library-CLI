# Create a class that inherits from the base Decorator class.
# Implement a method correct_name that makes sure that the output of @nameable.correct_name has a maximum of 10 characters. If it's longer it should trim the word.
require_relative 'basedecorator'

class TrimDecorator < BaseDecorator
  def correct_name
    @nameable.correct_name[0..9]
  end
end