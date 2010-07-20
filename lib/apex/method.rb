#!/usr/bin/ruby
# -*- coding: utf-8 -*-
module Apex
  #
  # Apex::Class に含まれるメソッドをあらわします
  #
  class Method
    [:name, :args, :type, :scope, :abstraction].each do |sym|
      attr_reader :sym
    end
    #
    # [name]
    # name of method
    # [args]
    # arguments type of method
    # [type]
    # type of return value
    # [scope]
    # accessibility of method
    # (e.g. global, public, protected or private 
    # [abstraction]
    # abstract method or not
    #
    def initialize(name,args,type,scope,abstraction)
      @name = name
      @args = args
      @type = type
      @scope = scope
      @abstraction = abstraction
    end
    def inspect
      "#<#{self.class} #{signeture}>"
    end
    def signeture
      "#@scope #@abstraction #@type #@name(#{@args.join(',')})"
    end
  end
end
