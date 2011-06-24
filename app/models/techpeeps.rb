require 'rubygems'
require 'twitter'

class Techpeeps < ActiveRecord::Base
  serialize :tweets
  serialize :last_tweet

  def self.daily
    Techpeeps.limit(3).each do |techpeep|
      user = Twitter.user(techpeep.twitter_id.to_i)
      if user.favourites_count != techpeep.count
        current_fav = techpeep.last_tweet[1]
        favs = Twitter.favorites(techpeep.twitter_id.to_i)

        latest_fav_id = favs.first.user.id
        latest_fav = favs.first.text
        techpeep.last_tweet = [latest_fav_id, latest_fav]

        tweets = favs.collect {|x| x.text }
        index = tweets.index(current_fav).to_i
        favs.slice!(index..-1)
        favs.collect! {|x| [x.user.screen_name, x.user.profile_image_url, x.text, Time.now.strftime("%m/%d/%Y")] }
        techpeep.tweets = techpeep.tweets + favs
        techpeep.count = user.favourites_count
        techpeep.save
      end
    end
  end

  def self.weekly
    Techpeeps.limit(50).each do |techpeep|
      techpeep.tweets = []
      user = Twitter.user(techpeep.twitter_id.to_i)
      name = user.screen_name
      pic = user.profile_image_url
      if name != techpeep.username
        techpeep.username = name
      end
      if pic != techpeep.picture
        techpeep.picture = pic
      end
      techpeep.save
    end
  end
end
