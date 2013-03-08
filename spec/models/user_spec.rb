# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  username               :string(255)
#  first_name             :string(255)
#  middle_name            :string(255)
#  last_name              :string(255)
#  role                   :string(255)
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  email                  :string(255)      default(""), not null
#  encrypted_password     :string(255)      default(""), not null
#  reset_password_token   :string(255)
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0)
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string(255)
#  last_sign_in_ip        :string(255)
#

require 'spec_helper'

describe User do

  let(:user) { FactoryGirl.create(:user) }

  subject { user }

  it { should respond_to(:contents) }
  it { should respond_to(:email) }
  it { should respond_to(:first_name) }
  it { should respond_to(:last_name) }
  it { should respond_to(:role) }

  it { should be_valid }

  it "does the json correctly" do
    get :sign_in, :format => json
    response.should be_success
    body = JSON.parse(response.body)
    puts "&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&"
    puts "&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&"
    puts body
    puts "&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&"
    
  end
end
