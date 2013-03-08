require 'tempfile'
require 'net/sftp'

class SftpEndpoint < Endpoint

  attr_accessible :username, :address, :path, :username, :password, :filename

  validate :path, allow_nil: false
  validate :address, presence: true
  validate :username, presence: true
  validate :password, presence: true

  def publish content
    tmp = Tempfile.new(content[:filename])
    tmp.write(content[:data])
    tmp.close
    Net::SFTP.start(address, username, :password => password) do |sftp|
      sftp.mkdir!(path + "/" + content[:path]) rescue
      sftp.upload!(tmp.path, path + "/" + content[:path] +"/"+ content[:filename])
    end
    tmp.unlink
  end
end
