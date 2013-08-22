require 'spec_helper'


describe Screening::Data do
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
  subject {@data}
  it {should be_a_kind_of Screening::Data}
  describe "#classify" do
    it "can classify Screening::Data by lambda function." do
      @data.classify(:high, :pageview, lambda{|e| e > 1000 })
      @data.high {should have(3).instance_of_ScreeningStatistics}
    end
  end
  describe "#to_a" do
    subject {@data.to_a}
    it {should_not be_a_kind_of Screening::Data}
    it {should be_a_kind_of Array}
  end
  describe "#start" do
    it "can add an element" do
      @data.start do |element|
        element.title = "test"
      end
      expect(@data).to have(5).screening_statistics
      new_data = @data.last
      expect(new_data).to be_a_kind_of Screening::Statistics
    end
  end
  describe "#to_csv" do
    subject {@data.to_csv}
    it {should be_a_kind_of String}
  end
  describe "#push" do
    it "pushes Screening::Statistics (not Hash)" do
      @data.push({title: "adding element"})
      expect(@data).to have(5).screening_statistics
      new_data = @data.last
      expect(new_data).to be_a_kind_of Screening::Statistics
    end
  end
  describe "#omit" do
    it "can exclude elements by lambda function" do
      @data.omit(:title, lambda{|e| e == "fake"})
      expect(@data).to have(3).screening_statistics
    end
    it "moves to garbage" do
      @data.omit(:title, lambda{|e| e == "fake"})
      expect(@data.garbage).to have(1).screening_statistics
    end
  end
  describe "#bind" do
    it "can bind attributes of elements" do
      @data.bind([:title, :pageview])
      expect {@data.push({test: "test"})}.to raise_error
    end
    it "should not bind attributes except Array" do
      expect {@data.bind("String")}.to raise_error
      expect {@data.bind({test: "test"})}.to raise_error
    end
  end
  it "should not have element except Screening::Statistics" do
    expect {@data.push("string")}.to raise_error "You cannot add elements except Hash(And this Hash is transformed into Screening::Statistics automatically.)."
  end
end
describe "Screening::Data + Screening::Data" do
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
    @another_data = Screening::Data.new
    @another_data.start do |element|
      element.title = "another"
      element.pageview = "20000"
    end
    @union_data = @data + @another_data
  end
  subject {@union_data}
  it {should be_a_kind_of Screening::Data}
  it {should have(5).instance_of_ScreeningStatistics}
end

