# -*- coding: utf-8 -*-
require 'rubygems'
require 'bundler/setup'
$:.unshift(File.dirname(__FILE__) + '/../lib/')
require 'screening'

# # カスタムマッチャを書きたかったらここに。
# RSpec::Matchers.define :my_matcher do |expected|
#   match do |actual|
#     true
#   end
# end
