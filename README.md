# Screening

This library lets you collect, omit and classify data so easily.

## Installation

Add this line to your application's Gemfile:

if you use a bundler,

    gem 'screening', :git => 'git://github.com/phyten/screening.git'

And then execute:

    $ bundle
    
Or,

    $ gem install screening

## History
    Version 0.1.0  Beta Version
    
## Usage
if you want to collect data,

    data = Screening::Data.new
    data.start do |element|
       element.title   = "title1"
       element.content = "content1"
    end
    data.start do |element|
       element.title   = "fake"
       element.content = "fake content"
    end
    
or

    data.push({title: "title2", content: "content2"})    
    p data   # => [{:title=>"title1", :content=>"content1"}, {:title=>"fake", :content=>"fake content"}, {:title=>"title2", :content=>"content2"}]

if you want to classify data,

    data.classify(:high, :title, lambda{|e| e == "content2"})
    p data.high  # => [{:title=>"title2", :content=>"content2"}]
    
if you want to omit data,

    data.omit(:title, lambda{|e| e == "fake"})
    p data   # => [{:title=>"title1", :content=>"content1"}, {:title=>"title2", :content=>"content2"}]
    p data.garbage   # => [{:title=>"fake", :content=>"fake content"}]

if you want to change data,

    data.filter(:title, lambda do |e|
                  e.gsub(/title/, "change") || e
                end)
    p data   # => [{:title=>"change1", :content=>"content1"}, {:title=>"change2", :content=>"content2"}]
                 
if you want NOT to make attributes of data changed,

    data.bind([:title, :content])
    data.push({test: "test"})}   # => raise error
    
And Screening::Data inherits Array class.So you can use it like Array!
    
## TODO
1. Complex classification(ex.Proc with many symbol.).
2. If you omit elements, they are moved to "garbage".
3. Binding attributes.
4. Version management.
5. Huge data.
6. Output various files(csv, xls and others).
    
## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
