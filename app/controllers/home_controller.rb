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
    favs.delete_if {|x| x == [] }
    favs.sort! {|a,b| -1*(a[3] <=> b[3]) }
    @favs = favs
  end
end
