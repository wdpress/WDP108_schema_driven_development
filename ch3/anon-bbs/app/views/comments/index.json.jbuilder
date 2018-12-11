json.comments do
  json.array! @comments, partial: 'comments/comment', as: :comment
end
