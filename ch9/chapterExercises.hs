module ChapterExercises9 where

import Data.Char -- Apparently this will be needed.

-- DATA.CHAR
-- 1) Query the types of isUpper and toUpper.
-- isUpper :: Char -> Bool
-- toUpper :: Char -> Char
-- 2) Given the following behaviours, which would we use to write a
-- function that filters all the uppercase letters out of a String?
-- Write a function such that myFunc "HbEfLrLxO" returns "HELLO".
dc2 :: String -> String
dc2 = filter isUpper

-- 3) Write a function that will capitalize the first letter of a string.
dc3 :: String -> String
dc3 [] = []
dc3 (x:xs) = toUpper x : xs

-- 4) Now make a new version of that function that is recursive such
-- that if you give it the input woot it will holler back at you WOOT.
dc4 :: String -> String
dc4 str = [toUpper x | x <- str]

-- 5) Use head to capitalize the first letter of a string and return as a result.
dc5 :: String -> Char
dc5 = toUpper . head

-- 6) Cool. Good work. Now rewrite it as a composed pointfree version.
-- ALREADY DID, SUCK IT NEWBS
--
-- CIPHERS
-- See separate file cipher.hs in repo root.
--
-- WRITING MY OWN STANDARD FUNCTIONS
-- 1) myOr returns True if any Bool in the list is True
myOr :: [Bool] -> Bool
myOr [] = False
myOr (False:xs) = myOr xs
myOr (True:_) = True

-- 2) myAny returns True if a -> Bool applied to any of the values in the list returns True
myAny :: (a -> Bool) -> [a] -> Bool
myAny _ [] = False
myAny f (x:xs)
  | f x = True
  | otherwise = myAny f xs

-- 3)  After you write the recursive myElem, write another version that uses any.
myElem :: Eq a => a -> [a] -> Bool
myElem y xs
  | null xs = False
  | head xs == y = True
  | otherwise = myElem y (tail xs)

myElem2 :: Eq a => a -> [a] -> Bool
myElem2 x = myAny (== x)

-- 4) Implement myReverse
myReverse :: [a] -> [a]
myReverse [] = []
myReverse [x] = [x]
myReverse (x:xs) = myReverse xs ++ [x]

-- 5) squish flattens a list of list into a list
squish :: [[a]] -> [a]
squish [] = []
squish [x] = x
squish (x:xs) = x ++ squish xs

-- 6) squishMap maps a function over a list and concatenates the results.
squishMap :: (a -> [b]) -> [a] -> [b]
squishMap f [x] = f x
squishMap f (x:xs) = f x ++ squishMap f xs
squishMap _ _ = []

-- 7) squishAgain flattens a list of lists into a list by using the squishMap function.
squishAgain :: [[a]] -> [a]
squishAgain = squishMap id

-- 8) myMaximumBy takes a comparison function and a list, and returns the greatest
-- element of the list based on the last value that compare returned GT for.
myMaximumBy :: (a -> a -> Ordering) -> [a] -> a
myMaximumBy _ [] = undefined -- Impossble to return a value... I think?
myMaximumBy func (z:zs) = go func z zs
  where
    go _ x [] = x
    go f x (y:ys)
      | f y x == GT = go f y ys
      | otherwise = go f x ys

-- 9) Now make myMinimumBy that works the other way around.
myMinimumBy :: (a -> a -> Ordering) -> [a] -> a
myMinimumBy func = myMaximumBy (flip func)

-- 10) Using the myMinimumBy and myMaximumBy functions, write your own maximum and minimum.
myMaximum :: (Ord a) => [a] -> a
myMaximum = myMaximumBy compare

myMinimum :: (Ord a) => [a] -> a
myMinimum = myMinimumBy compare
