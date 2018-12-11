json.post do
  json.partial! 'posts/post', post: @post
end
