class Person
  attr_reader :id
  attr_accessor :name, :age

  def initialize(id, name = "Unknown", age = 0)
    @id = id
    @name = name
    @age = age
  end

  def of_age?
    @age >= 18
  end

  def can_use_services?
    of_age? || @parent_permission
  end
end