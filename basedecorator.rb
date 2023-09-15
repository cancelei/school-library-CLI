# Prepare base Decorator
# Make sure that it inherits from Nameable.
# In the constructor assign a nameable object from params to an instance variable.
# Implement the correct_name method that returns the result of the correct_name method of the @nameable.
require_relative 'nameable'

class BaseDecorator < Nameable
  @correct_name
  def initialize(nameable)
    @nameable = nameable
  end

  def correct_name
    @nameable.correct_name
  end
end