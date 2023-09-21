require_relative 'book'
require_relative 'person'
require_relative 'rental'
require_relative 'student'
require_relative 'teacher'

require 'json'

require_relative 'modules/mod_people'
require_relative 'modules/mod_books'
require_relative 'modules/mod_rentals'


class App
  include PeopleMod
  include BooksMod
  include RentalsMod
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
    type = take_type
    age = take_age
    name = take_name
    if type == 1
      parent_permission = take_parent_permission
      create_student(age, name, parent_permission)
    else
      specialization = take_specialization
      create_teacher(age, specialization, name)
    end
  end

  def create_student(age, name, parent_permission)
    student = Student.new(age, name, parent_permission: parent_permission)
    @people << student
    puts 'Student created successfully!'
  end

  def create_teacher(age, specialization, name)
    teacher = Teacher.new(age, specialization, name)
    @people << teacher
    puts 'Teacher created successfully!'
  end

  def create_book
    title = take_title
    author = take_author
    book = Book.new(title, author)
    @books << book
    puts 'Book created successfully!'
  end

  def create_rental
    book = select_book
    person = select_person
    date = take_date

    rental = Rental.new(date, person, book)
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
    arr_of_class = %w[Teacher Student Book Rental]
    hash['class'] = object.class # store the class_name
    object.instance_variables.each do |var|
      name = var.to_s.delete('@') # take the name of variable without @
      value = object.instance_variable_get(var)
      # Check if value is an array of objects
      value = object_to_hash(value) if arr_of_class.include?(value.class.to_s)
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
      FileUtils.mkdir_p('json') # create a json file if it's not exist
      File.open("json/#{file_name}", 'w') do |f|
        f.puts(json)
      end
      puts "The array #{key} has been written to #{file_name}"
    end
  end

  def read_data(file_name)
    if Dir.exist?('json')
      if File.exist?("json/#{file_name}")
        json = File.read("json/#{file_name}")
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
        [] # return an empty array if the file doesn't exist
      end
    else
      puts "The folder 'json' does not exist."
      [] # return an empty array if the folder doesn't exist
    end
  end

  def check
    puts File.exist?('books.json') # should return true
    puts File.exist?('people.json') # should return true
    puts File.exist?('rentals.json') # should return true
    puts File.exist?('nonexistent.json')
  end
end
