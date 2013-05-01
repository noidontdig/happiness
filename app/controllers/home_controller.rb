class HomeController < ApplicationController
  
  def index
    @tweets = []
    Twitter.search("#thankful", count: 10).results.map do |result|
      @tweets << result
    end
  end

  def about

  end
end
