require 'aws-record'

class Memo
  include Aws::Record

  # TODO: テーブル名は環境変数化
  set_table_name 'memo'
  string_attr :id, hash_key: true
  string_attr :user_id, range_key: true
  string_attr :title
  string_attr :name
  string_attr :description
  string_attr :url
end
