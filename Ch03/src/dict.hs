import qualified Data.Map.Strict as M

data TreeDict k v = TDEmpty
                  | TDNode k v (TreeDict k v) (TreeDict k v)
                  deriving (Show)

insert :: Ord k => k -> v -> TreeDict k v -> TreeDict k v
insert k v TDEmpty = TDNode k v TDEmpty TDEmpty
insert k v (TDNode k' v' l r)
  | k < k' = TDNode k' v' (insert k v l) r
  | k > k' = TDNode k' v' l (insert k v r)
  | otherwise = TDNode k' v l r

dict :: TreeDict String Integer
dict = insert "hiratara" 39
     . insert "shu1" 0
     . insert "masahiko" 63
     $ TDEmpty

lookup' :: Ord k => k -> TreeDict k v -> Maybe v
lookup' _ TDEmpty = Nothing
lookup' k (TDNode k' v' l r)
  | k < k' = lookup' k l
  | k > k' = lookup' k r
  | otherwise = Just v'


dict' :: M.Map String Integer
dict' = M.insert "hiratara" 39
      . M.insert "shu1" 0
      . M.insert "masahiko" 63
      $ M.empty