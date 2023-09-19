require_relative 'person'
require 'json'
class Teacher < Person
  attr_accessor :specialization

  def initialize(age, specialization, name = 'Unknown')
    super(age, name)
    @specialization = specialization
  end

  def can_use_services?
    true
  end

  def self.json_create(string)
    # Use a regular expression to extract the attributes and values from the string
    /<Teacher:(\d+) name:(.*), age:(\d+), specialization:(.*)>/ =~ string

    # Create a new instance of the class with the extracted values
    new($2, $3.to_i, $4)
  end
end
