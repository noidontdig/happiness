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

  def tweet_cloud
    common_words = File.open('lib/common_words.txt','r').read.encode!('UTF-8','UTF-8', :invalid => :replace).split("\n")
    tweet_str = ""
    self.tweets.each do |tweet|
      tweet_str << tweet.text << " " 
    end
    words = tweet_str.split
    words.map!{|c| c.downcase.strip}
    words.map!{|c| c.gsub(/[^a-z0-9\-]/,'') }
    word_counts = Hash.new(0)
    words.each do |word|
      word_counts[word] += 1
    end
    common_words.each do |word|
      word_counts.delete(word)
      word_counts.delete('')
    end
    word_counts = word_counts.sort_by {|word,count| count}.reverse
  end
end
