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
    date = hash.fetch('date') # get the values from the hash by their keys
    person = hash.fetch('person')
    book = hash.fetch('book')
    obj_person = Teacher.new(person['age'], person['name'], person['id'], person['specialization'])
    obj_book = Book.new(book['title'], book['author'])
    #puts obj_person.to_s
    puts person
    #puts book.to_s
    rental = new(date, obj_person, obj_book)
    rental
  end
end
