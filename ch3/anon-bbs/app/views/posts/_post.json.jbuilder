json.(post, :id, :title, :content)
json.posted_at post.created_at.iso8601
