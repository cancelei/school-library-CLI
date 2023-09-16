class Rental
  attr_accessor :date, :person

  def initialize(date, person)
    @date = date
    person.rentals << self
  end
end
