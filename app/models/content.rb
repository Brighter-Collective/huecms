class Content < ActiveRecord::Base
  attr_accessible :name, :folder, :needs_review
  attr_protected :published

  belongs_to :folder
  belongs_to :user
  has_many :content_layouts, dependent: :destroy
  has_many :comments, :as => :commentable

  validates :user, presence: true
  validates :name, presence: true, allow_blank: false

  after_update :send_notification_emails

  def publish
    content_layouts.each do |c|
      c.publish
    end
  end
  def publishable?
    content_layouts.each do |c|
      return false if not c.publishable?
    end
    return true
  end
  def send_notification_emails
    @admins = User.where(:role => "admin")
    @admins.each do |admin|
      ContentNotificationsMailer.content_reviewable(admin.email, self.id).deliver if (self.needs_review && self.needs_review_changed?)
    end
  end

  def path
    path = ""
    folder = self.folder
    while folder.parent != nil do
      path = "/" + folder.name + path
      folder = folder.parent
    end
    path
  end
end
