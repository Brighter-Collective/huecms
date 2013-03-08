# == Schema Information
#
# Table name: layouts
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  content    :text
#  created_at :datetime
#  updated_at :datetime
#  type       :string(255)
#

require 'spec_helper'

describe Layout do

  let!(:layout) { FactoryGirl.create(:layout) }

  subject { layout }

  it { should respond_to(:content) }
  it { should respond_to(:name) }
  it { should respond_to(:get_fields) }

  it { should be_valid }

  describe "with name not present" do
    before { layout.name = " " }
    it { should_not be_valid }
  end
end
