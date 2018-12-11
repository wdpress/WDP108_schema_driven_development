# 匿名掲示板Web API

WEB+DB PRESS Vol.108特集における匿名掲示板Web APIのサンプルコードです。

事前に[Explore - Docker Store](https://store.docker.com/search?offering=community&type=edition)からお使いのプラットフォームのDockerをインストールしてください。

## サーバの起動方法

```
$ bin/setup
```

## テストの実行

記事中の解説のとおり、openapi.yaml中のSchemaオブジェクトとjson_schemaを用いて、APIサーバの仕様と実装の一致をテストしています。

サーバ起動中に以下のコマンドを実行するとテストを実行できます。

```
$ docker-compose exec app bundle exec rspec
```
