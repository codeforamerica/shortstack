require 'spec_helper'

describe CompeteStat do
  
  before do
    stub_request(:get, "http://api.compete.com/fast-cgi/MI?apikey=&d=google.com&size=small&ver=3").
    to_return(:status => 200,:body => fixture('compete.xml'), :headers => {'Content-Type' => 'text/xml; charset=utf-8'})

    stub_request(:get, "http://api.compete.com/fast-cgi/MI?apikey=&d=f&size=small&ver=3").
    to_return(:status => 200,:body => fixture('compete_invalid.xml'), :headers => {'Content-Type' => 'text/xml; charset=utf-8'})

    @link = Factory(:link, :link_url => 'google.com')  
    @bad_link = Factory(:link, :link_url => 'f')      
  end

  it "should request the correct resource" do
    s = CompeteStat.new(@link)
    s.get_compete_score.should == 150571274
  end
  
  it "should return nil on bad url" do
    s = CompeteStat.new(@bad_link)
    s.get_compete_score.should == nil
  end
  
  it "should create a statistic" do
    s = CompeteStat.new(@link)
    stat = s.create_statistic
    stat.should.class == Statistic
    stat.value == 150571274
    
  end

  
end


