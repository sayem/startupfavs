class HomeController < ApplicationController
  def index
    favs = Array.new
    Techpeeps.all.each do |techpeep|
      username = techpeep.username
      picture = techpeep.picture
      tweets = techpeep.tweets
      tweets.each {|x| x.push(username, picture) }
      favs.push(tweets)
    end
    favs.flatten!(1)
    favs.sort! {|a,b| -1*(a[3].to_i <=> b[3].to_i) }
    @favs = favs
  end
end
