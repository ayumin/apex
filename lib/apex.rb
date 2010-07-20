#!/usr/bin/ruby
# -*- coding: utf-8 -*-

# = Apex Light Perser
# Author::    Ayumu AIZAWA
# Copyright:: Copyright 2010 Ayumu AIZAWA Allright reserved.
# License::   MIT LICENCE
#
#
# = An Introduction to Force.com Apex Code
#
# == Abstract
#
# Force.com Apex Code is a strongly-typed programming language that executes on the Force.com platform. 
#
# Apex is used to add business logic to applications, to write database triggers, and to program controllers
# in the user interface layer. It has a tight integration with the database and query language, 
# good web services support, and includes features such as futures and governors for execution 
# in a multi-tenant environment.
#
# = See Also
# - http://wiki.developerforce.com/index.php/An_Introduction_to_Apex
#
module Apex
  require "apex/class"
  require "apex/method"
  require "apex/field"
  require "apex/converter"
  #
  # Load Apex code from string
  #
  # [str]
  # Apex code strings.
  #
  def self.load(str)
    Apex::Class.new(str)
  end
  #
  # Load Apex code from file
  #
  # [path]
  # Path of Apex class file
  #
  def self.load_file(path)
    File.open(path) do |file|
      Apex::Class.new(file.read)
    end
  end

end
