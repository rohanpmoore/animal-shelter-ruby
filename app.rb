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
  @animals = Animal.all
  erb :adopter
end
