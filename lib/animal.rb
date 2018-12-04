class Animal
  attr_reader :animal_id, :animal_name, :animal_gender, :admittance, :animal_type, :animal_breed
  attr_accessor :owner_id
  def initialize(attributes)
    @animal_id = attributes.fetch(:animal_id)
    @animal_name = attributes.fetch(:animal_name)
    @animal_gender = attributes.fetch(:animal_gender)
    @admittance = attributes.fetch(:admittance)
    @animal_type = attributes.fetch(:animal_type)
    @animal_breed = attributes.fetch(:animal_breed)
    @owner_id = attributes.fetch(:owner_id)
  end

  def self.all_basic(animals)
    animals = []
    animals.each() do |animal|
      animal_id = animal.fetch("id").to_i
      animal_name = animal.fetch("name")
      animal_gender = animal.fetch("gender")
      admittance = animal.fetch("admittance")
      animal_type = animal.fetch("type")
      animal_breed = animal.fetch("breed")
      owner_id = animal.fetch("owner_id")
      animals.push(Animal.new({:animal_id => animal_id, :animal_name => animal_name, :animal_gender => animal_gender, :admittance => admittance, :animal_type => animal_type, :animal_breed => animal_breed, :owner_id => owner_id}))
    end
    animals
  end

  def self.all
    returned_animals = DB.exec("SELECT * FROM animals;")
    Animal.all_basic(returned_animals)
  end

  def save
    result = DB.exec("INSERT INTO animals (name, gender, admittance, type, breed, owner_id) VALUES ('#{@animal_name}', '#{@animal_gender}', '#{@admittance}', '#{@animal_type}', '#{@animal_breed}', #{@owner_id}) RETURNING id;")
    @animal_id = result.first().fetch("id").to_i()
  end

  def ==(another_animal)
    self.animal_id.==(another_animal.animal_id).&(self.animal_name.==(another_animal.animal_name)).&(self.animal_gender.==(another_animal.animal_gender)).&(self.admittance.==(another_animal.admittance)).&(self.animal_type.==(another_animal.animal_type)).&(self.animal_breed.==(another_animal.animal_breed)).&(self.owner_id.==(another_animal.owner_id))
  end

  def self.get_by_id(id)
    animals = Animal.all
    animals.each do |animal|
      if animal.id == id
        return animal
      end
    end
  end

  def self.all_ordered(order_rule)
    returned_animals = DB.exec("SELECT * FROM animals ORDER BY #{order_rule};")
    Animal.all_basic(returned_animals)
  end
end
