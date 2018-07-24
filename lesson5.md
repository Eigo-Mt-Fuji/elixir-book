# ElixirでCliアプリケーションを作る

## 練習問題

* 入力した名前の動物が存在する場合、画像を表示する

## 雛形

```
$ git clone -b master https://github.com/Eigo-Mt-Fuji/elixir-ex-cli-sample.git
$ cd elixir-ex-cli-sample
$ mix deps.get
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
$ iex -S mix
iex(1)> tesla = GoogleApi.CustomSearch.V1.Connection.new
iex(2)> response = GoogleApi.CustomSearch.V1.Api.Cse.search_cse_list(tesla, "ネコ", [{:cx, "<search-engine-id>"},{:key, "<api-key>"}, {:search_type, "image"}, {:lr, "lang_ja"}, {:num, "2"}])
iex(3)> contents = elem(response, 1)
iex(4)> Enum.at(contents.items, 0)
iex(5)> {:ok, first} = Enum.fetch(contents.items, 0)
iex(6)> image_url = Enum.at(first.pagemap["cse_image"], 0)["src"]
```

* 画像表示(System.cmdを利用)

```elixir
iex(7)> System.cmd "open", [image_url]
```

## 回答例

```bash
$ git clone -b lesson-20170724-2 https://github.com/Eigo-Mt-Fuji/elixir-ex-cli-sample.git elixir-ex-cli-sample-lesson-20170724-2
$ cd elixir-ex-cli-sample-lesson-20170724-2
$ mix deps.get
$ less lib/LessonAnimalsCli.ex
$ iex -S mix
iex(1) > Lesson.AnimalsCli.main()
```
