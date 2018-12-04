require('spec_helper')

describe(Animal) do
  describe(".all") do
    it ("starts with no animals") do
      expect(Animal.all()).to(eq([]))
    end
  end
end
