class Layout < ActiveRecord::Base
  attr_accessible :name, :content, :type

  validates :name, presence: true
  validates :type, presence: true

  has_many :content_layouts

  has_paper_trail

  def get_fields
    read_attribute(:content).scan(/<content type=\"(image|text)\">([\w|\s]*?)<\/content>/)
  end

  # def endpoints
  #   raise "NOT IMPLEMENTED"
  # end

  def combine data
    raise "NOT IMPLEMENTED"
  end
end
