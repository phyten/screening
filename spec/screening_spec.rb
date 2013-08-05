require 'spec_helper'

describe Screening do
  before do    
    @data = Screening::Data.new    
    @data.start do |element|
      element.title        = "fake"
      element.pageview     = 10000
    end
    @data.start do |element|
      element.title        = "good"
      element.pageview     = 10000
    end
    @data.start do |element|
      element.title        = "good"
      element.pageview     = 5000
    end
    @data.start do |element|
      element.title        = "soso"
      element.pageview     = 300
    end
  end
  describe "Screening::Data" do
    it "should be Screening::Data" do
      expect(@data).to be_a_kind_of Screening::Data
    end
    it "should be able to have categories" do
      @data.classify(:high, :pageview, lambda{|e| e > 1000 })
      pp @data.high
    end
  end
  describe "Screening::Statistics" do
    it "should be Screening::Statistics" do        
      @data.each do |data|
        expect(data).to be_a_kind_of Screening::Statistics
      end     
    end
    it "should add an element by method 'start'" do
      @data.start do |element|
        element.title = "test"
      end
      expect(@data).to have(5).screening_statistics
      new_data = @data.last
      expect(new_data).to be_a_kind_of Screening::Statistics
    end
    it "should add an element by method default method 'push'" do
      @data.push({title: "adding element"})
      expect(@data).to have(5).screening_statistics
      new_data = @data.last
      expect(new_data).to be_a_kind_of Screening::Statistics
    end
    it "should not have element except Screening::Statistics" do
      lambda do
        @data.push("string")
      end.should raise_error "You cannot add elements except Hash(And this Hash is transformed into Screening::Statistics automatically.)."
      lambda do
        @data.push({test: "the test"})
      end.should_not raise_error
    end
  end
end
