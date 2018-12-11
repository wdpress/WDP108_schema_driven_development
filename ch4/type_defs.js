const { gql } = require('apollo-server-express');

exports.typeDefs = gql`
type Query {
  posts: [Post]!
  post(id: ID!): Post
}

type Post {
  id: ID!
  title: String!
  content: String!
  postedAt: String!
  comments: [Comment]!
}

type Comment {
  id: ID!
  content: String!
  commentedAt: String!
  post: Post!
}

input PostInput {
  title: String,
  content: String
}

type Mutation {
  createPost(input: PostInput): Post
}
`
// その他のミューテーション（作成、更新、削除）は省略
