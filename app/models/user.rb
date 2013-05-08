class User < ActiveRecord::Base
  attr_accessible :name, :nickname, :secret, :token, :uid, :email

  has_many :tweets

  def self.from_omniauth(auth)
    User.find_by_uid(auth["uid"]) || new_from_omniauth(auth)
  end

  def self.new_from_omniauth(auth)
    User.new(
      uid: auth["uid"],
      name: auth["info"]["name"],
      nickname: auth["info"]["nickname"],
      token: auth["credentials"]["token"],
      secret: auth["credentials"]["secret"]
    )
  end

  def past_week_tweets
    self.tweets.select{ |t| Date.today - t.time.in_time_zone('Eastern Time (US & Canada)').to_date < 7 }.reverse
  end

  def self.grab_tweets
    User.all.each do |user|
      results = []
      query = "from:#{user.nickname} #thankful"
      tweets = Twitter.search(query).results
      tweets.each do |t|
        Tweet.find_or_create_by_t_id(t_id: t[:id], user_id: user.id, text: t[:text], time: t[:created_at])
      end
    end
  end

  def most_thankful_day
    days = Hash.new(0)
    self.tweets.each do |tweet|
      days[tweet.time.in_time_zone('Eastern Time (US & Canada)').strftime("%A")] += 1     
    end
    days.sort_by{ |day,count| count }.last
  end

  def most_thankful_time
    times = Hash.new(0)
    self.tweets.each do |tweet|
      times[tweet.time.in_time_zone('Eastern Time (US & Canada)').strftime("%l %p")] += 1     
    end
    times.sort_by{ |time,count| count }.last
  end
end
