require 'spec_helper'
require 'rubygems'
require 'twitter'

describe Techpeeps do

  techpeep = Techpeeps.new(:twitter_id => '16483617', :count => '3', :tweets => ['some random tweet', 'some random tweet'], :username => 'sayemislam', :picture => 'http://a2.twimg.com/profile_images/1138396798/sayem-twitter_normal.jpg')

  it "should check favorite count" do


    techpeep.should have(0) .errors_on(:twitter_id)
  end

end
