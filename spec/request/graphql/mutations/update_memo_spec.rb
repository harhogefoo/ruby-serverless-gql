# frozen_string_literal: true

require 'aws-sdk-core'

require_relative '../../../../app/graphql/schema'

RSpec.describe Schema do
  let!(:client) { Aws::DynamoDB::Client.new }
  let(:uuid) { SecureRandom.uuid }
  let(:user_id) { 'hogehoge' }
  let(:context) { {} }
  let(:variables) { {} }
  let(:result) do
    res = Schema.execute(
      query_string,
      context: context,
      variables: variables
    )
    pp res if res['errors']
    res
  end

  describe 'memo#update' do
    before do
      client.put_item(
        table_name: 'memo',
        item: {
          id: uuid,
          user_id: user_id,
          title: 'タイトル',
          name: '名前'
        }
      )
    end

    let(:query_string) do
      %(mutation { updateMemo(memo: { id: "#{uuid}", title: "更新されたタイトル", name: "名前" }) { title name errors } })
    end

    context 'when no memo' do
      let(:context) { { user_id: SecureRandom.uuid } }

      it 'is not updated' do
        expect(result['data']['updateMemo']).to(
          eq({"title"=>nil, "name"=>nil, "errors"=>["memo not found"]})
        )
      end
    end

    context 'when a memo' do
      let(:context) { { user_id: user_id } }
      it 'is updated' do
        expect(result['data']['updateMemo']).to(
          eq({"errors"=>nil, "name"=>"名前", "title"=>"更新されたタイトル"})
        )
      end
    end
  end
end
