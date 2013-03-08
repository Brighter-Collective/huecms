if Rails.env.development?
  %w[ftp twitter facebook].each do |c|
    require_dependency File.join("app","models","#{c}_endpoint.rb")
  end
    %w[html facebook twitter].each do |c|
    require_dependency File.join("app","models","#{c}_layout.rb")
  end
end
