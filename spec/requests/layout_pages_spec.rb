require 'spec_helper'

describe "Layout pages" do

  subject { page }

  describe "not signed in" do
    before { visit layouts_path }

    it { should have_selector('title', text: 'Sign in') }
  end

  describe "signed in" do
    let(:admin) { FactoryGirl.create(:admin) }
    before { sign_in admin }

    describe "index page" do
      before { visit layouts_path }

      it { should have_selector('title', text: 'Layouts') }
      it { should have_selector('h1',    text: 'Layouts') }
      it { should have_link('Add Layout', href: new_layout_path) }
    end

    describe "layout creation" do
      before do
        visit new_layout_path
      end

      describe "with invalid information" do
        it "should not create a layout" do
          expect { click_button "Create Layout" }.not_to change(Layout, :count)
        end

        describe "after submission" do
          before { click_button "Create Layout" }

          it { should have_selector('title', text: 'New Layout') }
          it { should have_content('error') }
        end
      end

      describe "with valid information" do
        before do
          fill_in "Name", with: "Example Layout"
        end

        it "should create a layout" do
          expect { click_button "Create Layout" }.to change(Layout, :count)
          should have_selector("h1", text: 'Layouts')
          should have_link('delete')
        end
      end
    end

    describe "edit" do

      let!(:layout) { FactoryGirl.create(:layout) }

      before do
        visit edit_layout_path(layout)
      end

      describe "page" do
        it { should have_selector('title', text: 'Edit Layout') }
        it { should have_selector('h1', text: 'Edit Layout') }
      end


      describe "with invalid information" do
        before do
          fill_in "Name", with: " "
          click_button "Save"
        end

        it { should have_content('error') }
      end

      describe "with valid information" do

        describe "after submission" do
          let(:new_name) { "New Name" }
          let(:new_content) { "New Content" }

          before do
            fill_in "Name",    with: new_name
            fill_in "layout[content]", with: new_content
            click_button "Save"
          end

          it { should have_selector('title', text: 'Layouts') }
          it { should have_selector('h1', text: 'Layouts') }
          it { should have_link('delete') }
          specify { layout.reload.name.should == new_name }
          specify { layout.reload.content.should == new_content }
        end
      end
    end
  end
end
