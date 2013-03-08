# == Schema Information
#
# Table name: endpoints
#
#  id                :integer          not null, primary key
#  name              :string(255)
#  type              :string(255)
#  username          :string(255)
#  path              :string(255)
#  created_at        :datetime
#  updated_at        :datetime
#  authentication_id :integer
#  address           :string(255)
#  password          :string(255)
#  filename          :string(255)
#

require 'spec_helper'

describe FacebookEndpoint do
  let!(:authentication) { FactoryGirl.create(:facebook) }
  let!(:facebook) { FactoryGirl.create(:facebook_endpoint,
                                       authentication: authentication) }

  subject { facebook }

  it { should respond_to(:name) }
  it { should respond_to(:type) }
  it { should respond_to(:authentication) }

  it { should be_valid }

  describe "with blank type" do
    before { facebook.type  = " " }
    it { should_not be_valid }
  end

  it { facebook.authentication.provider.should == "facebook" }

  describe "with blank name" do
    before { facebook.name = " " }
    it { should_not be_valid }
  end
end
