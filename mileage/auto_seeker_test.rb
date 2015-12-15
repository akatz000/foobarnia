require "minitest/autorun"
require "./auto_seeker"

describe AutoSeeker do
  before do
    data = [
      [1,'Red',12999,20.0,'gas'],
      [2,'Blue',13999,25.0,'gas'],
      [3,'Teal',19000,27.0,'gas'],
      [4,'Red',14999,40.0,'diesel']
    ]
    @seeker = AutoSeeker.new data

    data_nil = [
      [1,'Red',12999,20.0,'gas'],
      [2,'Blue',13999,25.0,'gas'],
      [3,'Teal',19000,27.0,'gas'],
      [4,'Red',14999,40.0,'diesel'],
      [5,'Orange',123456,nil,'magic'],
      [6,'Orange',123456,nil,'magic'],
      [7,'Orange',123456,nil,'magic']
    ]
    @seeker_nil = AutoSeeker.new data_nil
  end


  describe "#filter " do
    it "can filter by color " do
      @seeker.filter 'color', 'Red'
      @seeker.autos.collect(&:color).uniq.must_equal ['Red']
    end
  end

  describe ".median_mileage " do
    it "calculates median mileage for all autos" do
      AutoSeeker.median_mileage(@seeker.autos).must_equal 26.0
    end

    it "throws out nil values for mileage" do
      AutoSeeker.median_mileage(@seeker_nil.autos).must_equal 26.0
    end
  end
end
