# Connect to specific Elasticsearch cluster
Elasticsearch::Model.client = Elasticsearch::Client.new hosts: [
  {
    host: ENV['ES_HOST'] || 'localhost',
    port: ENV['ES_PORT'] || '9200',
    user: ENV['ES_USER'] || 'elastic',
    password: ENV['ES_PASs'] || 'changeme',
    scheme: 'http'
  }
]

# Print Curl-formatted traces in development into a file
#
if Rails.env.development?
  tracer = ActiveSupport::Logger.new('log/elasticsearch.log')
  tracer.level =  Logger::DEBUG

  Elasticsearch::Model.client.transport.tracer = tracer
end
