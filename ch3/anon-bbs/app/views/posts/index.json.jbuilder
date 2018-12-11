json.posts do
  json.array! @posts, partial: 'posts/post', as: :post
end
