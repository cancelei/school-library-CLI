# test.rb
class Sample
  def initialize(name, age)
    @name = name
    @age = age
  end

  def display
    puts "Name: #{@name}"
    puts "Age: #{@age}"
  end
end

person = Sample.new('John', 30)
person.display
