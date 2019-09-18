-- Exercises for Chapter 9: Lists
-- End of chapter exercises are in chapterExercises.hs
module ExercisesCh9 where

import Data.Bool (bool) -- This is necessary for exercise at page 330

safeTail :: [a] -> Maybe [a]
safeTail [] = Nothing
safeTail [_] = Nothing -- Same as (x:[]), matches a list with only one entry.
safeTail (_:xs) = Just xs

safeHead :: [a] -> Maybe a
safeHead [] = Nothing
safeHead (x:_) = Just x

-- Tehe
-- Returns the second item of a list.
safeNeck :: [a] -> Maybe a
safeNeck [] = Nothing
safeNeck [_] = Nothing
safeNeck (_:x:_) = Just x

-- Tehe again
-- Returns the last item of a list.
safeButt :: [a] -> Maybe a
safeButt [] = Nothing
safeButt x = safeHead . reverse $ x

-- This function imagines the Bool range as oscillating between True and False.
eftBool :: Bool -> Bool -> [Bool]
eftBool b1 b2
  | b1 == b2 = [b1, not b1, b1]
  | otherwise = [b1, b2]

-- This is in line with with what enumFromTo would do, and it sucks.
eftBool2 :: Bool -> Bool -> [Bool]
eftBool2 True False = []
eftBool2 False True = [False, True]
eftBool2 b _ = [b]

-- Order of ordering is LT -> EQ -> GT
eftOrd :: Ordering -> Ordering -> [Ordering]
eftOrd o1 o2
  -- | (o1 == o2) = [o1]
  | o1 > o2 = []
  | otherwise = getList o1 o2 o1 []
  where
    getList arg1 arg2 current list
      | current == arg2 = reverse (arg2 : list)
      | otherwise = getList arg1 arg2 (succ current) $ current : list

-- Ordering ints!
eftInt :: Int -> Int -> [Int]
eftInt n1 n2
  | n1 > n2 = []
  | otherwise = getList n1 n2 n1 []
  -- So... this seems familiar right?
  where
    getList arg1 arg2 current list
      | current == arg2 = reverse (arg2 : list)
      | otherwise = getList arg1 arg2 (succ current) $ current : list

-- Ordering chars -_-
eftChar :: Char -> Char -> String
eftChar n1 n2
  | n1 > n2 = []
  | otherwise = getList n1 n2 n1 []
  where
    getList arg1 arg2 current list
      | current == arg2 = reverse (arg2 : list)
      | otherwise = getList arg1 arg2 (succ current) $ current : list

-- Ok ok, I figured it out at last.
-- One func to rule them all.
eftEnum :: (Ord a, Enum a) => a -> a -> [a]
eftEnum n1 n2
  | n1 > n2 = []
  | otherwise = buildList n1 n2 n1 []
  where
    buildList arg1 arg2 current list
      | current == arg2 = reverse (arg2 : list)
      | otherwise = buildList arg1 arg2 (succ current) (current : list)

betterEftInt :: Int -> Int -> [Int]
betterEftOrd :: Ordering -> Ordering -> [Ordering]
betterEftBool :: Bool -> Bool -> [Bool]
betterEftChar :: Char -> Char -> String
betterEftInt = eftEnum

betterEftOrd = eftEnum

betterEftBool = eftEnum

betterEftChar = eftEnum

-- So hot.
-- Exercises: Thy fearful symmetry
-- 1) Using takeWhile and dropWhile, write a function that takes a string and returns a list
--    of strings., using spaces to separate the elements of the string into words.
--    myWords "hello cruel world"
--    ["hello", "cruel", "world"]
myWords :: String -> [String]
myWords input = go input []
  where
    go str result
      | null str = reverse result
      | otherwise = go (dropNextWord str) (getNextWord str : result)
    getNextWord = takeWhile (/= ' ')
    dropUntilSpace = dropWhile (/= ' ')
    dropSpace = dropWhile (== ' ')
    dropNextWord = dropSpace . dropUntilSpace

-- 2) Next make a function that takes a String, and returns a [String] where
--    the string is broken up at each line break.
firstSen :: String
secondSen :: String
thirdSen :: String
fourthSen :: String
sentences :: String
shouldEqual :: [String]
firstSen = "Tyger Tyger, burning bright\n"

secondSen = "In the forests of the night\n"

thirdSen = "What immortal hand or eye\n"

fourthSen =
  "Could frame thy fearful\
          \ symmetry?"

sentences = firstSen ++ secondSen ++ thirdSen ++ fourthSen

shouldEqual =
  [ "Tyger Tyger, burning bright"
  , "In the forests of the night"
  , "What immortal hand or eye"
  , "Could frame thy fearful symmetry?"
  ]

-- Implement this:
myLines :: String -> [String]
myLines input = go input []
  where
    go str result
      | null str = reverse result -- null returns true if a foldable is empty or something.
      | otherwise = go (dropNextWord str) (getNextWord str : result)
    getNextWord = takeWhile (/= '\n')
    dropUntilSpace = dropWhile (/= '\n')
    dropSpace = dropWhile (== '\n')
    dropNextWord = dropSpace . dropUntilSpace

-- It's exactly the same as myWords but with '\n' instead of ' '.
-- Both functions could easily be rewritten as a function which
-- specifies the separator. This is left as an exercise to the reader.
-- It works.
testSentence :: IO ()
testSentence =
  print $ "Are they equal? " ++ show (myLines sentences == shouldEqual)

-- 3) Never mind, it's not left as an exercise to the reader.
-- Time to make a unified function.
splitAtChar :: Char -> String -> [String]
splitAtChar separator input = go input []
  where
    go str result
      | null str = reverse result
      | otherwise = go (dropNextWord str) (getNextWord str : result)
    getNextWord = takeWhile (/= separator)
    dropUntilSpace = dropWhile (/= separator)
    dropSpace = dropWhile (== separator)
    dropNextWord = dropSpace . dropUntilSpace

betterMyWords :: String -> [String]
betterMyWords = splitAtChar ' '

betterMyLines :: String -> [String]
betterMyLines = splitAtChar '\n'

betterTestSentence :: IO ()
betterTestSentence =
  print $ "Are they equal? " ++ show (betterMyLines sentences == shouldEqual)

-- Exercises: Comprehend Thy List
-- Execute the following instructions, predict the outcome. Ezpz.
mySqr :: [Integer]
whatDo1 :: [Integer]
whatDo2 :: [(Integer, Integer)]
whatDo3 :: [(Integer, Integer)]
--
-- Create a list of x^2 for x=1 up to x=10 (inclusive).
-- [1,4,9,16,25,36,49,64,81,100]
mySqr = [x ^ (2 :: Integer) | x <- [1 .. 10]]

-- Create a list of all values in mySqr that are even.
-- So: [4,16,36,64,100]
-- whatDo1 = [x | x <- mySqr, rem x 2 == 0]
whatDo1 = [x | x <- mySqr, even x]

-- Create a list with all combinations of numbers below 50 and above 50 in mySqrt.
-- Below 50: [1,4,9,16,25,36,49], above [64, 81,100]
-- Should be a list of length 21. (spoiler: it is)
whatDo2 = [(x, y) | x <- mySqr, x < 50, y <- mySqr, y > 50]

-- Takes the first five entries of the above list.
-- Should be [(1,64),(1,81),(1,100),(4,64),(4,81)] (spoiler: it is)
whatDo3 = take 5 whatDo2

-- Exercises: Square Cube
-- Given these functions....
myCube :: [Integer]
myCube = [x ^ (3 :: Integer) | x <- [1 .. 5]]

mySqr2 :: [Integer]
mySqr2 = [x ^ (2 :: Integer) | x <- [1 .. 5]]

-- 1) Write an expression that makes a tuple of both list.
mySqrCube :: [(Integer, Integer)]
mySqrCube = [(x, y) | x <- myCube, y <- mySqr2]

-- 2) Now alter the expression so that it only uses x and y values < 50.
mySqrCube2 :: [(Integer, Integer)]
mySqrCube2 = [(x, y) | x <- myCube, x < 50, y <- mySqr2, y < 50]

-- Wait, smarter!
mySqrCube3 :: [(Integer, Integer)]
mySqrCube3 = [(x, y) | (x, y) <- mySqrCube, x < 50, y < 50]

-- 3) Apply another function to that list comprehension to
-- determine how many tuples inhabite your output list.
-- Really...?
mySqrLength3 :: Int
mySqrLength3 = length mySqrCube3

-- Exercises: Bottom Madness
-- Will it blow up? Determine if expressions will explode the compiler or not.
-- 1) Yes. Part of the list in undefined and trying to evaluate it will blow it up.
bm1 :: [Integer]
bm1 = [x ^ y | x <- [1 .. 5], y <- [2 :: Integer, undefined]]

-- 2) No. The first entry of bm1 is the only one that will be evaluated
--    and that entry is 1^2
bm2 :: [Integer]
bm2 = take 1 bm1

-- 3) Yes, this will indeed explode. sum forces all values in the list to be evaluated.
bm3 :: Integer
bm3 = sum [1, undefined, 3]

-- 4) Nope, length only evaluates the spine.
bm4 :: Int
bm4 = length [1 :: Int, 2 :: Int, undefined]

-- 5) Yes, part of the spine is undefined so length will go kaboom.
bm5 :: Int
bm5 = length $ [1 :: Int, 2 :: Int, 3 :: Int] ++ undefined

-- 6) No, since we only take the second value of the list (skipping the first because it
-- gets filtered out) the undefined part needn't be evaluated just yet.
bm6 :: [Int]
bm6 = take 1 $ filter even [1, 2, 3, undefined]

-- 7) Yes. Same reasoning as above.
bm7 :: [Int]
bm7 = take 1 $ filter even [1, 3, undefined]

-- 8)  Nope.
bm8 :: [Int]
bm8 = take 1 $ filter odd [1, 3, undefined]

-- 9) Nope.
bm9 :: [Int]
bm9 = take 2 $ filter odd [1, 3, undefined]

-- 10) Yup.
bm0 :: [Int]
bm0 = take 3 $ filter odd [1, 3, undefined]

-- Intermission: Is it in normal form?
-- For each expression below, determine if it's in:
-- 1) normal form (which also implies WHNF)
-- 2) WHNF only, or
-- 3) neither
--
-- 1) [1,2,3,4,5]
--    NF, all values in the list are defined (though values within the list may be WHNF, possibly?).
-- 2) 1 : 2 : 3 : 4 : _
--    Syntax error form.
-- 3) enumFromTo 1 10
--    WHNF, the list will not be created until it's necessary.
-- 4) length [1,2,3,4,5]
--    NF
-- 5) sum (enumFromTo 1 10)
--    sum forces evaluation of the WHNF enumFromTo, making it NF.
-- 6) ['a'..'m'] ++ ['n'..'z']
--    WHNF, ['a'..'m'] is just a sugar-coated enumFromTo 'a' 'm'.
-- 7) (_, 'b')
--    Syntax error form.
-- Not quite sure how to verify these answers, but I think that's correct.
-- In some cases it kind of depends on if you enter it into ghci or not,
-- if entered into ghci everything is more or less reduced to normal form
-- in order to call the show instance. If saved to a variable I think most
-- things will avoid evaluation until the last possible moment.
-- Exercises: More Bottoms
-- Will the following expressions return a value or be bottom?
-- 1) The first value is undefined so we're fucked.
mb1 :: [Int]
mb1 = take 1 $ map (+ 1) [undefined, 2, 3]

-- 2) This is fine. First value can be applied to + 1.
mb2 :: [Int]
mb2 = take 1 $ map (+ 1) [1, undefined, 3]

-- 3) This is not fine, second value can not be applied to + 1.
mb3 :: [Int]
mb3 = take 2 $ map (+ 1) [1, undefined, 3]

-- Describe what the function does and what is it's type?
-- Describe it in normal English.
-- It takes a list of strings, returns a list of booleans saying
-- if each character is in "aeiou" (i.e., is a vowel)
mb4 :: String -> [Bool]
mb4 = map (\x -> elem x "aeiou")

-- [1,4,9,16,25...]
mb5a :: [Integer]
mb5a = map (^ (2 :: Integer)) [1 .. 10]

-- [1,10,20]
mb5b :: [Integer]
mb5b = map minimum [[1 .. 10], [10 .. 20], [20 .. 30]]

-- [15,15,15]
mb5c :: [Integer]
mb5c = map sum [[1 .. 5], [1 .. 5], [1 .. 5]]

-- 6) Write a function that does the same as
-- map (\x -> if x == 3 then (-x) else (x))
-- but using Data.Bool (bool). Syntax for bool is `bool x y p` where b
-- is a boolean. if p then y else x.
mb6 :: (Num a, Eq a) => [a] -> [a]
mb6 = map (\x -> bool x (-x) $ x == 3)

-- Exercises: Filtering
-- 1) Given the above, how might we write a filter function that
-- would give us all the multiples of 3 out of a list from 1-30?
--
-- filt1 [1..30]
filt1 :: [Int] -> [Int]
filt1 = filter (\x -> rem x 3 == 0)

-- 2) Recalling what we learned about function composition, how
-- could we compose the above function with the length function
-- to tell us how many multiples of 3 there are between 1 and 30?
--
-- filt2 [1..30]
filt2 :: [Int] -> Int
filt2 = length . filt1

-- 3) Create a function using filter to remove all articles (the, a, an) from sentences.
-- Also with list comprehension:
-- filt3 :: String -> [String]
-- filt3 str = [x | x <- words str, notArticle x]
filt3 :: String -> [String]
filt3 = filter notArticle . words
  where
    notArticle = flip notElem ["a", "an", "the"]

-- Exercises: Zipping
-- 1) Write your own version of zip and ensure it behaves the same as the original.
myZip :: [a] -> [b] -> [(a, b)]
myZip l1 l2 = reverse $ doTheZip l1 l2 []
  where
    doTheZip [] _ list = list
    doTheZip _ [] list = list
    doTheZip (x:xs) (y:ys) list = doTheZip xs ys ((x, y) : list)

-- 2) Now do it with zipWith
myZipWith :: (a -> b -> c) -> [a] -> [b] -> [c]
myZipWith func l1 l2 = reverse $ doTheZip func l1 l2 []
  where
    doTheZip _ [] _ list = list
    doTheZip _ _ [] list = list
    doTheZip f (x:xs) (y:ys) list = doTheZip f xs ys (f x y : list)

-- 3) Now rewrite your zip function in terms of your zipWith function.
-- TODO Remember to keep your function names short and descriptive.
myZipWithMyMyZipWith :: [a] -> [b] -> [(a, b)]
myZipWithMyMyZipWith = myZipWith (\x y -> (x, y))
