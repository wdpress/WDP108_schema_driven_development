exports.mocks = {
  ID: () => 1,
  Post: () => ({
    title: 'こんにちは',
    content: '今日はいい天気ですね',
    postedAt: '2018-12-01T00:00:00Z',
  }),
  Comment: () => ({
    content: 'そうですね',
    commentedAt: '2018-12-01T00:00:00Z',
  }),
};
