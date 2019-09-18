-- {-# LANGUAGE NoMonomorphismRestriction #-}

module ChapterExercises6 where
import Data.List (sort) -- Required for Match the Types 9
-- Multiple choice
-- 1) The Eq class
--    (c) makes equality tests possible
-- 2) The type class Ord
--    (b) is a subclass of Eq
-- 3) Suppose the type class Ord has an operator >. What is the type of >?
--    (a) Ord a => a -> a -> Bool
-- 4) In x = divMod 16 12
--    (c) the type of x is a tuple
-- 5) the type class Integral includes
--    (a) Int and Integer numbers

-- Does it typecheck?
-- 1) This does not type check because person doesn't derive Show.
-- data Person = Person Bool
data Person = Person Bool deriving Show -- Easy fix though
printPerson :: Person -> IO ()
printPerson person = putStrLn $ show person
-- 2) This does not type check because there's no instance for Eq Mood
data Mood = Blah
          | Woot deriving (Show, Eq) -- Again, easy fix though.
          -- | Woot deriving Show
settleDown x = if x == Woot
                  then Blah
                  else x
-- 3) If you were able to get settleDown to typecheck:
--    a) What values are acceptable inputs to that function?
--       Only Mood, so Blah and Woot
--    b) What will happen if you try to run settleDown 9? Why?
--       It will complain about there being no instance of Num Mood, because
--       we can't use (==) between different types regardless if they both
--       have instances of Eq.
--    c) What will happen if you try to run Blah > Woot? Why?
--       It will complain that there's no instance of Ord Mood, because we neither
--       derive Ord in our datatype definition nor defined it.
-- 4) This does compile, however s1 won't print because it's not a proper sentence.
--    It produces an error saying there's no instance for (Show (Object -> Sentence))
--    It seems to behave like a partial function, so I guess data are also functions
--    in Haskell? Pretty cool. It does print if you add another string to complete
--    the sentence.
type Subject = String
type Verb = String
type Object = String
data Sentence = Sentence Subject Verb Object
    deriving (Eq, Show)

-- Commenting out because -Wall is giving warnings about missing type signatures.
-- s1 = Sentence "dogs" "drool"
-- s2 = Sentence "Julie" "loves" "dogs"

-- Given a datatype declaration, what can we do?
-- Given the following datatype definitions:
data Rocks = Rocks String deriving (Eq, Show)
data Yeah = Yeah Bool deriving (Eq, Show)
data Papu = Papu Rocks Yeah deriving (Eq, Show)
-- Which one of the following will type check? For those that don't, why?
-- 1) No, Papu requires Rocks and Yeah and we only supplied it with String and Bool.
-- phew = Papu "chases" True
phew = Papu (Rocks "chases") (Yeah True) -- fixed
-- 2) Yes
truth = Papu (Rocks "chomskydoz")
             (Yeah True)
-- 3) Yes, Papu derives Eq
equalityForall :: Papu -> Papu -> Bool
equalityForall p p' = p == p'
-- 4) No, Papu does not derive Ord
-- comparePapus :: Papu -> Papu -> Bool
-- comparePapus p p' = p > p'

-- Match the types
-- Given two types and their implementations, determine if you can
-- substitute the second type for the first. Test it by typing in
-- the two declarations, loading it and see if it fails.
-- 1) Second doesn't work because a is too genral to equal 1.
mtt1 :: Num a => a
-- mtt1 :: a
mtt1 = 1
-- 2) Second doesn't work because not all Nums can hold the value (or parse the literal) 1.0
mtt2 :: Float
-- mtt2 :: Num a => a
mtt2 = 1.0
-- 3) This works. Fractional can hold 1.0
-- mtt3 :: Float
mtt3 :: Fractional a => a
mtt3 = 1.0
-- 4) Also works. RealFrac is a subtype of Fractional and must thus hold 1.0.
-- mtt4 :: Float
mtt4 :: RealFrac a => a
mtt4 = 1.0
-- 5) This works, Ord is less specific than a. Obviously. 
-- mtt5 :: a -> a
mtt5 :: Ord a => a -> a
mtt5 x = x
-- 6) Same thing here. Int is less specific than a.
-- mtt6 :: a -> a
mtt6 :: Int -> Int
mtt6 x = x
-- 7) This will not work. Return value has to be the same as input value according to the
--    type signature, and the return value is explicitly defined as Int. Clearly we can
--    only take Int arguments.
mtt7x = 1 :: Int
mtt7 :: Int -> Int
-- mtt7 :: a -> a
mtt7 x = mtt7x
-- 8) Also won't work because of the same reason. Int is a Num, but not all Num a => a are Ints.
mtt8x = 1 :: Int
mtt8 :: Int -> Int
-- mtt8 :: Num a => a -> a
mtt8 x = mtt8x
-- 9) Second will work because Int has an instance for Ord. So we're narrowing it's span
--    down a little.
-- mtt9 :: Ord a => [a] -> a
mtt9 :: [Int] -> Int
mtt9 xs = head (sort xs)
-- 10) Sort works on all types with an instance of Ord, so no reason this shouldn't work.
-- mtt10 ::  [Char] -> Char
mtt10 :: Ord a => [a] -> a
mtt10 xs = head (sort xs)
-- 11) Second won't work because mtt11sort only works on Char, not any Ord.
--     We've done nothing with mtt11sort except make it apply to fewer types.
mtt11sort :: [Char] -> [Char]
mtt11sort = sort
mtt11 :: [Char] -> Char
-- mtt11 :: Ord a => [a] -> a
mtt11 xs = head (mtt11sort xs)

-- Type-Kwon-Do Two: Electric Typealoo
-- Given the type signature, implement the (a) function.
tkd1 :: Eq b => (a -> b) -> a -> b -> Bool
tkd1 aToB a b = (aToB a) == b
-- Could also just have returned (aToB anA) tbh.
-- Also this is completely unreadable.
tkd2 :: Num b => (a -> b)
              -> Integer
              -> a
              -> b
tkd2 aToB anInt anA = (aToB anA) + (fromInteger anInt)
