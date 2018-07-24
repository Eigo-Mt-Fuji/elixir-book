# ElixirでCliアプリケーションを作る

## 練習問題

* 入力した名前の動物が存在する場合、画像を表示する

## 雛形

```
$ git clone -b master https://github.com/Eigo-Mt-Fuji/elixir-ex-cli-sample.git
$ cd elixir-ex-cli-sample
$ vi lib/LessonAnimalsCli.ex # TODO: 箇所を実装する
$ iex -S mix
$ Lesson.AnimalsCli.main() # 試しに実行
```

## 利用する技術(習得済み)

* 標準入力
* 関数
* Enumモジュール(any?やfilter, countなど)
* Google Api
* IO.gets
* Animals Text

### 利用する技術(今回新たに追加)

* GoogleApi

```elixir
$ cd elixir-ex-cli-sample
$ git stash # 作業中のファイルを退避/clear
$ git fetch origin
$ git checkout -b master origin/master
$ git pull origin master
$ iex -S mix
response = GoogleApi.CustomSearch.V1.Api.Cse.search_cse_list(tesla, "ネコ", [{:cx, "013595435806448571340:qrcz-ciehnm"},{:key, "AIzaSyBDBmhYu2qeGV_Gx1TaVvfKQkhzyHib3o0"}, {:search_type, "image"}, {:lr, "lang_ja"}, {:num, "2"}])
contents = elem(response, 1)
Enum.at(contents.items, 0)
{:ok, first} = Enum.fetch(contents.items, 0)
image_url = Enum.at(first.pagemap["cse_image"], 0)["src"]
```

* 画像表示(System.cmdを利用)

```elixir
System.cmd "open", [image_url]
```
