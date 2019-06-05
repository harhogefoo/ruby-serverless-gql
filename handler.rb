require 'json'

def hello(event:, context:)
  { statusCode: 200, body: JSON.generate('Go Serverless v1.0! Your function executed successfully!') }
end

def graphql(event:, context:)
  {
    statusCode: 200, body: JSON.generate('This is GraphQL ruby')
  }
end
