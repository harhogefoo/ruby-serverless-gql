require 'json'
require 'aws-sdk-core'
require_relative 'app/graphql/schema'

def graphql(event:, context:)
  Aws.config.update(endpoint: "http://localhost:8000") if event["isOffline"]

  body = JSON.parse(event["body"])

  result = Schema.execute(
    query: body["query"],
    variables: body["variables"],
    operation_name: body["operationName"]
  )

  {
    statusCode: 200,
    headers: {
      "Access-Control-Allow-Origin" => "*"
    },
    body: JSON.generate(result)
  }
rescue StandardError => e
  p e.full_message
  #   puts e.message
  # puts e.backtrace.inspect

  {
    statusCode: 400,
    body: JSON.generate("Bad request, please POST a request body!")
  }
end
