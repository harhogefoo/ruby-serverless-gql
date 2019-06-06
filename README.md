# Ruby-Serverless-GraphQL

# Setup
```
yarn
serverless dynamodb install

bundle
```

# Local Debugging
```
serverless dynamodb start
yarn dev
```

# Quit Local DynamoDB
```
lsof -i :8000 -t | xargs kill
```
