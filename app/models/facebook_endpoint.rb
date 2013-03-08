class FacebookEndpoint < Endpoint
  attr_accessible :authentication_id
  belongs_to :authentication
  validates :authentication_id, presence: true

  def publish data
    fb_user = FbGraph::User.me(authentication.token)
    fb_user.feed!(
      message: data["message"],
      picture: data["picture"],
      link: data["link"],
      name: data["name"],
      description: data["description"])
  end
end
