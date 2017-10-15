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
## 7.3.2 Text の利用 (P.240 2つ目のシェル)

誤:
```bash
ghci> :set -XOverloadedStrings
ghci> import qualified Data.Text as T
ghci> simon :: Text
ghci> simon = "Many Simons."
ghci> :t T.pack
T.pack :: String -> Text
ghci> :t T.unpack
T.unpack :: Text -> String
```

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

## 7.4.1 Vector の基本 (P.243 最初のコード)
誤植じゃないかも。

誤:
```haskell
main :: IO ()
main = do
  let animals = V.fromList ["Dog", "Pig", "Cat", "Fox", "Mouse", "Cow", "Horse"]
  print . V.sum . V.map length $ animals
```

正:
```haskell
import qualified Data.Vector as V

main :: IO ()
main = do
  let animals = V.fromList ["Dog", "Pig", "Cat", "Fox", "Mouse", "Cow", "Horse"]
  print . V.sum . V.map length $ animals
```

## 7.5.2 パーサコンビネータ (P.250 1つ目のコード)
誤植ではないかもしれない。

誤:
```haskell
animal :: Parser Animal
animal = (string "Dog" >> return Dog) <|> (string "Pig" >> return Pig)
```

正:
```haskell
import Control.Applicative
data Animal = Dog | Pig deriving Show

animal :: Parser Animal
animal = (string "Dog" >> return Dog) <|> (string "Pig" >> return Pig)
```

## 7.5.5 足し算のパーサを作る (P.254 下段のコード)

誤:
```haskell
import qualified Data.Text as T
import Data.Attoparsec.Text hiding (take)
```

正:
```haskell
{-# LANGUAGE OverloadedStrings #-}
import Data.Attoparsec.Text hiding (take)
```

## 7.6.1 aeson の利用 (P.258 下段のコード)
誤植じゃないかもしれない。

誤:
```haskell
deriveJSON defaultOptions ''Department

taro :: Human
taro = Human { name = "Taro" , age = 30 }
```

正:
```haskell
deriveJSON defaultOptions ''Department

-- taro :: Human
-- taro = Human { name = "Taro" , age = 30 }
```

## 7.6.1 aeson の利用 (P.259 下段のコード)

誤:
```haskell
data IntStr = IntData Int | StrData String
encode $ IntData 999
encode $ StrData "World!"
```

正:
```haskell
data IntStr = IntData Int | StrData String deriving Show

deriveJSON defaultOptions ''IntStr

main :: IO ()
main = do
  B.putStrLn $ encode $ IntData 999
  B.putStrLn $ encode $ StrData "World!"
```

## 7.6.2 JSONのデータ構造を直接操作する (P.260 下段コード)
誤植ではないかもしれない。

誤:
```haskell
nameListValue :: Value
nameListValue = ...
```

正:
```haskell
{-# LANGUAGE OverloadedLists #-}
{-# LANGUAGE OverloadedStrings #-}

import Data.Aeson
nameListValue :: Value
nameListValue = ...
```

## 7.6.2 JSONのデータ構造を直接操作する (P.263 コラム1つ目の最後のコード)
誤植ではないかもしれない。

誤:
```haskell
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

## 7.6.2 JSONのデータ構造を直接操作する (P.263 コラム2つ目のコード)

誤:
```haskell
{-# LANGUAGE DeriveGeneric #-}
import GHC.Generics
data Person = ...
```

正:
```haskell
{-# LANGUAGE DeriveGeneric #-}
import GHC.Generics
import Data.Aeson
data Person = ...
```

# 8章
## 8.2.2 MVar の利用 (P.286 コード)
誤植ではないかもしれない。

誤:
```haskell
actionIO :: IO a -> IO a
actionIO action = ...
```

正:
```haskell
import Control.Exception

actionIO :: IO a -> IO a
actionIO action = ...
```

## 8.2.2 MVar の利用 (P.287 コード)
誤植ではないかもしれない。

誤:
```haskell
module Lock
( Lock
, newLock
, withLock
) where

import Control.Concurrent
import Control.Exception

data Lock a = Lock (MVar a)
```

正:
```haskell
module Lock
( Lock
, newLock
, withLock
) where

import Control.Concurrent

data Lock a = Lock (MVar a)
```

## 8.2.3 複数スレッドからのアクセス (P.288 下段コード)
誤植ではないかもしれない。

誤:
```haskell
data ShareResource a = ...
```

正:
```haskell
import Control.Concurrent
import Control.Exception

data ShareResource a = ...
```

## 8.2.3 複数スレッドからのアクセス (P.289 コード)
誤植ではないかもしれない。

誤:
```haskell
main :: IO ()
main = ...
```

正:
```haskell
import Control.Monad

main :: IO ()
main = ...
```

## 8.5.1 基本の利用 (P.301 コード)
誤植ではないかも。

コードをコンパイルするには `http-conduit` パッケージのインストールが別途必要になる。

# 9章
## 9.1.3 ディレクトリ構成 (P.311 l.5)
何を言っているのかわかりませんでした・・・。

> Stack による hjq.cabal の初期の設定では、テストは src ディレクトリ次のモジュールを読み込むようになっているため、すぐにテストが書ける

## 9.2.1 cabalファイルの編集 (P.313 l.5)
たぶん誤植

誤:
> さっそく、HUnitライブラリを提供しているHUnitパッケージをbuild-dependsに追加しましょう。`hs-source-dirs`を次のようにします。

正:
> さっそく、HUnitライブラリを提供しているHUnitパッケージをbuild-dependsに追加しましょう。`hjq-test`を次のようにします。

## 9.3.2 フィルタ文字列のパーサを書く (P.318 l.2)

誤:
> このテストがグリーンになるように実装 (`JqFilterParser`) を修正しなくてはいけません。

正:
> このテストがグリーンになるように実装 (`jqFilterParser`) を修正しなくてはいけません。

## 9.3.2 フィルタ文字列のパーサを書く (P.318 l.7)

誤:
> これで、`jqFilterparserTest` も成功するようになりました。

正:
> これで、`jqFilterParserSpacesTest` も成功するようになりました。

## 9.5 まとめ (P.326 注釈)

誤:
> インストールせず試したいときは stack build 後に `stack exec hjq` と実行して下さい。

正:
> インストールせず試したいときは stack build 後に `stack exec hjq-exe` と実行して下さい。

# 10章
## 10.3.3 RDBMS と対応するデータ型の定義 (P.340 最後の行)

誤:
> RDBMS に対応したデータ型生成用のドライバ、スキーマ名、テーブル名、`driving` 句に追加する型クラス名を渡す必要があります。

正:
> RDBMS に対応したデータ型生成用のドライバ、スキーマ名、テーブル名、`deriving` 句に追加する型クラス名を渡す必要があります。

## 10.3.3 RDBMS と対応するデータ型の定義 (P.341 注釈)

誤:
> *25 `スキーム名` とは SQLite ではデータベース名のことであり...

正:
> *25 `スキーマ名` とは SQLite ではデータベース名のことであ

## 10.3.5 モデルの実装 (P.349 l.1)
誤:
> `Model.WeightRecorder` についても同様にデータ登録と...

正:
> `Model.WeightRecord` についても同様にデータ登録と...

## 10.5.2 テンプレートファイルの保存先 (P.359 l.4)
この一段落と続くコードが、まるまる何言ってるのかわかりませんでした。

> 続いて data-files `次のファイルに` ...

## 10.6.2 アプリケーション本体の完成 (P.369 注釈)

誤:
> 外部へのインタフェースなのに対し、 `src/Web.WeightRecorde.hs` はアプリケーション本体として...

正:
> 外部へのインタフェースなのに対し、 `src/Web.WeightRecorder.hs` はアプリケーション本体として...

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