require 'spec_helper'

describe "Dashboard pages" do

  subject { page }

  let(:admin) { FactoryGirl.create(:admin) }
  before { sign_in admin }

  describe "index" do
    before { visit root_path }

    it { should have_selector('title', text: 'Dashboard') }
    it { should have_selector('h1',    text:'Dashboard') }
  end
end
