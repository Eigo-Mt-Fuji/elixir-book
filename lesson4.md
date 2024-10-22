# Elixir Lesson 2018/7/17

## タイトル

* Elixir コレクション操作とEnumモジュール

## この章のねらい

* Elixirでのコレクションを列挙する手段(Enumモジュール)の認識
* Enumモジュールで利用可能な関数のうち、幾つかの代表的な関数を実際に用いて練習する
* Enumを使って実際のデータセットを操作しながら、実例を交え活用方法を学ぶ

## このレッスンの所要時間

* 1時間30分

## 概要・特徴
* Elixirには、 `Enumモジュール` がコレクション型操作のための標準機能として提供されています
* リスト型などのデータセットに対し繰り返し処理させたい場合に利用できます
* 例えば以下のようなケースをはじめ、Elixirでプログラミングする際の様々な場面で利用できます (TBD)
  * ファイルに保存されたデータセットからの特定の条件を満たすデータの抽出
    * fetch
    * filter
    * count
  * コレクションの特定の特徴を満たすかを判定する
    * all
    * any
  * Google APIなどの外部公開されたAPIをマッシュアップして利用する
    * map

## 教材のダウンロード

* 本教材で利用するソースコードを、手持ちのマシンに予めダウンロードしてください
  * ターミナルソフトウェア上で、以下のコマンドを実行することでダウンロードできます。
  * ダウンロード後、環境変数 `ELIXIR_WORK_DIR` にダウンロード先ディレクトリパスを設定してください。

```
$ git clone -b lesson-20180703-1 https://github.com/Eigo-Mt-Fuji/elixir-ex-cli-sample.git
$ cd elixir-ex-cli-sample/
$ export ELIXIR_WORK_DIR=`pwd`
```

## Enumモジュールの関数を使ってみる(動画説明)

* ここでは、Enumモジュールの幾つかの関数を実際に使いながら基本的な扱い方を動画を見ながら学習します
* 以下の関数を利用してコレクションの操作を実践します
  * fetch: コレクション内のN番目の要素を取得(取得できない場合)
  * filter: コレクション内で特定の条件を満たす要素のみ抽出する
  * any: コレクション内の要素のいずれかが〜である場合trueを返す

* fetch関数 先頭の要素を取得する

<img src="./resources/lesson4-enums-fetch-first.gif" width="512" width="320" />

* fetch関数 最後尾の要素を取得する

<img src="./resources/lesson4-enums-fetch-last.gif" width="512" width="320" />

* fetch関数 中央の要素を取得する

<img src="./resources/lesson4-enums-fetch-mid.gif" width="512" width="320" />

## Enumを使って実際のデータセットを操作する

### 概要

* Enumモジュールの関数を実際に使ってみましょう
* ここでは 予めダウンロードしておいた `動物の名前のリスト` を使った簡単なプログラムを利用します

### 準備

* まずは実行してみましょう

```
$ cd $ELIXIR_WORK_DIR
$ iex -S mix

iex 1> Lesson.Animals.search("アイアイ")
どうぶつマスタをダウンロードしました
"いいね, アイアイ"
```

* 次に、 `lib/Animals.ex` ファイルを開いてみてください

    * ファイルの44行目、45行目付近でEnum関数を使っているのが見て取れます

        * ファイルの41行目で `animals` に動物のリストを入れており、その中身を処理しています

```elixir
 40     animalName = input |> String.trim |> Mojiex.convert({:hg, :kk})
 41     animals = getLocalPath() |> File.read!() |> String.split("\n")
 42
 43     cond do
 44       Enum.any?(animals, &( &1 === animalName ) ) -> "いいね, #{animalName}"
 45       Enum.any?(animals, &( String.contains?(&1, animalName) ) ) -> "#{animalName}, おしいっ"
 46       true -> "いないみたい..."
 47     end
 48   end
```

### 練習問題

1. 動物のリストから特定のキーワードに一致するどうぶつがいるか・いないか判定する

2. 特定のキーワードに完全もしくは部分的に一致するどうぶつのリストを出力する

3. 特定のキーワードに完全もしくは部分的に一致するどうぶつの件数を取得する

## 補足

### ヘルプ機能を使う

* Enumの関数一覧を確認し、その中のeach関数のヘルプドキュメントを参照する

```
iex -S mix
iex 1> Enum.__info__(:functions)
iex 1> h(Enum.each)
```

### Enumモジュールのそれ以外の機能の紹介と参考プログラム

* Enumの幾つかの関数について実例を交えて紹介します
  * count: コレクション内で要素(指定した条件を満たす要素)の件数を取得する
  * at: コレクション内のN番目の要素を取得
  * each: コレクション内の各要素について、特定の関数の処理を実行する
  * all: コレクション内の要素がすべて 〜である場合trueを返す
  * empty?: コレクションが空(コレクション内に要素が１つもない状態)であるかを判定する(

* [ソースコード(TBD)](https://hexdocs.pm/elixir/Enum.html)
