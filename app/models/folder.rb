class Folder < ActiveRecord::Base
  attr_accessible :name, :folder_id
  has_many :folders
  belongs_to :parent, class_name: 'Folder', foreign_key: 'folder_id'
  has_many :content

  def path
    path = ""
    folder = self
    while folder.parent != nil do
      path = "/" + folder.name + path
      folder = folder.parent
    end
    path
  end
end
