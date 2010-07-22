# coding : utf-8

require File.dirname(__FILE__) + '/spec_helper.rb'

describe "", Apex::Class do
  before do
    @apex_class = Apex::Class.new(<<-"END")
    /**
     *
     */
    public class Foo{
        /**
         *
         */
        public Foo(){
        }
        /**
         *
         */
        public void fooMethod(){
        }
        /**
         *
         */
        public int barMethod(){
            return 0;
        }
        /**
         *
         */
        public int buzMethodd(int n){
            return 0;
        }
    }
    END
  end
  it "shoud return method signeture." do
  end
end
