require_relative 'app'

def main
  app = App.new

  options = {
    '1' => 'list_all_books',
    '2' => 'list_all_people',
    '3' => 'create_person',
    '4' => 'create_book',
    '5' => 'create_rental',
    '6' => 'list_rentals_for_person',
    '7' => 'exit_app'
  }

  option_commande = [
    'List all books', 'List all people',
    'Create a person (student or teacher)', 'Create a book', 'Create a rental',
    'List all rentals for a given person ID', 'Exit'
  ]

  loop do
    puts "\nPlease choose an option by entering a number:"

    option_commande.map.with_index { |command, index| puts "#{index + 1} - #{command}" }
    choice = gets.chomp
    if options.key?(choice)
      app.send(options[choice])
    else
      puts 'Invalid option. Please, try again.'
    end

    # Add an empty line before the end of the loop
  end
end

# Add an empty line before calling the main method
main
