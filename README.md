# elixir-book


## レッスン
* [Lesson 1 Elixir とは](./lesson1.pdf)
* [Lesson 2 モジュールと関数](./lesson2.pdf)
* [Lesson 3 Elixirの基本型](./lesson3.pdf)
* [Lesson 4 Enumモジュールとコレクション操作](./lesson4.md)

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
  * Screencast

## 収録手順

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
vi testdoc.txt
```

* 収録開始

* QuickTime Playerを起動

```
$ ls -la ./ # resourcesディレクトリにいることを確認
$ npm run start testdoc
```

* 変換

```
$ ls -la ./ # resourcesディレクトリにいることを確認
$ TARGET=lesson4-enums-fetch-first
$ rm -rf palette.png
$ ffmpeg -i $TARGET.mov -vf fps=10,palettegen palette.png
$ ffmpeg -i $TARGET.mov -i palette.png -filter_complex "fps=10,paletteuse" $TARGET.mov
```
