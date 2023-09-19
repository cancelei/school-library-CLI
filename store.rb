require 'json'

class Store

switch (variable) {
  case student
    def to_json(*_args) {
        JSON.create_id => self.class.name,
        'id' => @id,
        'name' => @name,
        'age' => @age,
        'parent_permission' => @parent_permission,
        'classroom' => @classroom
      }.to_json(*_args)
    end

    def self.json_create(object)
      new(object['age'], object['classroom'], object['name'], parent_permission: object['parent_permission'])
    end
  
  case teacher
    def to_json(*_args) {
        JSON.create_id => self.class.name,
        'id' => @id,
        'name' => @name,
        'age' => @age,
        'parent_permission' => @parent_permission,
        'specialization' => @specialization
      }.to_json(*_args)
    end
  
    def self.json_create(object)
      new(object['age'], object['specialization'], object['name'], parent_permission: object['parent_permission'])
    end

  case book
    def to_json(*_args) {
        JSON.create_id => self.class.name,
        'id' => @id,
        'title' => @title,
        'author' => @author,
        'rentals' => @rentals
      }.to_json(*_args)
    end
  
    def self.json_create(object)
      new(object['id'], object['title'], object['author'], object['rentals'])
    end

  case rental
    def to_json(*_args) {
        JSON.create_id => self.class.name,
        'date' => @date,
        'person' => @person,
        'book' => @book
      }.to_json(*_args)
    end
  
    def self.json_create(object)
      new(object['date'], object['person'], object['book'])
    end
  }
end  