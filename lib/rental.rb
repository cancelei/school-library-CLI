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
    obj_person = if person.key?('specialization')
                   Teacher.new(person['age'], person['specialization'], person['name'], person['id'])
                 else
                   Student.new(person['age'], person['name'], person['id'],
                               parent_permission: person['parent_permission'])
                 end
    obj_book = Book.new(book['title'], book['author'])
    new(date, obj_person, obj_book)
  end
end
