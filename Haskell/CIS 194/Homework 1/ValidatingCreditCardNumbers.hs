{-# OPTIONS_GHC -Wall #-}

toDigits :: Integer -> [Integer]
toDigits x
 | x > 0     = toDigits (div x 10) ++ [mod x 10]
 | otherwise = []

toDigitsRev :: Integer -> [Integer]
toDigitsRev x
 | x > 0     = mod x 10 : toDigitsRev (div x 10)
 | otherwise = []

doubleEveryOther :: [Integer] -> [Integer]
doubleEveryOther []         = []
doubleEveryOther [x]        = [x]
doubleEveryOther (x:(y:zs)) = x : y * 2 : doubleEveryOther zs

sumDigits :: [Integer] -> Integer
sumDigits [] = 0
sumDigits (x:y)
 | x > 9     = div x 10 + mod x 10 + sumDigits y
 | otherwise = x + sumDigits y

validate :: Integer -> Bool
validate x = mod (sumDigits (doubleEveryOther(toDigitsRev x))) 10 == 0

main :: IO ()
main = do
 print (toDigits 12345)
 print (toDigitsRev 12345)
 print (doubleEveryOther [1,2,3])
 print (sumDigits  [16,7,12,5])
 print (validate 4012888888881881)
 print (validate 4012888888881882)