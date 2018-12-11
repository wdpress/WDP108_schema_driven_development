const { ApolloServer } = require('apollo-server-express');
const { typeDefs } = require('./type_defs');
const server = new ApolloServer({ typeDefs, mocks: true });

const express = require('express');
const app = express();
server.applyMiddleware({ app, path: '/graphql' });

app.listen({ port: 4000 }, () =>
  console.log(`Server started at http://localhost:4000${server.graphqlPath}`)
);
