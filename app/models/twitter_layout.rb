class TwitterLayout < Layout

  def endpoints
    ret = []
    ret << TwitterEndpoint.all
    return ret
  end

  def combine data
    data
  end

end
