require 'spec_helper'

describe "Endpoint pages" do

  let(:admin) { FactoryGirl.create(:admin) }
  let!(:authentication) { FactoryGirl.create(:facebook) }

  subject { page }

  describe "not signed in" do
    before { visit endpoints_path }

    it { should have_selector('title', text: 'Sign in') }
  end

  describe "signed in" do

    before { sign_in admin }

    describe "index page" do

      let!(:endpoint) { FactoryGirl.create(:ftp_endpoint) }

      before do
        visit endpoints_path
      end

      it { should have_selector('title', text: 'Endpoints') }
      it { should have_selector('h1', text: 'Endpoints') }
      it { should have_link('edit', href: edit_endpoint_path(endpoint)) }
      it { should have_link('Add new endpoint', href: new_endpoint_path) }
    end

    describe "endpoint creation" do
      before { visit new_endpoint_path }

      describe "with invalid information" do
        it "should not create a ftp endpoint" do
          expect { click_button "Create ftp endpoint" }.not_to change(Endpoint, :count)
        end

        describe "error messages" do
          before { click_button "Create FTP endpoint"}
          it { should have_content('error') }
        end
      end

      describe "with valid information" do

        describe "ftp endpoint" do
          before do
            fill_in "endpoint[name]",     with: "Example FTP Endpoint"
            fill_in "endpoint[username]", with: "example_user"
            fill_in "endpoint[path]",     with: "/var/www/public"
            fill_in "endpoint[address]",  with: "localhost"
          end

          it "should create an endpoint" do
            expect { click_button "Create ftp endpoint" }.to change(Endpoint, :count).by(1)
          end
        end
      end
    end

    describe "edit" do

      let!(:endpoint) { FactoryGirl.create(:ftp_endpoint) }

      before do
        visit edit_endpoint_path(endpoint)
      end

      describe "page" do
        it { should have_selector('title', text: 'Edit Endpoint') }
        it { should have_selector('h1', text: 'Edit Endpoint') }
      end


      describe "with invalid information" do
        before do
          fill_in "Name", with: " "
          click_button "Save endpoint"
        end

        it { should have_content('error') }
      end

      describe "with valid information" do

        describe "after submission" do
          let(:new_name) { "New Name" }
          let(:new_address) { "123.456.789.123" }
          let(:new_path) { "/new/path/" }
          let(:new_username) { "new_username" }

           describe "ftp endpoint" do
            before do
              fill_in "endpoint[name]",     with: new_name
              fill_in "endpoint[username]", with: new_username
              fill_in "endpoint[path]",     with: new_path
              fill_in "endpoint[address]",  with: new_address
              click_button "Save endpoint"
            end

            it { should have_selector('title', text: 'Endpoints') }
            it { should have_selector('h1', text: 'Endpoints') }
            specify { endpoint.reload.name.should == new_name }
            specify { endpoint.reload.address.should == new_address }
            specify { endpoint.reload.path.should == new_path }
            specify { endpoint.reload.username.should == new_username }
          end
        end
      end
    end

    describe "endpoint destruction" do
      before do
        FactoryGirl.create(:ftp_endpoint)
        visit endpoints_path
      end

      it "should delete an endpoint" do
        expect { click_link "delete" }.to change(Endpoint, :count).by(-1)
      end
    end
  end
end
