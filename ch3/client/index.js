var AnonBbsApi = require('anon-bbs-api');
var api = new AnonBbsApi.DefaultApi()
var postRequest = AnonBbsApi.PostRequest.constructFromObject(
  {
    post: {
      title: "こんにちは",
      content: "良い天気ですね"
    }
  }
);

api.createPost(
  postRequest,
  function(error, data, response) {
    if (error) {
      console.error(error);
    } else {
      console.log('response: ' + response.text);
    }
  }
);
