
require 'rubygems'
require 'twitter'

puts Twitter.rate_limit_status.remaining_hits.to_s + " Twitter API request(s) remaining this hour"

#puts Twitter.user(16483617).favourites_count
#puts Twitter.user(16483617)
#puts Twitter.favorites('sayemislam').first.user.id
