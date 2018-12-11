const { ApolloServer, gql } = require('apollo-server-express');
const typeDefs = gql`
  type Query {
    content: String
  }
`;
const resolvers = {
  Query: {
    content: () => 'こんにちは'
  }
};

const server = new ApolloServer({ typeDefs, resolvers });
const express = require('express');
const app = express();
server.applyMiddleware({ app, path: '/graphql' });

app.listen({ port: 4000 }, () =>
  console.log(`Server started at http://localhost:4000${server.graphqlPath}`)
);
