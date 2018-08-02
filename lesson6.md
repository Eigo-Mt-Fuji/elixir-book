# Elixir Lesson 2018/7/31

## アジェンダ

* Phoenixとは(https://hexdocs.pm/phoenix/overview.html)

* Phoenix環境構築(https://hexdocs.pm/phoenix/up_and_running.html)

## このレッスンの所要時間

1時間

## Phoenix とは?

* Webフレームワーク
    * 開発スピードとメンテナンス性で妥協しない。
    * Productive. Reliable. Fast ３拍子揃った
* Leverages the 
    * Erlang VMの持つ数百万のコネクションでもハンドル可能な処理性能
    * フォールトトレラントなシステムを構築するための生産性向上ツール群
    * Elixirの美しい文法

* クロスブラウザWebアプリの構築
   * rich
   * interactive
* ネイティブモバイルアプリの構築   
* 組込みデバイス上でリアルタイムストリーミング
    * PhoenixのChannelsというテクノロジを用いてリアルタイムストリーミング

* どんな企業が使っているか

```
Bleacher Report
Inverse
Brightcove
Heroic Labs
Cargosense
The Outline
VoiceLayer
  DockYard offers expert Phoenix consulting for your projects
```


## Phoenixのプロジェクトを作るためのarchiveインストール

```
mix archive.install https://github.com/phoenixframework/archives/raw/master/phx_new.ez
mix phx.new phoenix-training --app portion
```

## Postgresqlサーバをインストール

```
brew install postgresql@9.6 # バージョンは適宜stable latestで読み替え
## 環境変数PATHにpostgresqlのパスを追加
echo $PATH
echo 'export PATH="/usr/local/opt/postgresql\@9.6/bin:$PATH"' >> ~/.bash_profile
## プロファイルを読み込み直して環境変数に反映されることを確認
source ~/.bash_profile
echo $PATH
pg_ctl -D /usr/local/var/postgresql\@9.6 start # エンターを押す
createuser -a -d -P postgres # パスワードが聞かれるのでpostgresと入れてください
PGPASSWORD=postgres psql -h localhost -p5432 -Upostgres
postgres=> select version();
```

## Phoenixプロジェクトの作成

```
mix phx.new ./phoenix-training --app portion --database postgres
cd phoenix-training
vi config/dev.exs

config :portion, Portion.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "postgres",
  password: "postgres",
  database: "portion_dev",
  hostname: "localhost",
  pool_size: 10

mix ecto.create
psql -h localhost -p5432 -Upostgres -dportion_dev # dev環境DBに接続できるか確認
mix phx.server # ブラウザでhttp://localhost:4000を開く
```

## 補足

* 基本用語

    * Phoenix(というよりMVCでアプリケーション作るときに)使われる用語
        * https://hexdocs.pm/phoenix/overview.html

```
Endpoint: PhoenixでWebアプリケーションを起動する時のエントリーポイント。Webサーバの開始時に実行され、特定ポート番号でのリクエストの待受開始（ソケットの立ち上げ）の制御をします)
Router: ブラウザから来たリクエストのURLごとに、どのコントローラのどのアクションに対応づける（ディスパッチ）のかを設定する場所です
Controllers: ブラウザから来たリクエストを実際に処理する関数（アクションと呼びます）を定義する場所です。データをビュー層に橋渡す役割
Templates: HTMLテンプレートなどレスポンスのテンプレートを記述
Views: 上記テンプレート内で利用するヘルパー関数をはじめ、ビューをレンダリングする上で必要なロジックを書きます。
Channels: リアルタイム処理を実装するためのソケット管理機能
PubSub: PubSubを実装する上での基本となるアダプタ機能
```

* Supervisor (PhoenixのWebサーバ起動で使われる技術)
  
    https://elixir-lang.org/getting-started/mix-otp/supervisor-and-application.html

## 困ったら

* すでにphenixがインストールされてる場合、いかのように聞かれます。

   * その場合

      * 同じバージョンがインストールされている場合
          * nを入力してスキップしてください。

      * 同じバージョンがインストールできているか確認
          * ディレクトリの日付などから確認

-------- （編集済み）
10:10
$ mix archive.install https://github.com/phoenixframework/archives/raw/master/phx_new.ez
Found existing entry: /Users/e_fujikawa/.mix/archives/phx_new
Are you sure you want to replace it with "https://github.com/phoenixframework/archives/raw/master/phx_new.ez"? [Yn]

