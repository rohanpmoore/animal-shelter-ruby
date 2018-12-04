require("sinatra")
require("sinatra/reloader")
also_reload("lib/**/*.rb")
require("./lib/animal")
require("./lib/customer")
require("pg")

DB = PG.connect({:dbname => "animal_shelter"})

get ('/') do
  erb :index
end

get ('/shelter') do
  erb :shelter
end

get ('/adopter') do
  erb :customer_authenticate
end

get ('/add_animal') do
  erb :add_animal
end

get ('/add_customer') do
  erb :add_customer
end

get ('/animal_list') do
  @animals = Animal.all_ordered("admittance")
  erb :animal_list
end

get ('/customer_list') do
  @customers = Customer.all_ordered("type_preference")
  erb :customer_list
end

get ('/make_owner') do
  @animals = Animal.all
  @customers = Customer.all
  erb :make_owner
end

get ('/adopted_animals') do
  @animals = Animal.get_owned_animals
  @customers = Customer.all
  erb :adopted_animals
end

post ('/authenticate') do
  name = params.fetch("customer_name")
  valid = Customer.authenticate?(name)
  if(valid)
    @animals = Animal.all
    erb :adopter
  else
    erb :authenticate_fail
  end
end

post ('/add_customer') do
  name = params.fetch("customer_name")
  phone = params.fetch("customer_phone")
  type = params.fetch("type_preference")
  breed = params.fetch("breed_preference")
  customer = Customer.new({:customer_name => name, :customer_phone => phone, :type_preference => type, :breed_preference => breed, :customer_id => nil})
  customer.save
  erb :add_customer
end

post ('/add_animal') do
  name = params.fetch("animal_name")
  gender = params.fetch("animal_gender")
  admittance = params.fetch("admittance")
  type = params.fetch("animal_type")
  breed = params.fetch("animal_breed")
  animal = Animal.new({:animal_name => name, :animal_gender => gender, :admittance => admittance, :animal_type => type, :animal_breed => breed, :animal_id => nil, :owner_id => 0})
  animal.save
  erb :add_animal
end

post ('/make_owner') do
  pet_id = params.fetch("animal").to_i
  owner_id = params.fetch("customer").to_i
  pet = Animal.get_by_id(pet_id)
  pet.found_home(owner_id)
  @animals = Animal.all
  @customers = Customer.all
  erb :make_owner
end
