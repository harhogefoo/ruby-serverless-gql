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

  describe 'memo#create' do
    let(:query_string) { %(mutation { createMemo(memo: { title: "新しいタイトル", name: "名前" }) { title name errors } }) }

    context 'when no memo' do
      let(:context) { { user_id: SecureRandom.uuid } }

      it 'is created' do
        expect(result['data']['createMemo']).to(
          eq('errors' => nil, 'name' => '名前', 'title' => '新しいタイトル')
        )
      end
    end
  end
end
