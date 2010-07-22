# coding : utf-8

require File.dirname(__FILE__) + '/spec_helper.rb'

describe "", Apex::Class do
  before do
    @apex_class = Apex::Class.new(<<-"END")

    /**
     * documents for Foo
     */
    public class Foo{
        /** documents for someField */
        public int someField; // line comment
        /**
         * documents for Foo constractor
         */
        public Foo(){
        }
        /**
         * documents for fooMethod
         */
        public void fooMethod(){
        }
        /**
         * documents for barMethod
         */
        public int barMethod(){
            /* something */
            return 0;
        }
        /**
         * documents for buzMethod
         */
        /* public int pendingMethod(int x){
         *     return 0;
         * } 
         */
        public int buzMethod(int n){
            return 0;
            /*
             * something else
             */
        }
        /* public int pendingMethod(int x){
         *     return 0;
         * } 
         */
         public class innerClass{
         }
    }
    END
  end
  it "shoud return method signeture." do
  end
end
