# 正誤表

- [サポートページ](http://gihyo.jp/book/2017/978-4-7741-9237-6/support)

## P.169リスト

誤:
```
game :: Stock -> [(Score, Hand, Player)
```

正:
```
game :: Stock -> [(Score, Hand, Player)]
```

## P.260 リスト
誤:
```
{# LANGUAGE OverloadedLists}
nameListValue :: Value
```

正:
```
{-# LANGUAGE OverloadedLists #-}
nameListValue :: Value
```

また、赤文字は `{-# LANGUAGE OverloadedLists #-}` につくべき。

# 2章
## 2.2.1 数値 (P.25 注釈)

誤:
> `中値`演算子とあえて書いているようにHaskellでは中置しない演算子もあります。ただし、Haskellにおける演算子はほぼすべて2つの項(2引数)をとる`中値`演算子です。2.4.5で解説します。

正:
> `中置`演算子とあえて書いているようにHaskellでは中置しない演算子もあります。ただし、Haskellにおける演算子はほぼすべて2つの項(2引数)をとる`中置`演算子です。2.4.5で解説します。

## 2.4.5 中置演算子 (P.49 3段落目)

誤:
> `中値`演算子は(と)で囲むことで通常の関数と同じように利用できます。第一引数が`中値`演算子の左側、第二引数が`中値`演算子の右側だったものになると覚えてください。

正:
> `中置`演算子は(と)で囲むことで通常の関数と同じように利用できます。第一引数が`中置`演算子の左側、第二引数が`中置`演算子の右側だったものになると覚えてください。

## 2.9.1 モジュール (P.75 l.5)

誤:
> () で明示的に参照する識別子を列挙するか、`qualifiedas` を使ってどのモジュール由来の識別子なのか区別できるように修飾しておくのがいいでしょう。

正:
> () で明示的に参照する識別子を列挙するか、`qualified ... as` を使ってどのモジュール由来の識別子なのか区別できるように修飾しておくのがいいでしょう。

## 2.9.3 パッケージ (P.78 l.1)
これは誤植ではないかもしれないです。

誤:
> また、検索条件を::から始めると、型で検索ができます。ghcパッケージの...

正:
> また、検索条件を::から始めると、型で検索ができます。`Char -> String -> [String]` の型で検索してみると。ghcパッケージの...

# 3章
## 3.4.2 データコンストラクタ名の規則 (P.92 注釈)

誤:
> 以後も同様に`derving`句を指定します。

正:
> 以後も同様に`deriving`句を指定します。

## 3.7.1 type (P.104 l.3)

誤:
> 例えば、Either a b型(2.7.4参照) `ととともに` アプリケーション内で

正:
> 例えば、Either a b型(2.7.4参照) `とともに` アプリケーション内で

## 3.10.5 deriving によるインスタンス定義 (P.130 l.1)
たぶん誤植だと思うけど、違うかもしれない。

誤:
> HaskellのPreludeではデータを`現`すほとんどの型が...

正:
> HaskellのPreludeではデータを`表`すほとんどの型が...

# 4章
このあたりから実行できないコードが混ざってくるので、誤植かどうか判断がつきづらい部分がある。

## 4.1.2 I/Oアクションの組み立て (P.136 1つめのコード)

誤:
```bash
Prelude>
Prelude> return ("Hoge", "Piyo") >>= (\(x, y) -> putStrLn x >>= (\_ -> putStrLn y))
Hoge
Piyo
```

正:
```bash
Prelude> return ("Hoge", "Piyo") >>= (\(x, y) -> putStrLn x >>= (\_ -> putStrLn y))
Hoge
Piyo
```

## 4.3.1 標準入出力関数 (P.142 コラムのコード)
誤植かどうか微妙

誤:
```haskell
main :: IO ()
main = do
  hSetBuffering stdin LineBuffering
  x <- getChar
  print x
  x <- getChar
  print x
  x <- getChar
  print x
  xs <- getLine
  putStrLn xs
```

正:
```haskell
import System.IO
main :: IO ()
main = do
  hSetBuffering stdin LineBuffering
  x <- getChar
  print x
  x <- getChar
  print x
  x <- getChar
  print x
  xs <- getLine
  putStrLn xs
```

## 4.4.2 権限情報 (P.151 l.3)

誤:
> 同じく System.`Drectory`モジュールの

正:
> 同じく System.`Directory`モジュールの

## 4.4.2 権限情報 (P.153 コラム l.2)

誤:
> System.`Drectory`モジュールの

正:
> System.`Directory`モジュールの

## 4.4.2 権限情報 (P.154 コラム Windows の実行ファイル対策のコード)

誤:
```bash
Prelude System.Directory> findExecutable $ "ghc" + exeExtension
...
Prelude System.Directory> findExecutables $ "ghc" + exeExtension
...
```

正:
```bash
Prelude System.Directory> findExecutable $ "ghc" ++ exeExtension
...
Prelude System.Directory> findExecutables $ "ghc" ++ exeExtension
...
```

`+` ではなく `++` が正しい。

## 4.5.3 独自の例外を定義する (P.161 l.9)

誤:
> throwMyException関数が引数の値によって独自の例外を`thorwIO`で発生させます。

正:
> throwMyException関数が引数の値によって独自の例外を`throwIO`で発生させます。

# 5章
## 5.3.2 Applicative (P.178 l.1)

誤:
> Human データコンストラクタは、`Strig` -> Int -> Gender...

正:
> Human データコンストラクタは、`String` -> Int -> Gender...

## 5.6.2 ミュータブルな配列 (P.190 l.2)

誤:
> 第二引数で指定した初期値のリストの長さ`がが`配列のサイズよりも


正:
> 第二引数で指定した初期値のリストの長さ`が`配列のサイズよりも

# 6章
## 6.2.1 テンプレート型プログラミング (P.216 下段のコード)

誤:
```haskell
concatMultiFiles filePaths dst =
  handleMultiFiles filepaths (\hdl -> copyFile hdl dst)
```

正:
```haskell
concatMultiFiles filePaths dst =
  handleMultiFiles filePaths (\hdl -> copyFile hdl dst)
```

## 6.2.2 Haskell のスタイル (P.219 1つ目のコード)

誤:
```haskell
  handleMultiFiles filePaths $ \hdl ->
    hClose hdl
```

正:
```haskell
  handleMultiFiles filePaths $ \hdl -> do
    hClose hdl
```

## 6.4.1 インスタンス宣言の独立 (P.223 コード)
誤植ではないかもしれない。

`Ord` クラスの2行目の `::` の前にたぶん空白が1つ必要？(今までのコード例から推測)

## 6.4.1 インスタンス宣言の独立 (P.224 下段のコード)

誤:
```haskell
class Triple a where
  triple :: a -> a

instance Triple Int where
  triple n = n * 3

instance Triple String where
  triple s = s ++ s ++ s
```

正:
```haskell
{-# LANGUAGE FlexibleInstances #-}

class Triple a where
  triple :: a -> a

instance Triple Int where
  triple n = n * 3

instance Triple String where
  triple s = s ++ s ++ s
```

# 7章
## P.240
正しくは以下のどちらか。

`import as` の場合。

```bash
ghci> :set -XOverloadedStrings
ghci> import Data.Text as T
ghci> simon = "Many Simons." :: Text
ghci> :t T.pack
T.pack :: String -> Text
ghci> :t T.unpack
T.unpack :: Text -> String
```

`import qualified as` の場合。たぶん書籍ではこちらを意図していたと思われる。

- `simon :: Text` の行がいらなくて、次の行で `simon = "Many Simons." :: T.Text` としなければならない。

```bash
ghci> :set -XOverloadedStrings
ghci> import qualified Data.Text as T
ghci> simon = "Many Simons." :: T.Text
ghci> :t T.pack
T.pack :: String -> T.Text
ghci> :t T.unpack
T.unpack :: T.Text -> String
```

## P.243
最初のコード例の先頭に `import qualified Data.Vector as V` が必要。

## P.247
補足事項。コードを動かすためには以下の行を自分で追記する必要がある。

```haskell
import Data.List.Split

data HMS = HMS Int Int Int deriving Show
```


## P.250
補足事項。コードを動かすためには以下の2行を自分で追記する必要がある。

```haskell
import Control.Applicative
data Animal = Dog | Pig deriving Show
```

## P.254
補足事項。ページ下部のコードを動かすためには `import qualified Data.Text as T` の代わりに `{-# LANGUAGE OverloadedStrings #-}` が必要。

## P.258
`taro` の定義が重複しているためコンパイルエラーとなるため、コメントアウトする。

```haskell
-- taro :: Human
-- taro = Human { name = "Taro" , age = 30 }
```

## P.259
補足事項。出力結果は `B.putStrLn $ encode nameList` を整形したもの。

## P.259
コードが中途半端になっている。

```haskell
data IntStr = IntData Int | StrData String deriving Show

deriveJSON defaultOptions ''IntStr

main :: IO ()
main = do
  B.putStrLn $ encode $ IntData 999
  B.putStrLn $ encode $ StrData "World!"
```

## P.260

コードを動かすためには以下の言語拡張と `import` が必要

```haskell
{-# LANGUAGE OverloadedLists #-}
{-# LANGUAGE OverloadedStrings #-}

import Data.Aeson
```

## P.261
補足事項。完全なコードはこちら。

```haskell
{-# LANGUAGE TemplateHaskell   #-}

import Data.Aeson
import Data.Aeson.TH
import qualified Data.ByteString.Lazy.Char8 as B

data Human = Human
  { name :: String
  , age :: Int
  } deriving Show

deriveJSON defaultOptions ''Human

data Department = Department
  { departmentName :: String
  , coworkers :: [Human]
  } deriving Show

deriveJSON (defaultOptions
  { fieldLabelModifier = \s -> case s of
      "departmentName" -> "name"
      t -> t
  } ) ''Department

taro :: Human
taro = Human { name = "Taro" , age = 30 }

saburo :: Human
saburo = Human { name = "Saburo" , age = 31 }

shiro :: Human
shiro = Human { name = "Shiro" , age = 31 }

matsuko :: Human
matsuko = Human { name = "Matsuko" , age = 26}

nameList :: [Department]
nameList =
  [ Department
    { departmentName = "General Affairs"
    , coworkers =
      [ taro
      , matsuko
      ]
    }
  , Department
    { departmentName = "Development"
    , coworkers =
      [ saburo
      , shiro
      ]
    }
  ]

main :: IO ()
main = B.putStrLn $ encode nameList
```

## P.263
補足事項。完全なコード

```haskell
{-# LANGUAGE OverloadedStrings #-}
import Data.Aeson
import Data.Aeson.Types

data Person = Person
  { name :: String
  , age :: Int
  } deriving Show

instance ToJSON Person where
  toJSON (Person n a) =
    object ["name" .= n, "age" .= a]

instance FromJSON Person where
  parseJSON (Object v) = Person
    <$> v .: "name"
    <*> v .: "age"
  parseJSON i = typeMismatch "Person" i
```

## P.263 Generics の利用のコード
`import Data.Aeson` が足りないのでコンパイルできない。

# 8章
## P.286

`import Control.Exception` が必要

## P.287

`import Control.Exception` が不要

## P.288

```haskell
import Control.Concurrent
import Control.Exception
```

が必要。


## P.289

`import Control.Monad` が必要

## P.301

補足事項: `http-conduit` パッケージが必要

# 9章
## P.311
日本語が意味不明

> Stack による hjq.cabal の初期の設定では、テストは src ディレクトリ `次` のモジュールを読み込むようになっているため、すぐにテストが書ける

## P.313
たぶんだけど。 `hs-source-dirs` じゃなくて `hjq-test`

## P.318
実装 (`jqFilterParser`)

## P.318
文脈からたぶん、`jqFilterParserSpacesTest` も成功するようになりました。が正しい

## P.326
`stack exec hjq-exe` で実行する

# 10章
## P.340
`deriving`

## P.341
`スキーマ名`

## P.349
`Model.WeightRecord`

## P.359
続いて data-files `次のファイルに` ?
というか、この部分全体的に何言ってるのかわかんない。

## P.369
`src/Web.WeightRecorder.hs`

# 11章
## P.377
`Client`

## P.386
`stack runghc counter.hs`

## P.387
部分を適切に(を)切り出す(と)方法などがあります。

## P.389
`Maybe AuctionItem`

## P.388
11.3.1 のコードは全く動かないので打ち込んでも無駄。

- `deriveJSON defaultOptions ''UUID` いらない
- コードの定義順のせいでコンパイルできない
- 言語拡張と `import` は自分で追加する