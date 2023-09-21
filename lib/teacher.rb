require_relative 'person'
require 'json'
class Teacher < Person
  attr_accessor :specialization

  def initialize(age, specialization, name = 'Unknown', id = nil)
    super(age, name, id)
    @specialization = specialization
  end

  def can_use_services?
    true
  end

  def self.json_create(hash)
    name = hash.fetch('name', 'Unknown') # get the values from the hash by their keys
    id = hash.fetch('id', 0)
    age = hash.fetch('age', 0)
    specialization = hash.fetch('specialization', 'None')
    # Create a new instance of the class
    teacher = new(age, specialization, name = name, id = id)
    books = hash.fetch('books')
    rentals = hash.fetch('rentals')
    teacher.books = books
    teacher.rentals = rentals
    teacher
  end
end
