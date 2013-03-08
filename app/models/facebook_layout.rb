class FacebookLayout < Layout

  def endpoints
    ret = []
    ret << FacebookEndpoint.all
    return ret
  end

  def combine data
    data
  end
end
