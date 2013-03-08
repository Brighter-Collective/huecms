# == Schema Information
#
# Table name: images
#
#  id                  :integer          not null, primary key
#  content_layout_id   :integer
#  content_tag_name    :string(255)
#  source_file_name    :string(255)
#  source_content_type :string(255)
#  source_file_size    :string(255)
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#

require 'spec_helper'

describe Image do
  pending "add some examples to (or delete) #{__FILE__}"
end
