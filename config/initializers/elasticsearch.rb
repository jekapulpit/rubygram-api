if ENV.include?("PROD")
  Searchkick.client = Elasticsearch::Client.new url: ENV['BONSAI_URL']
else
  Searchkick.client = Elasticsearch::Client.new host: "http://localhost:9200"
end
