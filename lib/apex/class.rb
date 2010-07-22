#!/usr/bin/ruby
# -*- coding: utf-8 -*-

require "apex/method"
require "apex/field"
require "apex/converter"

# = Apex::Class
#
#
#
#
module Apex
  #
  #
  #
  class Class
    
    include Apex::Converter
    
    [:class_name, :scope, :abstraction, :methods, :fields].each do |sym|
      attr_reader sym
    end
    #
    # 
    #
    def initialize(code)
      @origin = code
      in_document = false
      in_comment = false
      pre_regurated = []
      @origin.split("\n").each_with_index do |line,i|
        line.sub!(/\/\/.*$/,'') # delete inline comment
        if line =~ /^\s*$/
          #
          # skip empty line
          #
        elsif line =~ /\/\*\*.*$/
          #pre = $`
          doc = line
          in_document = true
          if line =~ /^.*\*\//
            doc = $&
            suf = $'
            in_document = false
            pre_regurated << doc << suf.to_s
          else
            pre_regurated << line
          end
        elsif line =~ /\/\*.*$/
          pre = $`
          com = $&
          in_comment = true
          if line =~ /^.*\*\//
            com = $&
            suf = $'
            in_comment = false
            pre_regurated << suf.to_s
          else
            pre_regurated << pre.to_s
          end
        elsif in_document
          if line =~ /^.*\*\//
            doc = $&
            suf = $'
            in_document = false
            pre_regurated << doc
            pre_regurated << suf.to_s
          else
            pre_regurated << line
          end
        elsif in_comment
          if line =~ /^.*\*\//
            com = $&
            suf = $'
            in_comment = false
            pre_regurated << suf.to_s
          end
        else
          #pre_regurated[0] = "" if pre_regurated.size == 0
          pre_regurated <<  line
        end
      end
      pre_regurated.reject! do |line|
        line =~ /^\s*$/
      end
      puts pre_regurated.join("\n")
      @code = code
      pick_class
      pick_methods
      pick_fields
      self
    end
    
    def to_s
      @code
    end
    
    def inspect
      [ "#<", self.class,
        " \@class=\"", @class_name, "\"",
        " \@scope=\"", @scope, "\"",
        " \@abstraction=\"", @abstraction, "\"" ].join
    end
    
    private
    ############################################################################
    #
    ############################################################################
    R_COMMENT_START   = %r[\s*\/\*\*?]
    R_COMMENT_END     = %r[\*\/]
    R_DEF_CLASS       = %r[^\s*(global|public|protected|private)\s+(abstract\s+)?(class|interface)\s+(\w+)]i
    R_DEF_CONSTRACTOR = %r[^\s*(global|public|protected|private)\s+(abstract\s+)?(#{@class_name})\s*\(]i
    R_DEF_METHOD      = %r[^\s*(global|public|protected|private)\s+(abstract\s+|static\s+)?([\w\<\>\[\]]+)\s+(\w+)\s*\(]i
    R_DEF_FIELD       = %r[^\s*(global|public|protected|private)\s+(abstract\s+|finel\s+)?([\w\<\>\[\]]+)\s+(\w+)]i
    
    ############################################################################
    # コードからクラスとクラス属性を取得してインスタンス変数に格納する
    ############################################################################
    def pick_class
      @code.each do |line|
        line.chomp!
        line.gsub!(/\"/,"\\\"")
        line.gsub!(/\'/,"\"")
        line.sub!(/virtual /,'')
        line.sub!(/with /,'')
        line.sub!(/without /,'')
        line.sub!(/sharing /,'')
        line.sub!(/override /,'')
        if line =~ R_DEF_CLASS
          @class_name = $4
          @scope = $1
          @abstraction = "abstract" if $2 =~ /abstract/
          break
        end
      end
    end
    ############################################################################
    # コードからメソッドとメソッド属性を取得してインスタンス変数に格納する
    ############################################################################
    def pick_methods
      @methods = []
      @code.split(/\n/).each do |line|
        if line =~ R_DEF_METHOD
          scope = $1
          abstraction = ($2 ? $2.strip : nil)
          type = $3
          name = $4
          args = []
          @methods << Apex::Method.new(name,args,type,scope,abstraction)
        end
      end
      @methods
    end
    ############################################################################
    # コードからフィールドとフィールド属性を取得してインスタンス変数に格納する
    ############################################################################
    def pick_fields
      @fields = []
      @code.split(/\n/).each do |line|
        if line =~ R_DEF_METHOD
        elsif line =~ R_DEF_CLASS
        elsif line =~ R_DEF_FIELD
          @fields << Apex::Field.new($4,$3,$1,$2)
        end
      end
      @fields
    end
  end
end
