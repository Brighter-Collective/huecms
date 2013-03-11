Layout.create(name: "Facebook Wall Post",
              content: '<content type="text">message</content>'+
                       '<content type="text">picture</content>'+
                       '<content type="text">link</content>'+
                       '<content type="text">name</content>'+
                       '<content type="text">description</content>',
              type: "FacebookLayout")
Layout.create(name: "Twitter Status Update",
              content: '<content type="text">tweet</content>',
              type: "TwitterLayout")
Folder.create(name: "/")
u = User.new({:email => "admin@huecms.com", :password => "password", :password_confirmation => "password" })
u.role = "admin"
u.save

u2 = User.new({:email => "example@brightercollective.com", :password => "password", :password_confirmation => "password" })
u2.role = "author"
u2.save
