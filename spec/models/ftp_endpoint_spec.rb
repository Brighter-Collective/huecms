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

describe FtpEndpoint do
  let!(:ftp_endpoint) { FactoryGirl.create(:ftp_endpoint) }

  subject { ftp_endpoint }

  it { should respond_to(:name) }
  it { should respond_to(:type) }
  it { should respond_to(:username) }
  it { should respond_to(:path) }
  it { should respond_to(:address) }

  it { should be_valid }

  describe "with blank category" do
    before { ftp_endpoint.category = " " }
    it { should_not be_valid }
  end

  describe "with blank path" do
    before { ftp_endpoint.path = " " }
    it { should_not be_valid }
  end

  describe "with blank name" do
    before { ftp_endpoint.name = " " }
    it { should_not be_valid }
  end

  describe "with blank username" do
    before { ftp_endpoint.username = " " }
    it { should_not be_valid }
  end

  describe "with blank address" do
    before { ftp_endpoint.address = " " }
    it { should_not be_valid }
  end
end
