require 'tempfile'
require 'net/ftp'

class FtpEndpoint < Endpoint

  attr_accessible :username, :address, :path, :username, :password, :filename

  validate :path, allow_nil: false
  validate :address, presence: true
  validate :username, presence: true
  validate :password, presence: true

  def publish content

    ftp = Net::FTP.new(address)
    begin
      ftp.login(username, password)
    rescue
      ftp.passive=true
      ftp.login(username, password)
    end
    tmp = Tempfile.new(content[:filename])
    tmp.write(content[:data])
    tmp.close
    logger.debug(path + content[:path])
    folders = (path + "/" + content[:path]).split("/")
    folders.each do |folder|
      begin
        ftp.chdir(folder)
      rescue
        ftp.mkdir(folder)
        ftp.chdir(folder)
      end
    end

    ftp.puttextfile(tmp, content[:filename])

    # Upload Images
    content[:image_ids].each do |image|
      img = Image.find(image)
      ftp.putbinaryfile(img.source.path, img.source_file_name)
    end

    ftp.close
    tmp.unlink

  end
end
