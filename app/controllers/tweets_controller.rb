class TweetsController < ApplicationController
  # GET /users
  # GET /users.json
  def index
    tweets = Twitter.search("#thankful", count: 100).results
    @tweet_cloud = Tweet.tweet_cloud(tweets)
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @users }
    end
  end
end
