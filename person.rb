# Turn your Person class to Nameable
# Make sure that your Person class inherits from Nameable
# Make sure that this class has a method correct_name implemented. It should simply return the name attribute.
# Prepare base Decorator

require_relative 'nameable'
require_relative 'basedecorator'
require_relative 'trimmerdecorator'
require_relative 'capitalizedecorator'

class Person < Nameable
  attr_accessor :name, :age
  attr_reader :id

  def initialize(age, name = 'Unknown', parent_permission: true)
    @id = Random.rand(1..1000)
    @age = age
    @name = name
    @parent_permission = parent_permission
  end

  def can_use_services?
    of_age? || @parent_permission
  end

  # implement a method correct_name. It should simply return the name attribute.
  def correct_name
    @name
  end

  private

  def of_age?
    @age >= 18
  end
end

person = Person.new(22, 'maximilianus')
person.correct_name
capitalized_person = CapitalizeDecorator.new(person)
puts capitalized_person.correct_name
capitalized_trimmed_person = TrimDecorator.new(capitalized_person)
puts capitalized_trimmed_person.correct_name