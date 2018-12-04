require('rspec')
require('pg')
require('animal')
require('customer')

DB = PG.connect({:dbname => "animal_shelter_test"})

RSpec.configure do |config|
  config.after(:each) do
    DB.exec("DELETE FROM animals *;")
    DB.exec("DELETE FROM customers *;")
  end
end
