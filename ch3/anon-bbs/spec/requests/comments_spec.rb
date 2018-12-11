require 'rails_helper'

RSpec.describe 'Comments API', type: :request do
  describe 'GET /comments' do
    let(:schema_method) { 'get' }
    let(:schema_path) { '/posts/{postId}/comments' }

    let!(:a_post) { create(:post) }

    before { create_pair(:comment, post: a_post) }

    let(:code) { 200 }

    it 'returns 200' do
      get "/posts/#{a_post.id}/comments",
          headers: { ACCEPT: 'application/json', CONTENT_TYPE: 'application/json' }

      expect(response.status).to eq code

      expect_to_conform_schema response
    end
  end

  describe 'POST /comments' do
    let(:schema_method) { 'post' }
    let(:schema_path) { '/posts/{postId}/comments' }

    context 'when params is valid' do
      let(:code) { 201 }

      it 'creates a comment and returns 201' do
        post "/posts/#{create(:post).id}/comments",
             headers: { ACCEPT: 'application/json', CONTENT_TYPE: 'application/json' },
             params: { comment: { content: 'テストのコメント' } }.to_json

        expect(response.status).to eq code

        expect_to_conform_schema response
      end
    end
  end

  describe 'DELETE /post/:post_id/comments/:id' do
    let(:schema_method) { 'delete' }
    let(:schema_path) { '/posts/{postId}/comments/{commentId}' }

    let(:a_post) { create(:post) }
    let!(:comment) { create(:comment, post: a_post) }

    let(:code) { 204 }

    it 'returns 204' do
      expect {
        delete "/posts/#{a_post.id}/comments/#{comment.id}",
               headers: { ACCEPT: 'application/json', CONTENT_TYPE: 'application/json' }
      }.to change(Comment, :count).by(-1)

      expect(response.status).to eq code
    end
  end
end
