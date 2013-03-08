class Authentication < ActiveRecord::Base
  attr_accessible :provider, :uid

  def set_username
    if provider == "facebook"
      update_attribute(:username, FbGraph::User.me(token).fetch.name)
    elsif provider == "twitter"
      update_attribute(:username, Twitter::Client.new(consumer_key: ENV['TWITTER_CONSUMER_KEY'],
                                                      consumer_secret: ENV['TWITTER_CONSUMER_SECRET'],
                                                      oauth_token: token,
                                                      oauth_token_secret: secret).user.name)
    end
  end

end
