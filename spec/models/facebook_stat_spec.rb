require 'spec_helper'

describe FacebookStat, '.save_facebook_data' do
  
  before do
    stub_request(:get, 'http://graph.facebook.com/SF').
      to_return(:body => fixture('facebook_graph.json'), :headers => {'Content-Type' => 'text/json; charset=utf-8'})
    stub_request(:get, 'http://graph.facebook.com/SF1').
      to_return(:body => fixture('facebook_graph_error.json'), :headers => {'Content-Type' => 'text/json; charset=utf-8'})
      @link = Factory(:facebook)
  end

  it "should create a new FacebookStat record" do
    FacebookStat.count.should == 0
    graph = @link.facebook_stats.new.save_facebook_data
    FacebookStat.count.should == 1
  end

end

describe FacebookStat, '.get_graph' do
  
  before do
    stub_request(:get, 'http://graph.facebook.com/SF').
      to_return(:body => fixture('facebook_graph.json'), :headers => {'Content-Type' => 'text/json; charset=utf-8'})
    stub_request(:get, 'http://graph.facebook.com/SF1').
      to_return(:body => fixture('facebook_graph_error.json'), :headers => {'Content-Type' => 'text/json; charset=utf-8'})
      @link = Factory(:facebook)
  end
  
  it "should request the correct resource" do
    @link.facebook_stats.new.get_graph
    a_request(:get, 'http://graph.facebook.com/SF').should have_been_made
  end

  it "should return the correct results" do
    graph = @link.facebook_stats.new.get_graph
    graph.should be_a Hash
    graph["id"].should == "48411192144"
  end  

  it "should flag if return nil" do
    @link.flag.should == 0
    graph = @link.facebook_stats.new.get_graph('http://graph.facebook.com/SF1')
    @link.reload.flag.should == 1
  end

end

describe FacebookStat, '.alter_url' do

  before do
    @link = Factory(:facebook)
  end
  
  it "should alter the url" do
    @link.facebook_stats.new.alter_url("http://www.facebook.com/SF").
      should == "http://graph.facebook.com/SF"
  end

  it "return nil if their is a problem with the link" do
    @link.facebook_stats.new.alter_url("http://www.facebook.com/").
      should == nil
  end  

end
