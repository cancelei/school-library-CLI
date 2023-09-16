require_relative 'person'

class Book
  attr_accessor :title, :person

  def initialize(title, person)
    @title = title
    person.books << self
  end
end

# person = Person.new('Max')
# book = Book.new('Harry Potter', 'J.K. Rowling')
# person.add_book(book)
# puts person.books[0].title
# puts book.person.name
