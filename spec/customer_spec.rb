require('spec_helper')

describe(Customer) do
  describe(".all") do
    it ("starts with no customers") do
      expect(Customer.all()).to(eq([]))
    end
  end
end
