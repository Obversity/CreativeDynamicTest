module Utilities
  def get_remote_csv(url)
    require 'csv'
    require 'open-uri'
    csv_text = open(url).read
    CSV.parse(csv_text, :headers => true)
  end
end