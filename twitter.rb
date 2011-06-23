require 'rubygems'
require 'twitter'


#puts Twitter.user(16483617).favourites_count

#puts Twitter.user(16483617)

#puts Twitter.user('sayemislam')


puts Twitter.favorites('sayemislam')


=begin
Twitter.favorites('sayemislam').each do |x| 
  puts x.text
  puts x.user.id
end
=end
