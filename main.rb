require_relative 'app.rb'

def main
  app = App.new

  loop do
    puts "\nPlease choose an option by entering a number:"
    puts "1 - List all books"
    puts "2 - List all people"
    puts "3 - Create a person (student or teacher)"
    puts "4 - Create a book"
    puts "5 - Create a rental"
    puts "6 - List all rentals for a given person ID"
    puts "7 - Exit"

    choice = gets.chomp

    case choice
    when '1'
      app.list_all_books
    when '2'
      app.list_all_people
    when '3'
      app.create_person
    when '4'
      app.create_book
    when '5'
      app.create_rental
    when '6'
      print "Enter the person ID: "
      id = gets.chomp.to_i
      app.list_rentals_for_person(id)
    when '7'
      puts "Goodbye!"
      break
    else
      puts "Invalid option. Please, try again."
    end
  end
end

main