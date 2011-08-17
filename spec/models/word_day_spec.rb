require 'spec_helper'

describe WordDay do
  before do
    @org = Factory(:organization)
  end
    
  context "intializing" do    
    it "should set the keys" do
      s =  WordDay.new("this is some text", "twitter", @organization.id)
      s.bigram_hash.should ==  {"this, is"=>1, "is, some"=>1, "some, text"=>1}
      s.word_hash.should == {"text"=>1}
      s.type.should == "twitter"
      s.org_id.should == @organization.id
    end
  end 
    
  context "key functions" do
    it "make_word_hash" do
      s.make_word_hash("here is some more text with repeated words, like text")
      s.word_hash.should == {"text"=>2, "repeated"=>1, "words"=>1} 
    end
    it "make_bigram_hash" do
      s.make_bigram_hash("here is some more text with repeated words, like text")
      s.bigram_hash.should == {"here, is"=>1, "is, some"=>1, "some, more"=>1, "more, text"=>1, "text, with"=>1, "with, repeated"=>1, "repeated, words"=>1, "words, like"=>1, "like, text"=>1} 
    end
    it "pull_stopwords" do
      s.pull_stopwords("this is some text").should == "text"
    end
    it "sort_hash" do
      s.sort_hash(s.word_hash).should == [["words", 1], ["repeated", 1], ["text", 2]] 
    end
  end
    
end  


