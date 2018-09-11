# Webアプリケーションを公開しよう

## アジェンダ
* Phoenixで作成したWebアプリケーションを [Heroku](https://jp.heroku.com/platform) を使って外部公開しましょう
* 無償でWebアプリケーションを外部に公開できます

## STEP1: まずはアカウントの作成をお願いします

* Signup
   * https://signup.heroku.com/dc
  
* Signin
   * [Herokuのダッシュボード](https://dashboard.heroku.com/apps) がブラウザで表示できることを確認してください

## STEP2: MacにHerokuのcliをインストールします

* インストール
   * https://devcenter.heroku.com/articles/heroku-cli#download-and-install

* セットアップ手順
   * https://devcenter.heroku.com/articles/heroku-cli#getting-started

## STEP3: （デプロイする準備）Heroku上にアプリケーションを作成します
* phoenix-trainingというソースを使って公開の手順を通してみましょう
   * TBD

* 

```
$ cd phoenix-training
$ heroku login
$ heroku create --buildpack "https://github.com/HashNuke/heroku-buildpack-elixir.git" # アプリケーション名が表示されるので控えておく
$ heroku addons:create heroku-postgresql:hobby-dev -a <控えておいたアプリケーション名>
$ heroku buildpacks:add https://github.com/heroku/heroku-buildpack-nodejs#v83 -a <控えておいたアプリケーション名>
$ heroku git:remote heroku -a <控えておいたアプリケーション名>
$ cat <<EOF > config/prod.exs

use Mix.Config

config :portion, PortionWeb.Endpoint,
  load_from_system_env: true,
  url: [scheme: "https", host: "<控えておいたアプリケーション名>.herokuapp.com", port: 443],
  force_ssl: [rewrite_on: [:x_forwarded_proto]],
  cache_static_manifest: "priv/static/cache_manifest.json",
  secret_key_base: Map.fetch!(System.get_env(), "SECRET_KEY_BASE")

config :portion, Portion.Repo,
  adapter: Ecto.Adapters.Postgres,
  url: System.get_env("DATABASE_URL"),
  pool_size: String.to_integer(System.get_env("POOL_SIZE") || "10"),
  ssl: true

config :logger, level: :info
EOF

$ cat <<EOF > package.json
{
  "repository": {},
  "description" : "dummy package.json",
  "license": "MIT",
  "scripts": {},
  "dependencies": {
  },
  "devDependencies": {
  }
}
EOF

$ cat <<EOF > Procfile
web: cd assets/ && npm install && cd ../ && MIX_ENV=prod mix phx.server
EOF

heroku config:set POOL_SIZE=18
heroku config:set SECRET_KEY_BASE="$(mix phx.gen.secret)"
heroku config:set GAPI_CUSTOMSEARCH_APIKEY="<APIキー>"
heroku config:set GAPI_CUSTOMSEARCH_CX="<検索エンジンID>" 
heroku config:set GCP_CREDENTIALS='<GCP クレデンシャル（JSON）>'

git push heroku master
```

## 完成イメージ

e-fujikawa [10:32]
公開するとこのように表示されます
 
## STEP6: HTMLソースを修正してHerokuに反映してみましょう

```
vi lib/portion_web/templates/ls_user/index.html.eex # ためしにhtmlを修正
git add lib/portion_web/templates/ls_user/index.html.eex
git commit -m "htmlテスト修正"
git push heroku master # ここでHerokuに公開される
```



## 補足： Maintenanceモード切り替え

* MaintenanceMode で アプリケーションを `非公開` にする

   * Herokuのダッシュボードにアクセスして `Settings` を開いてください
      * https://dashboard.heroku.com/apps
   * Settings
      * MaintenanceModeが `Maintenance mode is off` になっているのが確認できます

         * 横にあるスイッチを `ON` に切り替えると アプリケーションが非公開になります
            * 学習が終わったら事故防止のためメンテナンスモードをOnにしてくださいmm

## 補足： heroku cliのコマンドのhelpを使う

* herokuのcliの使い方がわからない場合、helpを活用してみてください
* 以下、addons:createのhelp を表示するサンプルです
    * `addons:create` 以外のコマンドについても同様に確認することができます

```
$-bash-3.2.57:phoenix-training heroku addons:create --help
 ›   Warning: heroku update available from 7.0.86 to 7.9.3
create a new add-on resource

USAGE
  $ heroku addons:create SERVICE:PLAN

OPTIONS
  -a, --app=app        (required) app to run command against
  -r, --remote=remote  git remote of app to use
  --as=as              name for the initial add-on attachment
  --confirm=confirm    overwrite existing config vars or existing add-on attachments
  --name=name          name for the add-on resource
  --wait               watch add-on creation status and exit when complete```
```

## 補足： Google APIのAPIキー、検索エンジンID、GCPクレデンシャル(JSON)の取得手順

* 前提
   * Google Cloud PlatformにSignupしておく
   
* `APIキー` の取得手順
    * GCP のcreadentialsのページにアクセス
        * https://console.cloud.google.com/apis/credentials

    * `認証情報の作成` -> `APIキー` 

    * 作成されたAPIキーの値を控えておく

* `検索エンジンID` の取得手順

   * cse.google.comの下記のページにアクセス
       * https://cse.google.com/cse/all

   * 新しい検索エンジンを作成
       * `検索エンジン ID` を控えておく

* `GCP クレデンシャル（JSON）` の取得手順

    * GCP のcreadentialsのページにアクセス
        * https://console.cloud.google.com/apis/credentials

    * `認証情報の作成` -> `サービスアカウントキー`
        * サービスアカウントのプルダウン：  `新しいサービスアカウント`
        * キーのタイプは JSON
        * JSONファイルがダウンロードされるのでこの中身を控えて

* 控えておいた値を `heroku config:set` コマンドを実行してそれぞれ再設定します

```
heroku config:set GAPI_CUSTOMSEARCH_APIKEY=“検索エンジンID”
heroku config:set GAPI_CUSTOMSEARCH_CX=“検索エンジンID”
heroku config:set GCP_CREDENTIALS=‘GCP クレデンシャル（JSON）’
```

* Herokuのダッシュボードページをブラウザで開いて `Activity` タブを選択して表示・configの設定が実行されたことを確認a
    * https://dashboard.heroku.com/apps/
    * Herokuのアプリケーション再起動(Restart all dyno)

* 上記の流れで、認証情報の作成とHerokuへの再設定をすることで、自分のアカウントの認証情報がHerokuにデプロイしたアプリケーションに反映されます

