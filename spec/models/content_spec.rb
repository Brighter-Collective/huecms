# == Schema Information
#
# Table name: contents
#
#  id           :integer          not null, primary key
#  name         :string(255)
#  folder_id    :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  user_id      :integer
#  published    :boolean          default(FALSE)
#  needs_review :boolean          default(FALSE)
#

require 'spec_helper'

describe Content do

  let!(:admin) { FactoryGirl.create(:admin) }
  let(:content) { FactoryGirl.create(:content, user: admin) }

  subject { content }

  it { should respond_to(:user) }
  it { should respond_to(:name) }
  it { should respond_to(:folder) }
  it { should respond_to(:content_layouts) }
  it { should respond_to(:publish) }

  it { should be_valid }

  describe "when user_id is not present" do
    before { content.user_id = nil }
    it { should_not be_valid }
  end

  describe "when name is not present" do
    before { content.name = " " }
    it { should_not be_valid }
  end
end
