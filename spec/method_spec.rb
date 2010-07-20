# coding : utf-8

require File.dirname(__FILE__) + '/spec_helper.rb'

describe "", Apex::Method do
  it "shoud return method signeture." do
    method = Apex::Method.new(
      "methodName",
      ["int"],
      "returnType",
      "public",
      "abstract")
    method.signeture.should == "public abstract returnType methodName(int)"
  end
  it "shoud return method signeture." do
    method = Apex::Method.new(
      "methodName",
      ["int","String"],
      "returnType",
      "public",
      "abstract")
    method.signeture.should == "public abstract returnType methodName(int,String)"
  end
end
