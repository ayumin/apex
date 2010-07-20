#!/usr/bin/ruby
# -*- coding: utf-8 -*-
module Apex
  #
  # Apex::Class に含まれるフィールドをあらわします
  #
  class Field
    [:name, :type, :scope, :abstraction].each do |sym|
      attr_reader :sym
    end
    #
    # [name]
    #
    # [type]
    #
    # [scope]
    #
    # [abstraction]
    #
    def initialize(name,type,scope,abstraction)
      @name = name
      @type = type
      @scope = scope
      @abstraction = abstraction
    end
    def inspect
      [ "#<", self.class,
        " \@name=\"", @name, "\"",
        " \@type=\"", @type, "\"" ,
        " \@scope=\"", @scope, "\"",
        " \@abstraction=\"", @abstraction, "\"" ].join
    end
  end
end