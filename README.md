# elixir-book


## レッスン
* [Lesson 1 Elixir とは](./lesson1.pdf)
* [Lesson 2 モジュールと関数](./lesson2.pdf)
* [Lesson 3 Elixirの基本型](./lesson3.pdf)
* [Lesson 4 Enumモジュールとコレクション操作](./lesson4.md)
* [Lesson 5 GoogleApiを使った開発演習](./lesson5.md)
* [Lesson 6 Phoenix とは](./lesson6.md)
* [Lesson 7 Webアプリケーションを動かそう](./lesson7.md)
* [Lesson 8 Webアプリケーションを公開しよう](./lesson8.md)
* [Lesson 9 MVCパターンを学ぼう(未)](./lesson9.md)
* [Lesson 10 VueJs x MaterialUIで飾ろう(仮)](./lesson10.md)
* [Lesson 11 Webアプリケーション開発演習(仮)](./lesson11.md)

## ガイドライン

* 1回のレッスンは１時間、１５分ごとに４分割可能な構成を維持する
  * レッスンのレジュメに所要時間を明記する
    * 時間基準の固定
  * 最大集中持続時間の指標を１時間３０分と定義
    * ３０分はフォローに回す（学習時間個人差の吸収、QA時間、補足・実演、レポートまとめ）
  * 継続可能性最大化が可能な単位を１５分と定義

* 全レッスンをあわせて、[Elixir-Lang公式 Getting Started](https://elixir-lang.org/getting-started/introduction.html)を満たすこと。

* 公式資料(英文)を翻訳する場合、原文突き合わせを最低１回、推敲を最低1回行う。

* 各レッスンで学習する項目ごとに、シナリオを用意する。
  * `Screencast` の `収録手順` を参照

## Screencast

### 収録手順

* 収録用ディレクトリへ移動

```
cd resources
```

* コンパイル(収録スクリプトに変更がある場合のみ)

```
$ npm run build
```

* シナリオをテキストファイル形式で用意

```
$ ls -la ./ # resourcesディレクトリにいることを確認
vi lesson4-enums-fetch-first.txt
```

* 事前準備
  
  * 環境変数の設定

```bash
export PS1="\\$\s-\V:\W "
export ELIXIR_WORK_DIR="/Users/e_fujikawa/Documents/git/elixir-ex-cli-sample"
```

* 収録開始  

  * ターミナルソフトの準備
    * `iTerm2` を開く
    * ホームディレクトリに移動
    * 最大化しておく

  * QuickTime Playerを起動
    * 新規画面収録 -> 開始ボタン( <span style="color: red">赤い丸</span> ) を押す

* シナリオの実行開始

```
$ ls -la ./ # resourcesディレクトリにいることを確認
$ npm run start lesson4-enums-fetch-first
```

* スクリプト実行終了
  * QuickTime Playerにて、収録した画面の動画像を `シナリオ名.original.mov` として保存

* 動画編集(任意)
  * 必要であれば一部トリムする作業をここで行う
  * 不要な場合、単に `シナリオ名.original.mov` を `シナリオ名.mov` に変えて保存する
    * このあとの動画変換作業は  `シナリオ名.mov` を用いて行う

* 動画変換(mov -> gif)

```bash
$ ls -la ./ # resourcesディレクトリにいることを確認
$ TARGET=lesson4-enums-fetch-first
$ rm -rf palette.png
$ ffmpeg -i $TARGET.mov -vf fps=10,palettegen palette.png
$ ffmpeg -i $TARGET.mov -i palette.png -filter_complex "fps=10,paletteuse" $TARGET.gif
```

* 作成した動画を以下の要領で教材に埋め込む

```text
* fetch関数 先頭の要素を取得する

<img src="./resources/lesson4-enums-fetch-first.gif" width="512" width="320" />
```


### 参考シナリオ

* 以下のようなシナリオを記述できます
   * 例1

```elixir
cd $ELIXIR_WORK_DIR
iex -S mix
book_samples_1 = [
    %{:name => "Elixir handbook", :category => "programming"},
    %{:name => "Erlang handbook", :category => "programming"},
    %{:name => "Detective Poirot", :category => "novel"}
]
{:ok, first} = Enum.fetch(book_samples_1, 0)
is_map(first)
IO.puts(first.name)
```

   * 例2

```
pwd
ls
iex
hoge = 1+1
%%ALPHA%%
IO.puts(hoge)
IO.puts("hoge")
"""
%%NOBR%%
[
%%KANA%%
toridashitakekkaha
%%ALPHA%%
Elixir
%%KANA%%
no
%%ALPHA%%
Map
%%KANA%%
kata
%%ALPHA%%
%%WITHBR%%
]
"""

%%ALPHA%%
IO.puts("result:"<>Integer.to_string(hoge))
```
