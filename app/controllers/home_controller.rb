class HomeController < ApplicationController
  def index
    @favs = Marshal.load($redis.get('startupfavs'))
  end
end
