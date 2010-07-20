require File.dirname(__FILE__) + '/spec_helper.rb'

describe Apex::Class do
  describe "when empty class" do
    before do
      @apex = Apex::Class.new(<<-CODE)
      public abstract class Foo {}
      CODE
    end
    subject { @apex }
    it "class_name should be 'Foo'" do 
      subject.class_name.should == "Foo"
    end
    it "scope should be 'public'" do
      subject.scope.should == "public"
    end
    it "abstraction should be 'abstract'" do
      subject.abstraction.should == "abstract"
    end
    it "methods should be empty" do
      subject.methods.should == []
    end
    it "fields should be empty" do
      subject.fields.should == []
    end
  end
end
