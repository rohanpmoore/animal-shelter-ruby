require('spec_helper')

describe(Animal) do
  describe(".all") do
    it ("starts with no animals") do
      expect(Animal.all()).to(eq([]))
    end
  end

  describe("#animal_id") do
    it("sets its ID when you save it") do
      animal = Animal.new({:animal_id => nil, :animal_name => "Frank", :animal_gender => 'male', :admittance => '2017-03-16 00:00:00', :animal_type => 'dog', :animal_breed => 'bulldog', :owner_id => 0})
      animal.save
      expect(animal.animal_id()).to(be_an_instance_of(Integer))
    end
  end

  describe("#save") do
    it("lets you save animals to the database") do
      animal = Animal.new({:animal_id => nil, :animal_name => "Frank", :animal_gender => 'male', :admittance => '2017-03-16 00:00:00', :animal_type => 'dog', :animal_breed => 'bulldog', :owner_id => 0})
      animal.save
      expect(Animal.all()).to(eq([animal]))
    end
  end

  describe("#==") do
    it("is the same animal if it has the same values") do
      animal1 = Animal.new({:animal_id => nil, :animal_name => "Frank", :animal_gender => 'male', :admittance => '2017-03-16 00:00:00', :animal_type => 'dog', :animal_breed => 'bulldog', :owner_id => 0})
      animal2 = Animal.new({:animal_id => nil, :animal_name => "Frank", :animal_gender => 'male', :admittance => '2017-03-16 00:00:00', :animal_type => 'dog', :animal_breed => 'bulldog', :owner_id => 0})
      expect(animal1).to(eq(animal2))
      animal1.save
      animal3 = Animal.all[0]
      expect(animal1).to(eq(animal3))
    end
  end
end
