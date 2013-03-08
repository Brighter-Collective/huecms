namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    make_users
    make_content
    make_layouts
  end
end

def make_users
  admin = User.new(first_name: "Example",
                   last_name: "User",
                   email: "example@brightercollective.com",
                   password: "password",
                   password_confirmation: "password")
  admin.role = 'admin'
  admin.save!

  99.times do |n|
    name = Faker::Name.name.split(' ')
    email = "example-#{n+1}@brightercollective.com"
    password = "password"
    User.create!(first_name: name[0],
                 last_name: name[1],
                 email: email,
                 password: password,
                 password_confirmation: password)
  end

  def make_content
    user = User.first
    1..5.times { |n| user.contents.create!(name: "Content #{n+1}") }
  end

  def make_layouts
    Layout.create!(name: "Main",
                   type: "HtmlLayout",
                   content: "<html>
                               <head>
                                 <title>Welcome</title>
                               </head>
                               <body>
                                 <content type=\"text\">main</content>
                               </body>
                             </html>")
    Layout.create!(name: "Header and Main",
                   type: "HtmlLayout",
                   content: "<html>
                               <head>
                                 <title>About</title>
                               </head>
                               <body>
                                 <content type=\"text\"header</content>
                                 <content type=\"text\">main</content>
                               </body>
                             </html>")
    Layout.create!(name: "Blog",
                   type: "HtmlLayout",
                   content: "<html>
                               <head>
                                 <title>Blog</title>
                               </head>
                               <body>
                                 <content type=\"text\">header</content>
                                 <content type=\"text\">article</content>
                                 <content type=\"text\">comments</content>
                               </body>
                             </html>")
  end
end
