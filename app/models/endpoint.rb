class Endpoint < ActiveRecord::Base
  attr_accessible :type, :name, :username, :path, :authentication_id, :address, :password
  validates :name, presence: true
  validates :type, presence: true

  has_many :content_layout_endpoints

  has_paper_trail

  def publish
    raise "NOT IMPLEMENTED"
  end

end
