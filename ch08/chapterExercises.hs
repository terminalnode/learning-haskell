{-# LANGUAGE NoMonomorphismRestriction #-}

module ChapterExercises8 where
import Data.List (intersperse) -- Needed for digits to words function
-- REVIEW OF TYPES
-- 1) What is the type of [[True, False], [True, True], [False, True]]?
--    d) [[Bool]]
-- 2) Which of the following has the same type as the above?
--    b) [[3 == 3], [6 > 5], [3 < 4]]
-- 3) For the following function:
rewFunc :: [a] -> [a] -> [a]
rewFunc x y = x ++ y
--    which of the following is true?
--    d) all of the above
-- 4) For the rewFunc code above, which is a valid application of func to both of its args?
--    b) func "Hello" "World"

-- REVIEWING CURRYING
cattyConny :: String -> String -> String
cattyConny x y = x ++ " mrow " ++ y

flippy :: String -> String -> String
flippy = flip cattyConny

appedCatty :: String -> String
appedCatty = cattyConny "woops"

frappe :: String -> String
frappe = flippy "haha"

-- 1) What is the value of `appedCatty "woohoo!"`?
--    "woops mrow woohoo!"
-- 2) frappe "1"?
--    "1 mrow haha"
-- 3) frappe (appedCatty "2")?
--    frappe "woops mrow 2"
--    "woops mrow 2 mrow haha"
-- 4) appedCatty (frappe "blue")
--    appedCatty "blue mrow haha"
--    "woops mrow blue mrow haha"
-- 5) cattyConny (frappe "pink")
--               (cattyConny "green" (appedCatty "blue"))
--    FFS
--    frappe "pink"        -> "pink mrow haha"
--    appedCatty "blue"    -> "woops mrow blue"
--    cattyConny "green" y -> "green mrow " ++ y
--    x = "pink mrow haha"
--    y = "green mrow woops mrow blue"
--    ... "pink mrow haha mrow green mrow woops mrow blue"
-- 6) cattyConny (flippy "Pugs" "are") "awesome"
--    "are mrow Pugs mrow awesome"

-- RECURSION
-- 1) Write out the steps for reducing dividedBy2 15 2
-- to its final answer according to the Haskell code.
--   dividedBy2 15 2
--   go 15 2 0
--   go 13 2 1
--   go 11 2 2
--   go 9  2 3
--   go 7  2 4
--   go 5  2 5
--   go 3  2 6
--   go 1  2 7
--   (7, 1)
-- 2) Write a function that recursively snums all numbers from 1 to n, n being the argument.
sumEmAll :: (Eq a, Num a) => a -> a
sumEmAll 0 = 0
sumEmAll n = n + sumEmAll (n - 1)
-- 3) Write a function that multiplies two integral numbers using recursive summation.
mulEmAll :: (Integral a) => a -> a -> a
mulEmAll _ 0     = 0
mulEmAll num times = num + (mulEmAll num (times - 1)) 

-- FIXING DIVIDEDBY
-- Fix our dividedby!
--   If either denominator or numerator is negative, result should be negative.
--   If both denominator and numerator is negative, result should be positive.
--   If denominator is zero, result is undefined. We will return DividedByZero below.
data DividedResult =
     Result (Integer, Integer)
   | DividedByZero
     deriving Show

dividedBy :: Integer -> Integer -> DividedResult
dividedBy num denom
  | (denom == 0)           = DividedByZero
  | (num > 0 && denom > 0) = Result (go   (num)   (denom) 0 ( 1))
  | (num < 0 && denom < 0) = Result (go (- num) (- denom) 0 ( 1))
  | (num < 0 && denom > 0) = Result (go (- num)   (denom) 0 (-1))
  | otherwise              = Result (go   (num) (- denom) 0 (-1))
  where go n d count sign
            | n < d = ((sign * count), (sign * n))
            | otherwise =
                go (n - d) (d) (count + 1) sign

-- Seems to work!

-- MCCARTHY 91 FUNCTION
--   Returns n - 10 if n is more than 100
--   Returns 91 otherwise.
mc91 :: (Integral a) => a -> a
mc91 n
  | (n > 100) = (-) n 10
  | otherwise = 91

-- NUMBERS INTO WORDS
-- wordNumber 012340 should return "one-two-three-four-zero"
-- (and `show 012340` is cheating)
digitToWord :: Int -> String
digitToWord n
  | n == 0    = "zero"
  | n == 1    = "one"
  | n == 2    = "two"
  | n == 3    = "three"
  | n == 4    = "four"
  | n == 5    = "five"
  | n == 6    = "six"
  | n == 7    = "seven"
  | n == 8    = "eight"
  | n == 9    = "nine"
  | otherwise = wordNumber n

wordNumber :: Int -> String
wordNumber n
  | n >= 0    = go n
  | otherwise = "minus-" ++ go (negate n)
  where go num = concat $ intersperse "-" (map digitToWord (digits num))

-- This is the hard part.
-- If we can find the first 10^n which is larger than n,
-- then mod num 10^(n-1) is the first digit.
digits :: Int -> [Int]
digits num = go num (magnitude num) []
  where go n mag list
         | mag == 1 = reverse list
         | otherwise = go n (divTen mag) $ incList n mag list
        divTen = (flip div) 10
        getDigit n mag = div (mod n mag) (divTen mag)
        incList n mag list = (getDigit n mag) : list

magnitude :: Int -> Int
magnitude n = go n 10
  where go num mag
         | (num < mag) = mag
         | otherwise   = go num (mag * 10)
-- YESSSSSSS, it's working!
