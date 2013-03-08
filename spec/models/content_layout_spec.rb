# == Schema Information
#
# Table name: content_layouts
#
#  id          :integer          not null, primary key
#  name        :string(255)
#  data        :text
#  endpoint_id :integer
#  layout_id   :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  content_id  :integer
#  published   :boolean
#

require 'spec_helper'

describe ContentLayout do

  let!(:admin) { FactoryGirl.create(:admin) }
  let(:endpoint) { FactoryGirl.create(:ftp_endpoint) }
  let(:layout) { FactoryGirl.create(:layout) }
  let(:content) { FactoryGirl.create(:content, user: admin) }
  let!(:content_layout) { FactoryGirl.create(:content_layout,
                                             layout: layout,
                                             content: content) }

  subject { content_layout }

  it { should respond_to(:name) }
  it { should respond_to(:content) }
  it { should respond_to(:layout) }
  it { should respond_to(:data) }
  it { should respond_to(:process) }

  it { should be_valid }

  describe "when name is not present" do
    before { content_layout.name = " " }
    it { should_not be_valid }
  end

  describe "when endpoint_id is not present" do
    before { content_layout.endpoint_id = nil }
    it { should_not be_valid }
  end

  describe "when layout_id is not present" do
    before { content_layout.layout_id = nil }
    it { should_not be_valid }
  end

  describe "when content_id is not present" do
    before { content_layout.content_id = nil }
    it { should_not be_valid }
  end
end
