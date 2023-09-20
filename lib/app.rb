require_relative 'book'
require_relative 'person'
require_relative 'rental'
require_relative 'student'
require_relative 'teacher'
require 'json'
class App
  def initialize
    @books = read_data('books.json')
    @people = read_data('people.json')
    @rentals = read_data('rentals.json')
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
    raise 'Invalid input. Choose Y or N.' unless %w[y n].include?(parent_permission_input)

    parent_permission = parent_permission_input == 'y'

    student = Student.new(age, name, parent_permission: parent_permission)
    @people << student
    puts 'Student created successfully!'
  rescue StandardError
    puts "Error: #{e.message}"
    retry
  end

  def create_teacher
    print 'Age: '
    age = gets.chomp.to_i

    print 'Name: '
    name = gets.chomp

    print 'Specialization: '
    specialization = gets.chomp

    teacher = Teacher.new(age, specialization, name)
    @people << teacher
    puts 'Teacher created successfully!'
  end

  def create_book
    print 'Title: '
    title = gets.chomp

    print 'Author: '
    author = gets.chomp

    book = Book.new(title, author)
    @books << book
    puts 'Book created successfully!'
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

  def object_to_hash(object)
    hash = {}
    arr_of_class = ['Teacher', 'Student', 'Book', 'Rental']
    hash['class'] = object.class # store the class_name
    object.instance_variables.each do |var|
      name = var.to_s.delete('@') # take the name of variable without @
      value = object.instance_variable_get(var)
      # Check if value is an array of objects
      if arr_of_class.include?(value.class.to_s)
        value = value == object ? value : object_to_hash(value)
      end
      hash[name] = value
    end
    hash
  end
  

  def write_data
    data = { books: @books, people: @people, rentals: @rentals }
    data.each do |key, arr|
      arr = arr.select { |obj| !obj.nil? || arr.empty? } # take it if it's not empty or nil arrays
      arr = arr.map { |obj| object_to_hash(obj) } # Convert each object to a hash
      file_name = "#{key}.json" # the name of our futur json file
      json = JSON.generate(arr) # Generate a JSON string fron the arr of hashes
      File.open(file_name, 'w') do |f|
        f.puts(json)
      end
      puts "The array #{key} has been written to #{file_name}"
    end
  end



  require 'json'

  def read_data(file_name)
    if File.exist?(file_name)
      json = File.read(file_name)
      arr_of_hashes = JSON.parse(json) # Convert JSON string into an array of hashes

      arr = []
      arr_of_hashes.each do |hash|
        real_class = Kernel.const_get(hash['class']) # allows to get the class by it's name
        object = real_class.json_create(hash) # create methode from the hash
        arr.push(object)
      end
      arr
    else
      puts "The file #{file_name} does not exist."
      [] # return an empty array
    end
  end

  def check
    puts File.exist?('books.json') # should return true
    puts File.exist?('people.json') # should return true
    puts File.exist?('rentals.json') # should return true
    puts File.exist?('nonexistent.json')
  end
end
