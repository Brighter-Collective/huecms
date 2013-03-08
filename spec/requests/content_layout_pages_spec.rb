require 'spec_helper'

describe "Content Layout pages" do
  pending "add some examples to (or delete) #{__FILE__}"
  subject { page }

  let(:user) { FactoryGirl.create(:user) }
  let(:content) { FactoryGirl.create(:content, user: user) }
  let!(:endpoint) { FactoryGirl.create(:ftp_endpoint) }
  let!(:layout) { FactoryGirl.create(:layout) }

   describe "not signed in" do
    before { visit edit_content_path(content) }

    it { should have_selector('title', text: 'Sign in') }
  end

  describe "signed in" do
    before { sign_in user }

    describe "create" do
      before do
        visit edit_content_path(content)
        click_link "Add Layout"
      end

      describe "with invalid information" do
         it "should not create a block" do
          expect { click_button "Create Layout" }.not_to change(Block, :count)
        end

        describe "after submission" do
          before { click_button "Create Layout" }

          it { should have_selector('title', text: 'New Layout') }
          it { should have_selector('h1', text: 'New Layout') }
          it { should have_content('error') }
        end
      end

      describe "with valid information" do
        before do
          fill_in 'Name', with: 'Example Content Layout'
          select 'Example Layout', from: 'block_layout_id'
        end

        it "should create a block" do
          expect { click_button "Create Layout" }.to change(Block, :count)
          should have_selector('title', text: 'Edit Block')
        end
      end
    end

    describe "edit" do

      let(:new_name) { "New Name" }
      let(:new_header) { "New Header" }
      let(:new_article) { "New Article" }
      let(:new_footer) { "New Footer" }
      let(:content_layout) { FactoryGirl.create(:content_layout,
                                       endpoint: endpoint,
                                       layout: layout,
                                       content: content) }
      before do
        visit edit_content_block_path(content, block)
        fill_in 'Name', with: new_name
        fill_in 'block[data][header]', with: new_header
        fill_in 'block[data][main]', with: new_article
        attach_file 'block[source][image]', Rails.root + 'public/images/placeholder1.jpg'
        fill_in 'block[data][footer]', with: new_footer
        click_button 'Save'
      end

      it { should have_selector('title', text: 'Example Title') }
      it { should have_content(new_header) }
      it { should have_content(new_article) }
      it { should have_selector('img')}
      it { should have_content(new_footer) }
      specify { block.reload.name.should == new_name }
    end
  end
end
