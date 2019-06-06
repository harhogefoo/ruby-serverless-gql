require 'json'
require_relative 'app/graphql/schema'

def graphql(event:, context:)
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
  puts e.message
  puts e.backtrace.inspect

  {
    statusCode: 400,
    body: JSON.generate("Bad request, please POST a request body!")
  }
end
