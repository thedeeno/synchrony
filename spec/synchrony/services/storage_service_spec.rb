module Synchrony
  describe StorageService do
    let(:klass) { 
      Class.new do
        attr_accessor :id
      end
    }
    let(:storage) { StorageService.new(klass) }

    describe "#next_id" do
      it "returns the largest id + 1" do
        storage.save(klass.new)
        storage.save(klass.new)
        expect(storage.next_id).to eq(2)
      end
      it "returns 0 when nothing stored" do
        expect(storage.count).to eq(0)
        expect(storage.next_id).to eq(0)
      end
    end

    describe "#save" do
      it "stores the instance" do
        expect do
          storage.save(klass.new)
        end.to change{storage.count}.by(1)
      end
      it "assigns the available id if instance doesn't have one" do
        a = klass.new 
        a.id = 10
        b = klass.new
        storage.save(a)
        storage.save(b)
        expect(a.id).to eq(10)
        expect(b.id).to eq(11)
      end
      it "returns the obj" do
        a = klass.new
        b = storage.save(a)
        expect(a).to eql(b)
      end
    end

    describe "#all" do
      it "returns all stored models" do
        10.times do 
          storage.save(klass.new)
        end
        expect(storage.all.count).to eq(10)
      end
    end

    describe ".reset!" do
      it "clears the index of all instances" do
        # setup
        a = StorageService.new(klass)
        b = StorageService.new(klass)
        a.save(klass.new)
        a.save(klass.new)
        b.save(klass.new)

        # exercise
        expect(a.count).to eq(2)
        expect(b.count).to eq(1)
        StorageService.reset!
        expect(a.count).to eq(0)
        expect(b.count).to eq(0)
      end
    end
  end
end

