require_relative 'person'

class Book
  # *Getters and Setters for @rentals should be present
  attr_accessor :title, :author, :rentals

  def initialize(title, author)
    @title = title
    @author = author
    @rentals = []
  end

  # *A method for adding rentals should be present. Link to the example in a previous lesson: https://github.com/microverseinc/curriculum-ruby/blob/main/oop/articles/oop_relationships_by_examples.md#many-to-many-relationship
  def add_rental(person, date)
    # *the book itself should be sent as a parameter to create the new rental achieving the 'has-many' association.
    Rental.new(date, self, person)
  end
  
  def self.json_create(string)
    # Use a regular expression to extract the attributes and values from the string
    /<Book:(\d+) title:(.*), author:(.*), rentals:(.*)>/ =~ string

    # Create a new instance of the class with the extracted values
    book = new($2, $3)

    # Parse the rentals array from the string and create rental objects
    rentals = JSON.parse($4)
    rentals.each do |rental|
      book.add_rental(Person.json_create(rental["person"]), rental["date"])
    end

    # Return the book object
    book
  end
end
