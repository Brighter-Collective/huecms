class ContentLayout < ActiveRecord::Base
  attr_accessible :name,
                  :data,
                  :layout,
                  :content,
                  :layout_id,
                  :content_id,
                  :source,
                  :content_layout_endpoints_attributes,
                  :published
  belongs_to :content
  belongs_to :layout

  has_many :endpoints, through: :content_layout_endpoint
  has_many :content_layout_endpoints
  has_many :comments, :as => :commentable

  has_many :images

  serialize :data, JSON

  validates :name, presence: true
  validates :layout_id, presence: true
  validates :content_id, presence: true

  accepts_nested_attributes_for :content_layout_endpoints, :allow_destroy => true


  def source=(src)
    if src && src.kind_of?(Hash)
      src.each do |tag, img|
        images.build(:source => img, :content_tag_name => tag.dup)
      end
    end
  end

  before_save :check_data, :make_image_tags

  has_paper_trail

  def check_data
    if data_changed?
      self.published = false
      return true
    end
  end

  def make_image_tags
    images.each do |img|
      if !data.has_key?(img.content_tag_name)
        data[img.content_tag_name] = "<img src='" + img.source.original_filename + "' />"
      end
    end
  end

  def publish path=nil, filename=nil
    content_layout_endpoints.each do |p|
      case p.endpoint.type
      when "FacebookEndpoint", "TwitterEndpoint"
        data = self.data
      else
        data = { path: (!path.blank?) ? path : self.content.path,
                 filename: (!filename.blank?) ? filename : self.name, 
                 data: layout.combine(self.data),
                 image_ids: image_ids }
      end
      p.endpoint.publish(data)
    end
    update_attributes(published:true)
  end

  def publishable?
    return content_layout_endpoints.count > 0
  end
  
end
