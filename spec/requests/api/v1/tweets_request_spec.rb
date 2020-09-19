# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Api::V1::Tweets', type: :request do

  describe 'POST api/v1/tweets' do
    let(:user) { create(:user) }
    let(:tweet) { build(:tweet) }
    let(:params) do
      {
        tweet: {
          user_id: user.id,
          content: tweet.content
        }
      }
    end
    let(:subject) { post api_v1_tweets_path, params: params}

    context 'when params are correct' do
      before { subject }

      it 'renders 201 created' do
        expect(response).to have_http_status(201)
      end

      it 'expect user have a new tweet' do
        expect(user.tweets.count).to eq(1)
      end

      it 'expect tweet params be right' do
        expect(json_body["content"]).to eq(tweet.content)
        expect(json_body["id"]).to eq(user.tweets.first.id)
        expect(json_body["user_id"]).to eq(user.id)
      end
    end

    context 'when params are incorrect' do
      let(:params) { {} }
      before { subject }

      context 'when missing params' do
        it 'returns 400 bad request' do
          expect(response).to have_http_status(400)
        end
      end

      context 'when user id not found' do
        let(:params) do
          {
              tweet: {
                  user_id: 0,
                  content: tweet.content
              }
          }
        end
        it 'returns 422 user not exist' do
          expect(response).to have_http_status(422)
          expect(json_body["errors"]["user"].first).to eq("must exist")
        end
      end

      context 'when content is missing' do
        let(:params) do
          {
              tweet: {
                  user_id: user.id
              }
          }
        end
        it 'returns 422 content missing' do
          expect(response).to have_http_status(422)
          expect(json_body["errors"]["content"].first).to eq("can't be blank")
        end
      end

      context 'when content is empty' do
        let(:params) do
          {
              tweet: {
                  content: "",
                  user_id: user.id
              }
          }
        end
        it 'returns 422 content missing' do
          expect(response).to have_http_status(422)
          expect(json_body["errors"]["content"].first).to eq("can't be blank")
        end
      end

      context 'when content is too long' do
        let(:params) do
          {
              tweet: {
                  content: Faker::Lorem.characters(number: 300),
                  user_id: user.id
              }
          }
        end
        it 'returns 422 content missing' do
          expect(response).to have_http_status(422)
          expect(json_body["errors"]["content"].first).to match(/is too long/)
        end
      end

      context 'when content is too short' do
        let(:params) do
          {
              tweet: {
                  content: Faker::Lorem.characters(number: 2),
                  user_id: user.id
              }
          }
        end
        it 'returns 422 content missing' do
          expect(response).to have_http_status(422)
          expect(json_body["errors"]["content"].first).to match(/is too short/)
        end
      end
    end
  end
end
