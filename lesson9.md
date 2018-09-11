`ダッシュボード機能` を作りながら `MVCパターン` を体験

まずはMVCの３つの層（ビュー／コントローラ／モデル）のつながりを確認してみましょう
`ダッシュボード機能` を
`Phonenix` フレームワークの使い方を思い出しながら

```

## アジェンダ

* シンプルなLMSを作る想定で `ダッシュボード機能` を作りながらWebアプリケーション開発、MVCパターンを体験します

* Phoenixフレームワークで自動生成されたファイルをみながらモデル・ビュー・コントローラの実態をみる

* 実際に修正とサービスレベルでの確認を行っていきます

## ダッシュボード画面イメージ

<img src="./resources/lesson9-dashboard-image.gif" width="860" width="480" />

## 完成版URL

(https://mysterious-journey-60235.herokuapp.com/admin/lscontents)

## ダッシュボード機能定義

```
* ぱんくずリストが表示されている
* 学習コンテンツの一覧が表示されている（アイキャッチ画像）
* 学習コンテンツの作成画面に遷移できる
* アイキャッチ画像を選択すると詳細画面に遷移できる
* 学習コンテンツの削除処理を呼び出せる
```

## 画面イメージ

## STEP1: まずは雛形を作成し、画面を表示してみましょう

* `phx.gen.html` コマンドで雛形を作成

```
$ mix phx.gen.html Lesson LsContent lscontents title:string image:string
```

* lib/portion_web/router.exを修正する 

    * 表示されたメッセージに従ってファイルを開いて修正を行ってください
    * routerについて確認したい場合 [公式サイトの説明](https://hexdocs.pm/phoenix/routing.html#resources) をご確認ください

```
Add the resource to your browser scope in lib/portion_web/router.ex:

    resources "/lscontents", LsContentController
```
  
## STEP2: 次に作成された雛形を確認してみましょう

### `ビューテンプレート` 

#### 対象ファイル

```
* creating lib/portion_web/templates/ls_content/index.html.eex
```

#### 解説

* `@lscontents` という 記載があり、これがコントローラからビューに渡した `lscontents` と関連づいています

#### 抜粋

```
<h2>Listing lscontents</h2>

<!-- (省略) --> 
  <tbody>
  <%= for ls_content <- @lscontents do %>
    <!-- (省略) --> 
  <% end %>

<!-- (省略) --> 
```

### `コントローラ`  

#### 対象ファイル

```
creating lib/portion_web/controllers/ls_content_controller.ex # 
```

#### 解説

* `index` という関数があり、シンプルなモデルとビューと連携処理が実装されているのが確認できます

#### 抜粋 

```
defmodule PortionWeb.LsContentController do
  use PortionWeb, :controller

  alias Portion.Lesson
  alias Portion.Lesson.LsContent

  def index(conn, _params) do
    lscontents = Lesson.list_lscontents() # 1. コントローラ - モデル の連携
    render(conn, "index.html", lscontents: lscontents) # 2. コントローラ - ビューの連携
  end

  # ...
end
```

### モデル

#### 対象ファイル

```
* creating lib/portion/lesson/ls_content.ex
```

#### 解説

* 学習コンテンツ(タイトルとアイキャッチ画像)を表現するモデルが定義されています
* このモデルはPostgresデータベースに学習コンテンツを登録したり取得したりする際に使われます

## STEP3: デプロイして確認してみましょう

* Herokuに公開する

```
$ git add .
$ git commit -m "ダッシュボード機能雛形作成"
$ git push heroku master
```

* Heroku上のデータベースを更新する

```
$ heroku run mix ecto.migrate
$ heroku pg:psql
insert into lscontents (title, image, inserted_at, updated_at) values ('test3', 'https://belinda.fun/wp-content/uploads/2017/08/4db24a1007a83ac6ec852ff88c9a3c9a-1.jpg', current_timestamp, current_timestamp);
insert into lscontents (title, image, inserted_at, updated_at) values ('test4', 'https://scontent.cdninstagram.com/vp/73869a1aa6e94b4f259ba843a93d9808/5C39B919/t51.2885-15/sh0.08/e35/s640x640/28152988_243839042825634_768292885303918592_n.jpg', current_timestamp, current_timestamp);
insert into lscontents(title, image, inserted_at, updated_at) values('test5', 'https://scontent.cdninstagram.com/vp/333ecd9f90f483f62a7cd94b812c7e1a/5C2C340C/t51.2885-15/sh0.08/e35/s640x640/33126164_1943569242621737_943159639787175936_n.jpg', current_timestamp, current_timestamp);
select * from lscontents;
\q
```

## STEP4-1: `ビューテンプレート` を修正する
   * アイキャッチ画像がテキストで表示されているのでimgタグで表示
   * パンくずリストを表示するHTMLタグを追加する
     * パンくずリストに表示する文言はコントローラから渡されるパラメータに従うようにする
        * パラメータ名は適当な名前を決めて設定する

## STEP4-2(OPTION): ダッシュボード機能のイメージに近づけてみる 

## STEP5: `ビューテンプレート` に合わせてコントローラを修正する
  * ダッシュボード画面イメージを参考に、ページレイアウトを修正してみましょう

```
defmodule PortionWeb.LsContentController do
  use PortionWeb, :controller

  alias Portion.Lesson
  alias Portion.Lesson.LsContent

  def index(conn, _params) do
    # モデル層を呼び出す
    lessons = Lesson.list_lscontents()

    # コントローラからビュー層にパラメータを渡しています(lessons, is_admin, breadcrumbs, content_title, copyright)
    render(conn, "index.html",
      lessons: lessons |> Poison.encode!,
      is_admin: true,
      breadcrumbs: [
        %{index: 1, icon: "home", label: "ホーム", link: "/"},
        %{index: 2, icon: "", label: "レッスン管理画面", link: ls_content_path(conn, :index)}
      ] |> Poison.encode!,
      content_title: "LMS",
      copyright: "EliXir"
    )
  end

  # ...
end
```

## STEP6: 修正版をローカル環境で動作確認しましょう

```
$ mix compile
$ mix phx.server
$ open http://0.0.0.0:3000/admin/lscontent/
```

## STEP7: デプロイして反映されるか確認しましょう

```
$ git add ./
$ git commit -m "ダッシュボード機能を修正"
$ git push heroku master # デプロイが成功することを確認
$ open https://<控えておいたアプリケーション名>.herokuapp.com/admin/lscontents/ # ブラウザで開いて表示を確認しましょう
```

## STEP8: まとめ

* Phoenixの自動生成コマンドで作成された機能の雛形を確認できた

* ビューテンプレート、コントローラ、モデルの連携個所を確認できた

* データベースの情報がMVCの３つの層を経て、ブラウザに表示反映されていることを確認できた
    * `データベース(Postgres)` -> `モデル` -> `コントローラ` -> `ビュー` -> ブラウザ

* ビューとコントローラを修正し、Herokuに公開してWebサービスに反映されることが確認できた
    * Webサービスを使うときのプログラムの流れ
      * `ユーザ` -> `ブラウザ` -> `ルーティング` -> `コントローラ` (-> モデル) -> `ビュー` -> `ブラウザ`

## 補足： 雛形で作成されたその他ファイルの紹介（一部抜粋）

* `index.html.eex` 以外にもいくつかのビューテンプレートが雛形として生成されています

```
* creating lib/portion_web/templates/ls_content/new.html.eex # 新規作成画面テンプレート
* creating lib/portion_web/templates/ls_content/edit.html.eex # 編集画面テンプレート
* creating lib/portion_web/templates/ls_content/form.html.eex # 新規作成画面・編集画面の入力フォームテンプレート
* creating lib/portion_web/templates/ls_content/show.html.eex # 詳細画面テンプレート
```

* `ビュー` `Webページのレンダリングに必要な関数群が定義されています`

```
* creating lib/portion_web/views/ls_content_view.ex
```

* `マイグレーションファイル` `テーブル追加など、データベースの作成・更新に必要な情報が定義がされています`

```
* creating priv/repo/migrations/{年月日時分秒}_create_lscontent.exs
```


