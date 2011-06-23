class Techpeeps < ActiveRecord::Base
  serialize :tweets
  serialize :last_tweet

  def self.daily    
  end

  def self.weekly
  end
end
