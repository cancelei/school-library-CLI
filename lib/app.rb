require_relative 'book'
require_relative 'person'
require_relative 'rental'
require_relative 'student'
require_relative 'teacher'

class App
  def initialize
    @books = []
    @people = []
    @rentals = []
  end

  def list_all_books
    if @books.empty?
      puts 'No books available.'
    else
      @books.each { |book| puts "Title: #{book.title}, Author: #{book.author}" }
    end
  end

  def list_all_people
    if @people.empty?
      puts 'No people added.'
    else
      @people.each { |person| puts "ID: #{person.id}, Name: #{person.name}" }
    end
  end

  def create_person
    print 'Do you want to create a student (1) or a teacher (2)? [Input the number]: '
    choice = gets.chomp

    case choice
    when '1'
      create_student
    when '2'
      create_teacher
    else
      puts 'Invalid option.'
    end
  end

  def create_student
    print 'Age: '
    age = Integer(gets.chomp)
    raise 'Age should be positive.' if age <= 0

    print 'Name: '
    name = gets.chomp.strip
    raise 'Name cannot be empty.' if name.empty?

    print 'Has parent permission? [Y/N]: '
    parent_permission_input = gets.chomp.downcase
    raise 'Invalid input. Choose Y or N.' unless %w[y n].include?(parent_permission_input)

    parent_permission = parent_permission_input == 'y'

    student = Student.new(age, name, parent_permission: parent_permission)
    @people << student
    puts 'Student created successfully!'
  rescue StandardError => e
    puts "Error: #{e.message}"
    retry
  end

  def create_teacher
    print 'Age: '
    age = Integer(gets.chomp)
    raise 'Age should be positive.' if age <= 0

    print 'Name: '
    name = gets.chomp.strip
    raise 'Name cannot be empty.' if name.empty?

    print 'Specialization: '
    specialization = gets.chomp.strip
    raise 'Specialization cannot be empty.' if specialization.empty?

    teacher = Teacher.new(age, specialization, name)
    @people << teacher
    puts 'Teacher created successfully!'
  rescue StandardError => e
    puts "Error: #{e.message}"
    retry
  end

  def create_book
    print 'Title: '
    title = gets.chomp
    raise 'Title cannot be empty.' if title.empty?

    print 'Author: '
    author = gets.chomp
    raise 'Author cannot be empty.' if author.empty?

    book = Book.new(title, author)
    @books << book
    puts 'Book created successfully!'
  rescue StandardError => e
    puts "Error: #{e.message}"
    retry
  end

  def create_rental
    puts 'Select a book from the following list by number:'
    @books.each_with_index { |book, index| puts "#{index}) Title: #{book.title}, Author: #{book.author}" }
    book_index = gets.chomp.to_i

    puts 'Select a person from the following list by number:'
    @people.each_with_index do |person, index|
      puts "#{index}) [#{person.class}] Name: #{person.name}, ID: #{person.id}"
    end
    person_index = gets.chomp.to_i

    print 'Date: '
    date = gets.chomp

    rental = Rental.new(date, @people[person_index], @books[book_index])
    @rentals << rental
    puts 'Rental created successfully!'
  end

  def list_rentals_for_person(person_id)
    rentals = @rentals.select { |rental| rental.person.id == person_id }

    if rentals.empty?
      puts "No rentals found for person with ID #{person_id}."
    else
      rentals.each { |rental| puts "Date: #{rental.date}, Book: #{rental.book.title}" }
    end
  end
end
