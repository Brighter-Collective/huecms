require 'spec_helper'

describe "Content pages" do

  subject { page }

  describe "not signed in" do
    before { visit contents_path }

    it { should have_selector('title', text: 'Sign in') }
  end

  describe "signed in as author" do
    let(:author) { FactoryGirl.create(:user) }
    before { sign_in author }

    describe "index" do

      before { visit contents_path }

      it { should have_selector('title', text: 'Content Management') }
      it { should have_selector('h1',    text: 'Content Management') }
      it { should have_link('Add new content', href: new_content_path) }
    end

    describe "content creation" do
      before do
        visit new_content_path
      end

      describe "with invalid information" do
        it "should not create a content" do
          expect { click_button "Create Content" }.not_to change(Content, :count)
        end

        describe "after submission" do
          before { click_button "Create Content" }

          it { should have_selector('title', text: 'New Content') }
          it { should have_content('error') }
        end
      end

      describe "with valid information" do
        before do
          fill_in "Name", with: "Example Content"
        end

        it "should create a content" do
          expect { click_button "Create Content" }.to change(Content, :count)
          should have_content("Add Layout")
        end
      end
    end
  end

  describe "signed in as admin" do
    let(:admin) { FactoryGirl.create(:admin) }
    let(:content) { FactoryGirl.create(:content) }
    let(:endpoint) { FactoryGirl.create(:server_endpoint) }
    let(:layout) { FactoryGirl.create(:layout) }
    let!(:content_layout) { FactoryGirl.create(:content_layout,
                                               layout: layout,
                                               content: content,
                                               endpoint: endpoint) }

    before { sign_in admin }

    describe "index" do

      before { visit contents_path }

      it { should have_selector('title', text: 'Content Management') }
      it { should have_selector('h1',    text: 'Content Management') }
      it { should have_link('Add new content', href: new_content_path) }
      it { should have_link('publish') }

      describe "publish content to file system" do
        before do
          click_link "publish"
        end
      end
    end

    describe "edit" do

      let!(:content) { FactoryGirl.create(:content) }

      before do
        visit edit_content_path(content)
      end

      describe "page" do
        it { should have_selector('title', text: 'Edit Content') }
        it { should have_selector('h1', text: 'Edit Content') }
      end


      describe "with invalid information" do
        before do
          fill_in "Name", with: " "
          click_button "Update Title"
        end

        it { should have_content('error') }
      end

      describe "with valid information" do

        describe "after submission" do
          let(:new_name) { "New Name" }
          let(:new_content) { "New Content" }

          before do
            fill_in "Name", with: new_name
            click_button "Update Title"
          end

          it { should have_selector('title', text: 'Edit Content') }
          it { should have_selector('h1', text: 'Edit Content') }
          specify { content.reload.name.should == new_name }
        end
      end
    end
  end
end
