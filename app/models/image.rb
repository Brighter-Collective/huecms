class Image < ActiveRecord::Base
  attr_accessible :source, :content_tag_name

  belongs_to :content_layout

  validates_format_of :source, :with => %r{\.(png|jpg|jpeg)$}i, :message => "We only support .png .jpg & .jpeg image uploads"

  has_attached_file :source

end
