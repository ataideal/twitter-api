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
    let(:subject) { post api_v1_tweets_path, params: params }

    context 'when params are correct' do
      before { subject }

      it 'renders 201 created' do
        expect(response).to have_http_status(201)
      end

      it 'expect user have a new tweet' do
        expect(user.tweets.count).to eq(1)
      end

      it 'expect tweet params be right' do
        expect(json_body['content']).to eq(tweet.content)
        expect(json_body['id']).to eq(user.tweets.first.id)
        expect(json_body['user']['id']).to eq(user.id)
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
        it 'returns 422 user not exist and a message error' do
          expect(response).to have_http_status(422)
          expect(json_body['errors']['user'].first).to eq('must exist')
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
        it 'returns 422 content missing and a message error' do
          expect(response).to have_http_status(422)
          expect(json_body['errors']['content'].first).to eq("can't be blank")
        end
      end

      context 'when content is empty' do
        let(:params) do
          {
            tweet: {
              content: '',
              user_id: user.id
            }
          }
        end
        it 'returns 422 content missing and a message error' do
          expect(response).to have_http_status(422)
          expect(json_body['errors']['content'].first).to eq("can't be blank")
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
        it 'returns 422 content missing and a message error' do
          expect(response).to have_http_status(422)
          expect(json_body['errors']['content'].first).to match(/is too long/)
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
        it 'returns 422 content missing and a message error' do
          expect(response).to have_http_status(422)
          expect(json_body['errors']['content'].first).to match(/is too short/)
        end
      end
    end
  end

  describe 'GET api/v1/tweets' do
    let(:user) { create(:user) }
    let!(:tweets) { create_list(:tweet, 5, user: user) }
    let(:params) { { user_id: user.id } }
    let(:subject) { get api_v1_tweets_path(params) }

    context 'when params are correct' do
      context 'returns successfully' do
        before { subject }

        it 'render 200 ok' do
          expect(response).to have_http_status(200)
        end

        it 'expect response to be an array' do
          expect(json_body).to be_an Array
        end
      end

      context 'when user published a twitter' do
        before { subject }

        it 'expect response to match size' do
          expect(json_body.size).to eq(5)
        end

        it 'expect response to match user tweet' do
          expect(json_body).to include(*JSON.parse(serialize_object(tweets)))
        end
      end

      context 'when user and a following published a twitter' do
        let(:user_follow) { create(:user_follow, follower: user) }
        let!(:following_tweets) { create_list(:tweet, 5, user: user_follow.following) }

        it 'expect response to match size' do
          subject
          expect(json_body.size).to eq(10)
        end

        it 'expect response to match user tweet feed' do
          subject
          expect(json_body).to include(*JSON.parse(serialize_object(tweets)))
          expect(json_body).to include(*JSON.parse(serialize_object(following_tweets)))
        end
      end
    end

    context 'when params are incorrect' do
      let(:params) { {} }
      before { subject }

      context 'when user id not found' do
        it 'returns 404 user not found' do
          expect(response).to have_http_status(404)
        end
      end
    end
  end
end
