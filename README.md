# Screening

TODO: Write a gem description

## Installation

Add this line to your application's Gemfile:

if you use a bundler,

    gem 'screening', :git => 'git://github.com/phyten/screening.git'

And then execute:

    $ bundle

## Usage

   data = Screening::Data.new
   data.start do |element|
      element.title   = "title1"
      element.content = "content1"
   end
   data.start do |element|
      element.title   = "title2"
      element.content = "content2"
   end
   p data                      #  => [{:title=>"title1", :content=>"content1"}, {:title=>"title2", :content=>"content2"}]

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
