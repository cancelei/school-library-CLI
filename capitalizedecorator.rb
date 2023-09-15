# Create a class that inherits from the base Decorator class.
# Implement a method correct_name that capitalizes the output of @nameable.correct_name.
require_relative 'basedecorator'

class CapitalizeDecorator < BaseDecorator
  def correct_name
    @nameable.correct_name.capitalize
  end
end
