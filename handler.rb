# frozen_string_literal: true

require 'json'
require 'aws-sdk-core'
require_relative 'app/graphql/schema'

def graphql(event:, context:)
  Aws.config.update(endpoint: 'http://localhost:8000') if event['isOffline']

  body = JSON.parse(event['body'])

  user_id = event['headers']['x-user-id'] # MEMO: 外部システムとして切り出す場合、JWTトークン検証などを行う必要がある

  result = Schema.execute(
    query: body['query'],
    variables: body['variables'],
    operation_name: body['operationName'],
    context: { user_id: user_id }
  )

  {
    statusCode: 200,
    headers: {
      'Access-Control-Allow-Origin' => '*'
    },
    body: JSON.generate(result)
  }
rescue StandardError => e
  puts e.full_message
  puts e.backtrace.inspect

  {
    statusCode: 400,
    headers: {
      'Access-Control-Allow-Origin' => '*'
    },
    body: JSON.generate('Bad request, please POST a request body!')
  }
end
