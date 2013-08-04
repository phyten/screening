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
      element.pageview     = 0
    end
    @data.start do |element|
      element.title        = "soso"
      element.pageview     = 10000
    end
  end
  describe "Screening::Data" do
    it "should be Screening::Data" do
      expect(@data).to be_a_kind_of Screening::Data
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
    end
  end
end
