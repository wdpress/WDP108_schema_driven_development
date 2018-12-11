## 第3章サンプルコード

Ruby2.5.3, Ruby on Rails 5.2.1.1, Node.js 11.1.0で動作確認済みです。

### Web APIサーバ (anon-bbs)

`anon-bbs` 配下にあります。サーバの起動方法はREADMEを参照してください。

### Web APIクライアント

記事で紹介している方法でこのディレクトリに `javascript_client` を生成したあと、次のようにします。

```
$ cd ./javascript_client
$ npm link
$ cd ../client
$ npm link anon-bbs-api
```

APIサーバ起動後、次のコマンドでクライアントからアクセスします。

```
$ node index.js
```

### OpenAPIのSchemaオブジェクトによるバリデーションサンプル

`schema_example.rb` に記事で紹介したSchemaオブジェクトによるバリデーションの動くサンプルを用意しています。次のコマンドで動作を確認できます。

```
$ ruby schema_example.rb
```
