class ContentNotificationsMailer < ActionMailer::Base
  default from: "webmaster@brightercollective.com"
  
  def content_reviewable(email, content_id)
   @id = content_id
   mail :to => email, :subject => "Content Needs Review!"
  end
  
  def content_published(content)
   @id = content.id
   mail :to => content.user.email, :subject => "Your Content Has Been Published!"
  end
end
