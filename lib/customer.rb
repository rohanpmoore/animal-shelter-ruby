class Customer
  attr_reader :customer_id, :customer_name, :customer_phone, :type_preference, :breed_preference

  def initialize(attributes)
    @customer_id = attributes.fetch(:customer_id)
    @customer_name = attributes.fetch(:customer_name)
    @customer_phone = attributes.fetch(:customer_phone)
    @type_preference = attributes.fetch(:type_preference)
    @breed_preference = attributes.fetch(:breed_preference)
  end

  def self.all_basic(customers)
    output_customers = []
    customers.each() do |customer|
      customer_id = customer.fetch("id").to_i
      customer_name = customer.fetch("name")
      customer_phone = customer.fetch("phone")
      type_preference = customer.fetch("type_preference")
      breed_preference = customer.fetch("breed_preference")
      output_customers.push(Customer.new({:customer_id => customer_id, :customer_name => customer_name, :customer_phone => customer_phone, :type_preference => type_preference, :breed_preference => breed_preference}))
    end
    output_customers
  end

  def self.all
    returned_customers = DB.exec("SELECT * FROM customers;")
    Customer.all_basic(returned_customers)
  end

  def self.all_ordered(order_rule)
    returned_customers = DB.exec("SELECT * FROM customers ORDER BY #{order_rule};")
    Customer.all_basic(returned_customers)
  end

  def save
    result = DB.exec("INSERT INTO customers (name, phone, type_preference, breed_preference) VALUES ('#{@customer_name}', '#{@customer_phone}', '#{@type_preference}', '#{@breed_preference}') RETURNING id;")
    @customer_id = result.first().fetch("id").to_i()
  end

  def ==(another_customer)
    self.customer_id.==(another_customer.customer_id).&(self.customer_name.==(another_customer.customer_name)).&(self.customer_phone.==(another_customer.customer_phone)).&(self.type_preference.==(another_customer.type_preference)).&(self.breed_preference.==(another_customer.breed_preference))
  end

  def self.get_by_id(id)
    customers = Customer.all
    customers.each do |customer|
      if customer.customer_id == id
        return customer
      end
    end
  end

  def self.authenticate?(name)
    customers = Customer.all
    customers.each do |customer|
      if customer.customer_name == name
        return true
      end
    end
    return false
  end
end
