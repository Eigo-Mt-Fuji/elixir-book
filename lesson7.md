# サンプルWebアプリケーションを動かす

## アジェンダ

* Phoenixを使って作られた簡単なWebアプリケーションソースをローカル環境で動かしながらソースを確認してみましょう
* `練習問題` では、サンプルのコード(Elixir)、期待した結果になるように書き換えてみてください

## このレッスンの所要時間

1時間

## インストール

``` 
git clone https://github.com/Eigo-Mt-Fuji/phoenix-training.git 
cd phoenix-training 
mix deps.get 
cd assets 
npm install
npm run build
cd ../ 
mix compile
mix phx.server
```

## `DB起動`

```
pg_ctl -D /usr/local/var/postgresql@9.6 start
createuser -a -d -P postgres # パスワードが聞かれるのでpostgresと入れてください
createdb -E UTF8 -U postgres postgres

mix ecto.create
mix ecto.migrate
```

## 動作確認

`http://0.0.0.0:4000/lsusers`
このような画面が出れば成功

スクリーンショット 2018-08-21 10.42.13.png

## 練習課題

* 選択した画像を保存するように修正してみる

## 期待する動作


```
## 初回
1. 画面を開く http://0.0.0.0:4000/lsusers?keyword=ネコ
2. すべての画像が未選択の状態で表示される
3. ネコの画像をいくつか選択して保存ボタンを押す # 保存される

## ２回目以降
4. 画面を開く http://0.0.0.0:4000/lsusers?keyword=ネコ 
5. 選択した画像が選択中の状態で表示される
```

## ソース説明

* `phoenix-training/assets/src/templates/lesson-show-case.vue.html` 保存ボタンが書かれているHTML
   *  保存ボタンをクリックすると以下のファイルの関数 `onClickSave` が実行されます
       * `phoenix-training/assets/src/components/lesson-show-case.ts` 
       * この関数ではサーバに保存のリクエストを送信していますのでここを埋めて 


* サーバサイドのエントリーポイント
   * `phoenix-training/lib/portion_web/controllers/ls_user_controller.ex` の `create` 関数

* 保存先は以下のいずれかを利用しAPIの使い方を確認してトライしてみてください

   • ファイル (File)
   • データベース(Ecto)
   • その他のストレージ(GoogleDriver)
   • オンメモリキャッシュ(ETS, Plug.Session)

## 参考

* ファイルの場合の参考URL
  https://elixir-lang.org/getting-started/io-and-the-file-system.html#the-file-module

