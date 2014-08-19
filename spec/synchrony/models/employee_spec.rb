module Synchrony
  describe Employee do
    describe "#carrying?" do
      it "returns true when possesses containers" do
        e = Employee.create
        e.containers << Container.create
        expect(e).to be_carrying
      end
      it "returns false when no possessions" do
        e = Employee.create
        expect(e).to_not be_carrying
      end
    end

    describe "#to_json" do
    end

    describe "#pickup" do
      it "adds container to employee" do
        e = Employee.create
        e.pickup(Container.create)
        expect(e.containers.count).to eq(1)
      end
    end

    describe "#dropoff" do
      it "does not complain when not carrying anything" do
        e = Employee.create
        l = Location.create
        expect do
          e.dropoff_at(l)
        end.to_not raise_error
      end

      it "removes containers from employee" do
        e = Employee.create
        e.pickup(Container.create)
        expect(e).to be_carrying
        e.dropoff_at(Location.create)
        expect(e).to_not be_carrying
      end

      it "adds containers to location" do
        e = Employee.create
        l = Location.create
        e.pickup(Container.create)
        e.pickup(Container.create)
        expect(e).to be_carrying
        e.dropoff_at(l)
        expect(l.containers.count).to eq(2)
      end
    end
  end
end
