class TwitterEndpoint < Endpoint
  attr_accessible :authentication_id
  belongs_to :authentication
  validates :authentication_id, presence: true

  def publish data
    user = Twitter::Client.new(consumer_key: ENV['TWITTER_CONSUMER_KEY'],
                               consumer_secret: ENV['TWITTER_CONSUMER_SECRET'],
                               oauth_token: authentication.token,
                               oauth_token_secret: authentication.secret)
    user.update(data["tweet"])
  end
end
