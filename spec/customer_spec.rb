require('spec_helper')

describe(Customer) do
  describe(".all") do
    it ("starts with no customers") do
      expect(Customer.all()).to(eq([]))
    end
  end
  describe("#customer_name") do
    it('tells you the customers name') do
      customer = Customer.new({:customer_id => nil, :customer_name => "Dennis", :customer_phone => "503-555-4209", :type_preference => 'dog', :breed_preference => 'yorkie'})
      expect(customer.customer_name()).to(eq("Dennis"))
    end
  end

  describe("#customer_id") do
    it("sets its ID when you save it") do
      customer = Customer.new({:customer_id => nil, :customer_name => "Dennis", :customer_phone => "503-555-4209", :type_preference => 'dog', :breed_preference => 'yorkie'})
      customer.save
      expect(customer.customer_id()).to(be_an_instance_of(Integer))
    end
  end

  describe("#save") do
    it("lets you save customers to the database") do
      customer = Customer.new({:customer_id => nil, :customer_name => "Dennis", :customer_phone => "503-555-4209", :type_preference => 'dog', :breed_preference => 'yorkie'})
      customer.save
      expect(Customer.all()).to(eq([customer]))
    end
  end

  describe("#==") do
    it("is the same customer if it has the same values") do
      customer1 = Customer.new({:customer_id => nil, :customer_name => "Dennis", :customer_phone => "503-555-4209", :type_preference => 'dog', :breed_preference => 'yorkie'})
      customer2 = Customer.new({:customer_id => nil, :customer_name => "Dennis", :customer_phone => "503-555-4209", :type_preference => 'dog', :breed_preference => 'yorkie'})
      expect(customer1).to(eq(customer2))
      customer1.save
      customer3 = Customer.all[0]
      expect(customer1).to(eq(customer3))
    end
  end
end
