-- Exercises for Chapter 8: Recursion
-- End of chapter exercises are in chapterExercises.hs

module ExercisesCh8 where
-- Basic example of a recursive function: factorial
-- First a broken recursive function.
brokenFact :: Integer -> Integer
brokenFact n = n * brokenFact (n - 1)
-- This will run forever... it has no stop case.
factorial :: Integer -> Integer
factorial 0 = 1
factorial n = n * factorial (n - 1)
-- ^ But this works.

-- Another example, incrementing a set number of times.
incTimes :: (Eq a, Num a) => a -> a -> a
incTimes 0 n = n
incTimes times n = 
    -- Just add 1 once for every "times",
    -- then fall back to `incTimes 0 n` and just return n.
    -- Doesn't work with negative numbers, fun fact.
    1 + (incTimes timesLeft n)
        where timesLeft = times - 1

-- Abstracted so any operation can be carried out a certain number of times.
applyTimes :: Integral a => a -> (b -> b) -> b -> b
applyTimes 0 _ b = b
applyTimes n f b =
    applyTimes (n - 1) f (f b)

simpleIncrement :: (Num a) => a -> a
simpleIncrement a = a + 1

-- An example that's not using numbers
anotherIncrement :: [Char] -> [Char]
anotherIncrement str = "Another" ++ str

-- Foreshadowing, demonstrating the Maybe data type
maybeF :: Bool -> Maybe Int
maybeF False = Just 0
maybeF _     = Nothing

-- Fibbonacci function
fibbonacci :: Integer -> Integer
fibbonacci 0 = 0
fibbonacci 1 = 1
fibbonacci n = fibbonacci (n - 2) + fibbonacci (n - 1)

-- Mapping of fibbonacci function to a list enumerating from 0 to infinity.
-- This is incredibly cool.
infinacci :: [Integer]
infinacci = map fibbonacci (enumFrom 0)

-- Integral division from scratch
-- First we create some synonyms.
-- Keyword "type" is always used to create synonyms, unlike data and newtype.
-- type String = [Char]
type Numerator = Integer
type Denominator = Integer
type Quotient = Integer

dividedBy :: Numerator
          -> Denominator
          -> Quotient
dividedBy = div

-- Apparently this function is trash, so we're redefining it.
-- This function instead returns a tuple and takes any integral number.
-- type-synonyms do not allow synonyming to non-concrete types.
-- Naming the helper function "go" is very common in Haskell.
dividedBy2 :: (Integral a) => a -> a -> (a, a)
dividedBy2 num denom = go num denom 0
  where go n   d       count  -- guard can not start below g, has to be under o or later.
         | n < d = (count, n) -- this means we're done.
         | otherwise =        -- this means we're not.
            go (n - d) (d) (count + 1)
-- This indeed works like divMod.
-- Well, unless you use negative arguments in which case it doesn't work at all.
-- Especially not with a positive numerator and negative denominator.
