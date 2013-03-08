class ContentLayoutEndpoint < ActiveRecord::Base
  attr_accessible :content_layout_id, :endpoint_id
  belongs_to :content_layout
  belongs_to :endpoint
end
