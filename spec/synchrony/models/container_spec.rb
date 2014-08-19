module Synchrony
  describe Container do
    describe ".free" do
      it "returns only containers not held or placed" do
        c1 = Container.create
        c2 = Container.create
        c3 = Container.create
        c4 = Container.create

        Location.create.containers << c2
        Employee.create.containers << c3

        expect(Container.free).to eq([c1, c4])
      end
    end

    describe "#free?" do
      it "returns true when not held or placed anywhere" do
        expect(Container.create).to be_free
      end

      it "returns false when held" do
        c = Container.create
        Location.create.containers << c
        c.reload
        expect(c).to_not be_free
      end

      it "returns false when placed" do
        c = Container.create
        Employee.create.containers << c
        c.reload
        expect(c).to_not be_free
      end
    end
  end
end
