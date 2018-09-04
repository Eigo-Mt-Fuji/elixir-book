`Heroku にデプロイしよう`

Herokuというサービスを使うと、無償でWebアプリケーションを外部に公開できます

まずはアカウントの作成をお願いします
https://signup.heroku.com/dc （編集済み）
signup.heroku.com
Heroku | Sign up
Sign up for a free Heroku developer account and get started building your apps on Heroku.
今日やりたいことのながれは以下のとおりです

```1. Signup & Loginできるか確認する
   - dasshboard https://dashboard.heroku.com/apps が表示できればOK 
      
2. MacにHerokuのCliをインストール
   - https://devcenter.heroku.com/articles/heroku-cli#download-and-install
   - https://devcenter.heroku.com/articles/heroku-cli#getting-started

3. Deployしてみる
   - ためしに下記のソースを公開してみましょう
      https://github.com/Eigo-Mt-Fuji/phoenix-training```

```heroku login
heroku create --buildpack "https://github.com/HashNuke/heroku-buildpack-elixir.git" # アプリケーション名が表示されるので控えておく
heroku addons:create heroku-postgresql:hobby-dev -a 控えておいたアプリケーション名
heroku buildpacks:add https://github.com/heroku/heroku-buildpack-nodejs#v83 -a 控えておいたアプリケーション名
heroku git:remote heroku -a 控えておいたアプリケーション名

heroku config:set POOL_SIZE=18
heroku config:set SECRET_KEY_BASE="$(mix phx.gen.secret)"
heroku config:set GAPI_CUSTOMSEARCH_APIKEY="<APIキー>"
heroku config:set GAPI_CUSTOMSEARCH_CX="検索エンジンID" 
heroku config:set GCP_CREDENTIALS='GCP クレデンシャル（JSON）'

git push heroku master```
（編集済み）

e-fujikawa [10:32]
公開するとこのように表示されます
スクリーンショット 2018-09-04 10.31.17.png 

`mysterious-journey-60235`
```$-bash-3.2.57:phoenix-training heroku addons:create --help
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
 `heroku git:remote heroku -a 控えておいたアプリケーション名`
こちらのように置き換えていただけますか （編集済み）
https://qiita.com/k-waragai/items/a372800c262f56fe688a

Atomでリアルタイム共同編集 （編集済み）

e-fujikawa [11:07]
検索エンジンID

`013595435806448571340:qrcz-ciehnm`

e-fujikawa [11:26]
`ソースを修正してHerokuに反映する手順`

```vi lib/portion_web/templates/ls_user/index.html.eex # ためしにhtmlを修正
git add lib/portion_web/templates/ls_user/index.html.eex
git commit -m "htmlテスト修正"
git push heroku master # ここでHerokuに公開される```
（編集済み）

e-fujikawa [11:37]
`MaintenanceMode` で アプリケーションを `非公開` にする

Herokuのダッシュボードにアクセスして `Settings` を開いてください
https://dashboard.heroku.com/apps
Settings
MaintenanceModeが `Maintenance mode is off` になっているのが確認できます
横にあるスイッチを `ON` に切り替えると アプリケーションが非公開になります
(後述の Google APIの認証情報の置き換えが完了したら再度 Settingsを開いてMaintenanceModeをoffにする)
---
Google APIの認証情報を自分のアカウントで取得したもので置き換えましょう
APIキー、検索エンジンID、GCPクレデンシャルを以下の手順で取得してHerokuに設定します

----
`APIキー` の取得手順
認証情報ページでAPIキーが作成されたことを確認
https://console.cloud.google.com/apis/credentials
* APIキーの値を控えておく
* heroku config:set GAPI_CUSTOMSEARCH_APIKEY=“<APIキー>” を実行 （編集済み）
accounts.google.com
Google Cloud Platform
Google Cloud Platform lets you build, deploy, and scale applications, websites, and services on the same infrastructure as Google.
---
`検索エンジンID` の取得手順
https://cse.google.com/cse/all

• 新しい検索エンジンを作成
•  `検索エンジン ID` を控えておく
* heroku config:set GAPI_CUSTOMSEARCH_CX=“検索エンジンID”  を実行 （編集済み）

e-fujikawa [11:46]
`GCP クレデンシャル（JSON）` の取得手順

https://console.cloud.google.com/apis/credentials

`認証情報の作成` -> `サービスアカウントキー` -> 作成画面が表示される
   * サービスアカウントのプルダウン：  `新しいサービスアカウント`
   * キーのタイプは JSON
   * JSONファイルがダウンロードされるのでこの中身を控えて
   *  heroku config:set GCP_CREDENTIALS=‘GCP クレデンシャル（JSON）’ を実行 （編集済み）
----
上記の流れで、認証情報の作成とHerokuへの再設定をすることで
自分のアカウントの認証情報がHerokuにデプロイしたアプリケーションに反映されますmm

Herokuの `Activity` で反映されたか確認
https://dashboard.heroku.com/apps/ （編集済み）

e-fujikawa [12:00]
`Herokuのアプリケーション再起動`
スクリーンショット 2018-09-04 11.59.46.png 

`Restart all dyno`

