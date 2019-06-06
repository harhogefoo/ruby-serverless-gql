# Ruby-Serverless-GraphQL

# Setup
```
yarn
serverless dynamodb install

bundle
gem install rubocop
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

# Test
ローカルのDynamoを使ってRSpecを実施します。

※ テスト実行時に新しいUUIDを割り振ったテストケースに対しテストを行っています。テーブル内全体を確認するのテストを行いたい場合は修正が必要です。

もし上記をやる場合は以下を参考にしてください(テスト実行時ににテーブルを作成する方法です）。

refs: https://qiita.com/yotaro/items/caff6dc4c6b6ed2b19ee

```
serverless dynamodb start
rspec
```

テスト実行毎に新しいデータが作成されるのでローカルのDynamoをこまめに終了しましょう。

