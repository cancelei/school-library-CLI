class Rental
  attr_accessor :date, :person, :book

  def initialize(date, person, book)
    @date = date
    @person = person
    person.rentals << self

    @book = book
    # *The rental is adding itself to the @book achieving the 'belongs-to' association
    book.rentals << self
  end

  def self.json_create(hash)
    date = hash.fetch("date") # get the values from the hash by their keys
    person = hash.fetch("person")
    book = hash.fetch("book")
    rental=new(date, person, book)
    rental
  end
end
