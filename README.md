# Screening

This library lets you collect, omit and classify data so easily.

## Installation

Add this line to your application's Gemfile:

if you use a bundler,

    gem 'screening', :git => 'git://github.com/phyten/screening.git'

And then execute:

    $ bundle

## Usage
if you want to collect data,
    ```ruby
    data = Screening::Data.new
    data.start do |element|
       element.title   = "title1"
       element.content = "content1"
    end
    data.start do |element|
       element.title   = "title2"
       element.content = "content2"
    end
    p data   # => [{:title=>"title1", :content=>"content1"}, {:title=>"title2", :content=>"content2"}]
    ```
if you want to classify data,
    ```ruby
    data.classify(:high, :title, lambda{|e| e == "content2"})
    p data.high  # => [{:title=>"title2", :content=>"content2"}]
    ```
## TODO
1. Complex classification (ex.Proc with many symbol.)
2. If you omit elements, they are moved to "garbage".
3. Binding attributes.
    
## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
