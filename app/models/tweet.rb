class Tweet < ActiveRecord::Base
  attr_accessible :t_id, :text, :time, :user_id

  belongs_to :user

  def self.tweet_cloud(tweets)
    common_words = File.open('lib/common_words.txt','r').read.encode!('UTF-8','UTF-8', :invalid => :replace).split("\n")
    tweet_str = ""
    tweets.each do |tweet|
      tweet_str << tweet[:text] << " " 
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
