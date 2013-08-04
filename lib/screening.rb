# -*- coding: utf-8 -*-
require "screening/version"

module Screening
end

module ArrayToSelfConvert
  def self.included(klass)
    methods = ::Array.public_instance_methods(true) - ::Kernel.public_instance_methods(false)
    methods |= ["to_s","to_a","inspect","==","=~","==="]
    methods.each do |method|
      define_method(method) do |*args, &block|
        res = super(*args, &block)
        if res.class == Array && method != 'to_a'
          cloned = deep_clone ? Marshal.load(Marshal.dump(self)) : self.dup
          cloned.clear.concat(res)
        else
          res
        end
      end
    end
  end
  attr_accessor :deep_clone
end

module Screening
  class Data < Array
    # FIXME: add a method of garbage to this class
    include ArrayToSelfConvert
    def start
      self.push(Screening::Statistics.new)
      yield(self.last)
    end
    def omit(target, block)
      self.delete_if {|element| block.call(element.__send__(target))}
    end
    def filter(target, paper)
      if paper.is_a? Proc
        filter_block(target, paper)
      elsif paper == :moji
        filter_moji(target)
      end
    end
    def filter_moji(target)
      self.each do |element|
        next if element.__send__(target).blank?
        element.__send__("#{target}=", Moji.zen_to_han(element.__send__(target), Moji::ZEN_ALPHA))
        element.__send__("#{target}=", Moji.han_to_zen(element.__send__(target), Moji::HAN_KATA))
        element.__send__("#{target}=", Moji.zen_to_han(element.__send__(target), Moji::ZEN_ASYMBOL))
        element.__send__("#{target}=", Moji.zen_to_han(element.__send__(target), Moji::ZEN_NUMBER))
      end
    end
    def filter_block(target, block)
      self.each do |element|
        next if element.__send__(target).blank?
        res = block.call(element.__send__(target))
        element.__send__("#{target}=", res)
      end
    end
    def classify(grade, target, block)
      self.class.class_eval do
        attr_accessor grade
      end
      self.__send__("#{grade}=", Screening::Data.new) if self.__send__(grade).nil?
      self.each do |element|
        if block.call(element.__send__(target))
          self.__send__(grade).push(element)
        end
      end
      self.__send__(grade).uniq!
    end
    def push_with_statistics(*args)
      # override
      args.each do |arg|
        if arg.is_a? Hash
          self.push_without_statistics(Screening::Statistics.new.merge!(arg))
        else
          self.push_without_statistics(arg)
        end
      end
      return self
    end
    alias push_without_statistics push
    alias push push_with_statistics
  end
end

module Screening
  class Statistics < Hash
    class << self
      def attr_hash(method_hash)
        define_method(method_hash) do
          self[method_hash]
        end
        define_method("#{method_hash}=") do |value|
          self[method_hash] = value
        end
      end
    end    
    def method_missing(method_id, *args, &block)
      method_id_chopped = method_id =~ /\=/ ? method_id.to_s.chop.to_sym : method_id
      self.class.attr_hash method_id_chopped
      if method_id =~ /\=/
        __send__("#{method_id_chopped}=", args[0])
      else
        __send__(method_id_chopped)
      end
    end
  end
end
