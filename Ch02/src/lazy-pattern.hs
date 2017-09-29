
heavyPred :: Int -> Bool
heavyPred n = even $ length $ foldl (++) "" $ replicate n "x"

f n = if heavyPred n then Just n else Nothing

test1 = case f 10000 of Just n -> n
test2 = case f 10000 of Just n -> 0
test3 = case f 10000 of ~(Just n) -> 0 --fast
test3' = case f 10001 of ~(Just n) -> 0 --fast
test4 = case f 10000 of Just _ -> 0
test4' = case f 10000 of _ -> 0