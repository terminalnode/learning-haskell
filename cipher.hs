-- Book said this module will be used in later chapters, therefor
-- it's placed at the project root instead of in chapter 9 where
-- it actually belongs.
module Cipher where

getNextChar :: Char -> Char
getNextChar 'z' = 'a'
getNextChar 'Z' = 'A'
getNextChar c = succ c

getPrevChar :: Char -> Char
getPrevChar 'a' = 'z'
getPrevChar 'A' = 'Z'
getPrevChar c = pred c

shiftNum :: (Integral a, Eq a) => String -> a -> String
shiftNum str num
  | num < 0 = shiftNum (map getPrevChar str) (num + 1)
  | num > 0 = shiftNum (map getNextChar str) (num - 1)
  | otherwise = str
