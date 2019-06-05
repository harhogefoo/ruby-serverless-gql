require 'json'
require_relative 'app/graphql/schema'

def graphql(event:, context:)
  body = JSON.parse(event["body"])
  query = body["query"]
  variables = body["variables"]
  operation_name = body["operationName"]

  body = Schema.execute(
    query: body["query"],
    variables: body["variables"],
    operation_name: body["operationName"]
  )

  {
    statusCode: 200,
    body: JSON.generate(body)
  }
rescue StandardError => e
  puts e.message
  puts e.backtrace.inspect

  {
    statusCode: 400,
    body: JSON.generate("Bad request, please POST a request body!")
  }
end
