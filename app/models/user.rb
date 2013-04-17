class User < ActiveRecord::Base
  attr_accessible :name, :nickname, :secret, :token, :uid

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
end
