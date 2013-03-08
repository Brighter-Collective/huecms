app = FbGraph::Application.new(ENV['FB_APP_ID'], secret: ENV['FB_APP_SECRET'])
app.test_users.collect(&:destroy)
fb_user = app.test_user!(:installed => true, :permissions => "read_stream,manage_pages")

FactoryGirl.define do
  factory :user do
    sequence(:email) { |n| "person_#{n}@example.com" }
    password "password"
    password_confirmation "password"

    factory :admin do
      role 'admin'
    end
  end

  factory :ftp_endpoint do
    name "Example FtpEndpoint"
    username "example_user"
    type "FtpEndpoint"
    address 'localhost'
    path "/var/www/"
  end

  factory :facebook_endpoint do
    name "Example FacebookEndpoint"
    type "FacebookEndpoint"
    authentication
  end

  factory :layout do
    name "Example Layout"
    type "HtmlLayout"
    content "<html>\n" +
               "<head>\n" +
                 "<title>Example Title</title>\n"+
               "</head>\n" +
               "<body>\n" +
                 "<content type=\"text\">header</content>\n" +
                 "<content type=\"text\">main</content>\n" +
                 "<content type=\"image\">image</content>\n" +
                 "<content type=\"text\">footer</content>\n" +
               "</body>\n" +
             "</html>\n"
  end

  factory :content do
    name "Example Content"
    user
  end

  factory :folder do
    name "Example Folder"
  end

  factory :content_layout do
    name "index.html"
    layout
    content
    data "{
            \"header\":\"header data\",
            \"main\":\"main data\",
            \"footer\":\"footer data\"
          }"
  end

  factory :authentication do

    factory :facebook do
      provider "facebook"
      uid fb_user.identifier
      token fb_user.access_token
    end
  end
end
