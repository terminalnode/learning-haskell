-- Exercises for Chapter 10: Folding Lists
-- End of chapter exercises are in chapterExercises.hs
module ExercisesCh10 where

import Data.Time

-- Exercises: Understanding folds
-- 1) uf1 will lead to the same result as which of the following?
uf1 :: Int
uf1 = foldr (*) 1 [1 .. 5]

-- uf1a = flip (*) [1..5] -- Invalid function
uf1b :: Int
uf1b = foldl (flip (*)) 1 [1 .. 5]

uf1c :: Int
uf1c = foldl (*) 1 [1 .. 5]

uf1answer :: Bool
uf1answer = isSame uf1b && isSame uf1c
  where
    isSame = (==) uf1

-- 2) Write out the evaluation steps for
uf2 :: Int
uf2 = foldl f 1 [1 .. 3]
  where
    f = flip (*)

-- f* used to denote flipped multiplication for brevity.
-- ((1 `f` 1) `f` 2) `f` 3
-- (1 `f` 2) `f` 3
-- (2 * 1) `f` 3
-- 2 `f` 3
-- 3 * 2
-- 6
--
-- 3) One difference between foldr and foldl is:
-- c) foldr, but not foldl, associates to the right
--
--4) Folds are catamorphisms, which mean they are generally used to
--a) reduce structure
--c) render you catatonic
-- (both of those)
--
-- 5) The following are simple folds, but each one has an error. Fix and test in REPL.
uf5a :: String
-- uf5a = foldr (++) ["woot", "WOOT", "woot"]
uf5a = foldr (++) [] ["woot", "WOOT", "woot"] -- needs acc

uf5b :: Char
--uf5b = foldr max [] "fear is the little death"
uf5b = foldr max '[' "fear is the little death" -- needs appropriate acc

uf5c :: Bool
-- uf5c = foldr and True [False, True] -- and is already a folding function, need one
uf5c = foldr (&&) True [False, True] -- that takes booleans as arguments, not lists

uf5d :: Bool
-- uf5d = foldr (||) True [False, True]
uf5d = foldr (||) False [False, True] -- will always return true if acc is true

--uf5e = foldl ((++) . show) "" [1 .. 5]
-- Function needs to either be flipped or changed to a right fold
-- Flipping gives "54321", foldr gives "12345"
uf5e1 :: String -- Flip
uf5e1 = foldl (flip ((++) . show)) "" ([1 .. 5] :: [Int])

uf5e2 :: String -- Foldr
uf5e2 = foldr ((++) . show) "" ([1 .. 5] :: [Int])

-- uf5f = foldr const 'a' [1 .. 5]
-- Same deal here. Types of foldr and foldl respectively dictate whether the
-- end result should be of the same type as the first or second argument.
uf5f1 :: Char
uf5f1 = foldr (flip const) 'a' ([1 .. 5] :: [Int])

uf5f2 :: Char
uf5f2 = foldl const 'a' ([1 .. 5] :: [Int])

-- uf5g = foldr const 0 "tacos"
-- Exactly the same thing.
uf5g1 :: Int
uf5g1 = foldr (flip const) 0 "tacos"

uf5g2 :: Int
uf5g2 = foldl const 0 "tacos"

-- uf5h = foldl (flip const) 0 "burritos"
-- Come on man...
uf5h :: Int
uf5h = foldr (flip const) 0 "burritos"

-- uf5i = foldl (flip const) 'z' [1..5]
uf5i :: Char
uf5i = foldl const 'z' ([1 .. 5] :: [Int])

-- Exercises: Database Processing
-- Write the following functions for processing this data.
-- import Data.Time -- moved to top
data DatabaseItem
  = DbString String
  | DbNumber Integer
  | DbDate UTCTime
  deriving (Eq, Ord, Show)

theDatabase :: [DatabaseItem]
theDatabase =
  [ DbDate (UTCTime (fromGregorian 1911 5 1) (secondsToDiffTime 34123))
  , DbNumber 9001
  , DbNumber 1009
  , DbString "Hello World!"
  , DbDate (UTCTime (fromGregorian 1921 5 1) (secondsToDiffTime 34123))
  ]

-- 1. Write a function that filters for DbDate values and
-- returns a list of the UTCTime values inside them.
filterDbDate :: [DatabaseItem] -> [UTCTime]
filterDbDate = foldr go []
  where
    go (DbDate x) b = x : b
    go _ b = b

-- 2. Write a function that filters for DbNumber values and returns a
-- list of the integer values inside them.
filterDbNumber :: [DatabaseItem] -> [Integer]
filterDbNumber = foldr go []
  where
    go (DbNumber x) b = x : b
    go _ b = b

-- 3. Write a function that gets the most recent date.
-- This is a much cleaner solution, however it will also cause an exception
-- if there are no DbDate items in the list so in some ways it's not as good.
-- mostRecent :: [DatabaseItem] -> UTCTime
-- mostRecent = maximum . filterDbDate
--
-- So this is probably better practice after all:
mostRecent :: [DatabaseItem] -> Maybe UTCTime
mostRecent = foldr go Nothing
  where
    go (DbDate x) Nothing = Just x
    go (DbDate x) (Just y)
      | x > y = Just x
      | otherwise = Just y
    go _ b = b

-- 4. Write a function that sums all of the DbNumber values
sumDb :: [DatabaseItem] -> Integer
-- Clearly a better solution, but not using folds so feels like cheating.
-- sumDb = sum . filterDbNumber
sumDb = foldr go 0
  where
    go (DbNumber x) b = x + b
    go _ b = b

-- 5. Write a function that gets the average of the DbNumber values.
-- I can't really think of a way to do this all with a fold since you'd need
-- the length of the list as well. So we'll just use sumDb and filterDbNumber.
avgDb :: [DatabaseItem] -> Double
avgDb xs = sumDbNum / numDbNum
  where
    sumDbNum = (fromIntegral . sumDb) xs
    numDbNum = (fromIntegral . length . filterDbNumber) xs

-- Scans exercises
fibs :: [Integer]
fibs = 0 : scanl (+) 1 fibs -- book starts with one, I like my fibs to start with [0,1]

fibsN :: Int -> Integer
fibsN x = fibs !! x

-- 1. Modify your fibs function to only return the first 20 fibonacci numbers.
se1 :: [Integer]
se1 = take 20 fibs

-- 2. Modify fibs to return the fibonacci numbers that are less that 100.
se2 :: [Integer]
se2 = takeWhile (< 100) fibs

-- 3. Try to write the factorial function from recursion as a scan. You'll want
-- scanl again and your start value will be 1. Warning: this will also generate
-- an infinite list yada yada yada.
-- Recursive factorial:
-- factorial 0 = 1
-- factorial n = n * factorial (n - 1)
se3 :: [Integer]
se3 = scanl (*) 1 [1 ..]
