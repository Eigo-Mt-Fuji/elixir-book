* (商品の値段が入った)配列を定義する
  * fetch: コレクション内のN番目の要素を取得(取得できない場合)
    * [動画](./lesson4-enums-fetch-first.gif)

  * filter: コレクション内で特定の条件を満たす要素のみ抽出する
    * [動画](./lesson4-enums-fetch-first.gif)

  * any: コレクション内の要素のいずれかが〜である場合trueを返す
    * [動画](./lesson4-enums-fetch-first.gif)

## fetch
* (本の名前, カテゴリ)配列を定義する


```
cd elixir-ex-cli-sample/
iex -S mix

# 本の名前, カテゴリを持つ配列を定義
book_samples_1 = [ 
    %{:name => "Elixir handbook",:category => "programming"}, 
    %{:name => "Erlang handbook",:category => "programming"}, 
    %{:name => "Detective Poirot",:category => "novel"}
]
{:ok, first} = Enum.fetch(book_samples_1, 0) # 先頭の要素を取得する
is_map(first) # 取得結果(first)がMap型であることを確認
IO.puts(first.name) # 取得結果(first)から本の名前が得られることが確認できます
```

* 最後尾の要素を取得する

```
pos = length(book_samples_1) - 1
{:ok, last} = Enum.fetch(book_samples_1, pos)
IO.puts(last.name)
```

* 中央の要素を取得する

```
pos = div(length(book_samples_1) - 1, 2) 
result = Enum.fetch(book_samples_1, pos)
is_tuple(result)
elem(result, 0)
elem(result, 1)
IO.puts(middle.name)
```

* 範囲外の要素にアクセスする

```
pos = 10
result = Enum.fetch(book_samples_1, pos)
IO.inspect(result)
if result === :error, do: IO.puts("エラー: リスト範囲外の要素にアクセスしました")
```

```
pos = -1
result = Enum.fetch(book_samples_1, pos)
if result === :error, do: IO.puts("エラー: リスト範囲外の要素にアクセスしました")
```

## any
* (本の名前, カテゴリ, 値段, セールフラグ)のリストを定義する

```
book_samples_2 = [ 
    %{
        :name => "Elixir handbook",
        :category => "programming",
        :price => 4980,
        :sale => true
    },
    %{
        :name => "Erlang handbook",
        :category => "programming",
        :price => 4980,
        :sale => false
    },
    %{
        :name => "Detective Poirot",
        :category => "novel",
        :price => 4980,
        :sale => false
    }
]
```

* セール中の商品の有無を判定する

```
exists_sale = Enum.any?(book_samples_2, fn book -> book.sale === true end)
IO.puts(exists_sale)
```

## filter

* (本の名前,カテゴリ,値段,著者,セールフラグ)のリストを定義する

```
book_samples_3 = [ 
    %{
        :name => "Elixir handbook",
        :category => "programming",
        :price => 4980,
        :sale => true,
        :author => "Sir Elixir"
    },
    %{
        :name => "Erlang handbook",
        :category => "programming",
        :price => 4980,
        :sale => false,
        :author => "Sir Elixir"
    },
    %{
        :name => "Detective Poirot",
        :category => "novel",
        :price => 4980,
        :sale => false,
        :author => "Poirot"
    }
]
```

* 本の著者が 'Sir Elixir' かつ セール中の本だけを抽出する

```
filtered_books = Enum.filter(book_samples_3, fn book -> book.sale === true and book.author === "Sir Elixir" end)
Enum.each(filtered_books, fn fb -> IO.puts(fb.name) end)  
```
