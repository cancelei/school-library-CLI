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
