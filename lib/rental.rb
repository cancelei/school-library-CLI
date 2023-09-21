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
    if person.key?('specialization')
      obj_person = Teacher.new(person['age'], person['specialization'], name = person['name'], id = person['id'])
    else
      obj_person = Student.new(person['age'], name = person['name'], id = person['id'], parent_permission: person['parent_permission'])
    end
    obj_book = Book.new(book['title'], book['author'])
    new(date, obj_person, obj_book)
  end
end
