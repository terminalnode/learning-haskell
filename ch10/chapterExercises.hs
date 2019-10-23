module ChapterExercises10 where

-- Review exercises, not expected to use folds for these.
-- 1. Given the following sets of consonants and vowels:
stops :: String
stops = "pbtdkg"

vowels :: String
vowels = "aeiou"

-- 1a. Write a function that takes inputs from stops and vowels and make 3-tuples
-- of all possible stop-vowel-stop combinations. These will not all correspond to
-- real words in English, allthough the pattern is common enough that many will.
wup1a :: [(Char, Char, Char)]
wup1a = [(s1, v, s2) | s1 <- stops, s2 <- stops, v <- vowels]

-- 1b. Modify the function so that it only returns the combinations that begin with a p.
wup1b :: [(Char, Char, Char)]
--wup1b = filter (\(x, _, _) -> x == 'p') wup1a
wup1b = [('p', v, s2) | s2 <- stops, v <- vowels]

-- 1c. Now set up lists of nouns and verbs instead of stops and vowels and modify the
-- function to make the function tuples representing possible noun-verb-noun sentences.
nouns :: [String]
nouns =
  [ "the dog"
  , "the cat"
  , "the human"
  , "the hamburger"
  , "the molecule"
  , "the educational system"
  , "the child"
  , "Julius Caesar"
  ]

verbs :: [String]
verbs =
  [ "ate"
  , "ran over"
  , "murders"
  , "will devour"
  , "has castrated"
  , "ruins"
  , "crushes"
  , "campaigns against"
  ]

wup1c :: [(String, String, String)]
wup1c = [(n1, v, n2) | n1 <- nouns, n2 <- nouns, v <- verbs]

-- 2. What does the following mystery function do? What is its type? Verify in REPL.
-- It splits a string by its white spaces and creates a list.
-- It then divides the sum of the length of those words by the number of words.
-- It's type is Int and not Integral a because length returns an Int.
seekritFunc :: String -> Int
seekritFunc x = div (sum (map length (words x))) (length (words x))

-- 3. Pls rewrite using fractional division.
seekritFunc2 :: String -> Double
seekritFunc2 x = (/) sumMap (len (words x))
  where
    sumMap = sum (map len . words $ x)
    len = fromIntegral . length

-- Rewriting functions using folds
-- Time to rewrite some functions we made using recursion in previous chapters.
-- Try to make them point free.
-- 1. myOr returns True if any Bool in the list is True.
myOr :: [Bool] -> Bool
myOr = foldr (||) False

-- 2. myAny returns True if a -> Bool applied to any of the values
-- in the list returns True.
myAny :: (a -> Bool) -> [a] -> Bool
myAny = (myOr .) . map

-- 3. Write two versions of myElem. One version should use folding, and the other `any`.
myElem :: Eq a => a -> [a] -> Bool
-- Using any:
-- myElem = myAny . (==)
--
myElem = (foldr (||) False .) . map . (==)

-- 4. Implement myReverse, don't worry about trying to make it lazy.
myReverse :: [a] -> [a]
myReverse = foldl (flip (:)) []

-- 5. Write myMap in terms of foldr. It should work as the built-in map.
myMap :: (a -> b) -> [a] -> [b]
myMap = flip foldr [] . addTo
  where
    addTo f a b = f a : b

-- 6. Write myFilter in terms of foldr. It should work as the built-in filter.
myFilter :: (a -> Bool) -> [a] -> [a]
myFilter = flip foldr [] . selectiveAdd
  where
    selectiveAdd f a b
      | f a = a : b
      | otherwise = b

-- 7. squish flattens [[a]] into [a]
squish :: [[a]] -> [a]
squish = foldr (++) []

-- 8. squishMap works like concatMap
squishMap :: (a -> [b]) -> [a] -> [b]
squishMap = (squish .) . myMap

-- 9. Reuse squishMap to recreate squish.
squishAgain :: [[a]] -> [a]
squishAgain = squishMap id

-- 10. myMaximumBy takes a comparison function and a list and returns the greatest
-- element of the list based on the last value that the comparison returned GT for.
myMaximumBy :: (a -> a -> Ordering) -> [a] -> a
-- Not point-free version.
-- myMaximumBy f as = foldr go (head as) as
--   where
--     go a b
--       | f a b == GT = a
--       | otherwise     = b
--
-- Point-free version. \o/
myMaximumBy = foldr1 . go
  where
    go f a b
      | f a b == GT = a
      | otherwise   = b

-- 11. myMinimumBy does the opposite for myMaximumBy.
myMinimumBy :: (a -> a -> Ordering) -> [a] -> a
myMinimumBy = foldr1 . go
  where
    go f a b
      | f a b == LT = a
      | otherwise   = b
