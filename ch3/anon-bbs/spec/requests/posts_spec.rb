require 'rails_helper'

RSpec.describe 'Posts API', type: :request do
  describe 'GET /posts' do
    let(:schema_method) { 'get' }
    let(:schema_path) { '/posts' }

    before { create_pair(:post) }

    context 'when posts exist' do
      let(:code) { 200 }

      it 'returns 200' do
        get '/posts',
            headers: { ACCEPT: 'application/json', CONTENT_TYPE: 'application/json' }

        expect(response.status).to eq code

        expect_to_conform_schema response
      end
    end
  end

  describe 'GET /post/:id' do
    let(:schema_method) { 'get' }
    let(:schema_path) { '/posts/{postId}' }

    let(:a_post) { create(:post) }

    context 'when a post exists' do
      let(:code) { 200 }

      it 'returns 200' do
        get "/posts/#{a_post.id}",
            headers: { ACCEPT: 'application/json', CONTENT_TYPE: 'application/json' }

        expect(response.status).to eq code

        expect_to_conform_schema response
      end
    end
  end

  describe 'POST /posts' do
    let(:schema_method) { 'post' }
    let(:schema_path) { '/posts' }

    context 'when params is valid' do
      let(:code) { 201 }

      it 'creates a post and returns 201' do
        post '/posts',
             headers: { ACCEPT: 'application/json', CONTENT_TYPE: 'application/json' },
             params: { post: { title: 'テストのタイトル', content: 'テストの本文' } }.to_json

        expect(response.status).to eq code

        expect_to_conform_schema response
      end
    end
  end

  describe 'PUT /post/:id' do
    let(:schema_method) { 'put' }
    let(:schema_path) { '/posts/{postId}' }

    let(:a_post) { create(:post) }

    context 'when a post exists' do
      let(:code) { 200 }

      it 'returns 200' do
        expect {
          put "/posts/#{a_post.id}",
              headers: { ACCEPT: 'application/json', CONTENT_TYPE: 'application/json' },
              params: { post: { title: '【更新】テストのタイトル', content: '【更新】テストの本文' } }.to_json
          a_post.reload
        }.to change(a_post, :title).and change(a_post, :content)

        expect(response.status).to eq code

        expect_to_conform_schema response
      end
    end
  end

  describe 'DELETE /post/:id' do
    let(:schema_method) { 'delete' }
    let(:schema_path) { '/posts/{postId}' }

    let!(:a_post) { create(:post) }

    context 'when a post exists' do
      let(:code) { 204 }

      it 'returns 204' do
        expect {
          delete "/posts/#{a_post.id}",
                 headers: { ACCEPT: 'application/json', CONTENT_TYPE: 'application/json' }
        }.to change(Post, :count).by(-1)

        expect(response.status).to eq code
      end
    end
  end
end
