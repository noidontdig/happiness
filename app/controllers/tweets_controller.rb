class TweetsController < ApplicationController
  # GET /users
  # GET /users.json
  def index
    @tweets = Tweet.all
    @tweet_cloud = Tweet.tweet_cloud
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @users }
    end
  end
end
