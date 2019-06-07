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

  describe 'memo#index' do
    let(:query_string) { %({ memos { title name errors } }) }

    context 'when no memo' do
      let(:context) { { user_id: SecureRandom.uuid } }

      it 'is []' do
        expect(result['data']['memos']).to eq([])
      end
    end

    context 'when has a memo' do
      let(:user_id) { SecureRandom.uuid }
      let(:context) { { user_id: user_id } }
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

      it 'has one' do
        expect(result['data']['memos']).to(
          eq([{ 'errors' => nil, 'name' => '名前', 'title' => 'タイトル' }])
        )
      end
    end
  end

  describe 'memo#show' do
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

    let(:query_string) { %({ memo(id: "#{uuid}") { title name errors } }) }

    context "when there's no user id" do
      it 'is nil' do
        expect(result['data']['memo']['errors']).to eq(['user_id was not set'])
      end
    end

    context "when there's a current user" do
      let(:context) { { user_id: user_id } }

      context "when there's one memo(uuid is matched)" do
        it 'shows the memo' do
          expect(result['data']['memo']).to(
            eq('errors' => nil, 'name' => '名前', 'title' => 'タイトル')
          )
        end
      end

      context "when there's no memo(uuid is not matched)" do
        let(:query_string) { %({ memo(id: "notmatcheduuid") { title name errors } }) }

        it "doesn't show the memo" do
          expect(result['data']['memo']).to(
            eq('errors' => nil, 'name' => nil, 'title' => nil)
          )
        end
      end
    end
  end
end
