{-# OPTIONS_GHC -Wall #-}

module Golf where 

-- Exercise 1 Hopscotch
skips :: [a] -> [[a]]
skips lst = map func [1.. length lst]
    where
        indexedLst = zip [1..] lst
        filteredLst pos = filter ((\n (x, _) -> x `mod` n == 0) pos) indexedLst
        func pos = map snd (filteredLst pos)

-- Exercise 2 Local maxima
localMaxima :: [Integer] -> [Integer]
localMaxima (x:y:z:zs)
 | x < y && y > z = y : localMaxima (y:z:zs)
 | otherwise = localMaxima (y:z:zs)
localMaxima _ = []

-- Exercise 3 Histogram
countlist :: [Integer] -> [Integer]
countlist lst = map count [0..9]
    where
        count n = foldl (\x _-> x + 1) 0 (filter (== n) lst)

histogram :: [Integer] -> String
histogram lst = unlines (map transformlist (reverse [1..m])) ++ "==========\n" ++ "0123456789\n"
    where
        countedlist = countlist lst
        m = maximum countedlist
        transformlist n = concatMap (\x -> if x >= n then "*" else " ") countedlist
