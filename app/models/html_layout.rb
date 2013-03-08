class HtmlLayout < Layout

  validates :content, presence: true

  def endpoints
    ret = []
    ret << FtpEndpoint.all
    return ret
  end

  def model_name
    return "layout"
  end

  def combine data
    # data = data || {}
    ret = content.dup
    content.scan(/<content type=\"(text|image)\">([\w|\s]*?)<\/content>/) do |x|
      if (x.first == "text")
        ret.gsub!('<content type="text">' + x.second + '</content>', data[x.second] || "" )
      elsif (x.first == "image")
        ret.gsub!('<content type="image">' + x.second + '</content>', data[x.second] || "" )
      end
    end
    return ret
  end
end
