# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Api::V1::Users', type: :request do
  describe 'POST api/v1/users/:id/follow' do
    let(:user) { create(:user) }
    let(:user2) { create(:user) }
    context 'when params are correct' do
      let(:params) { { following_id: user2.id } }
      before { post follow_api_v1_user_path(user), params: params }

      it 'renders 201 created' do
        expect(response).to have_http_status(201)
      end

      it 'expect user have a new following' do
        expect(user.followings.count).to eq(1)
        expect(user.followings).to eq([user2])
      end

      it 'expect user2 have a new follower' do
        expect(user2.followers.count).to eq(1)
        expect(user2.followers).to eq([user])
      end
    end

    context 'when params are incorrect' do
      let(:params) { {} }
      before { post follow_api_v1_user_path(user), params: params }

      context 'when missing params' do
        it 'returns 404 user not found' do
          expect(response).to have_http_status(404)
        end
      end

      context 'when following id not found' do
        let(:params) { { following_id: 0 } }

        it 'returns 404 user not found' do
          expect(response).to have_http_status(404)
        end
      end

      context 'when user id not found' do
        let(:user) { User.new(id: 0) }
        let(:params) { { following_id: user2.id } }

        it 'returns 404 user not found' do
          expect(response).to have_http_status(404)
        end
      end

      context 'when user try to follow same user twice' do
        let(:params) { { following_id: user2.id } }
        before { post follow_api_v1_user_path(user), params: params }

        it 'returns 201' do
          expect(response).to have_http_status(201)
        end
      end

      context 'when user try to follow himself' do
        let(:params) { { following_id: user.id } }

        it 'returns 422' do
          expect(response).to have_http_status(422)
        end

        it 'returns message error' do
          expect(json_body['errors']['following_id'].first).to eq("You can't follow yourself")
        end
      end
    end
  end

  describe 'DELETE api/v1/users/:id/unfollow' do
    let(:user_follow) { create(:user_follow) }
    let(:user) { user_follow.follower }
    let(:user2) { user_follow.following }

    context 'when params are correct' do
      let(:params) { { following_id: user2.id } }
      before { delete unfollow_api_v1_user_path(user), params: params }

      it 'renders 204 created' do
        expect(response).to have_http_status(204)
      end

      it 'expect user dont have a following' do
        expect(user.followings.count).to eq(0)
        expect(user.followings).to be_empty
      end

      it 'expect user2 dont have a follower' do
        expect(user2.followers.count).to eq(0)
        expect(user2.followers).to be_empty
      end
    end

    context 'when params are incorrect' do
      let(:params) { {} }
      before { delete unfollow_api_v1_user_path(user), params: params }

      context 'when missing params' do
        it 'returns 404 user not found' do
          expect(response).to have_http_status(404)
        end
      end

      context 'when following id not found' do
        let(:params) { { following_id: 0 } }

        it 'returns 404 user not found' do
          expect(response).to have_http_status(404)
        end
      end

      context 'when user id not found' do
        let(:user) { User.new(id: 0) }
        let(:params) { { following_id: user2.id } }

        it 'returns 404 user not found' do
          expect(response).to have_http_status(404)
        end
      end

      context 'when user try to unfollow twice' do
        let(:params) { { following_id: user2.id } }
        before { delete unfollow_api_v1_user_path(user), params: params }

        it 'returns 404' do
          expect(response).to have_http_status(404)
        end

        it 'returns message error' do
          expect(json_body['errors'].first).to eq("Couldn't find UserFollow")
        end
      end
    end
  end
end
