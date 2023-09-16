require_relative 'nameable'
require_relative 'basedecorator'
require_relative 'trimmerdecorator'
require_relative 'capitalizedecorator'

class Person < Nameable
  attr_accessor :name, :age, :books
  attr_reader :id

  def initialize(age, name = 'Unknown', parent_permission: true)
    super()
    @id = Random.rand(1..1000)
    @age = age
    @name = name
    @parent_permission = parent_permission
    @books = []
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

  def add_book(book)
    @books << book
    book.person = self
  end
end

person = Person.new(22, 'maximilianus')
person.correct_name
capitalized_person = CapitalizeDecorator.new(person)
puts capitalized_person.correct_name
capitalized_trimmed_person = TrimDecorator.new(capitalized_person)
puts capitalized_trimmed_person.correct_name
