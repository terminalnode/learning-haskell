{-# LANGUAGE NoMonomorphismRestriction #-}

module ChapterExercises5 where
-- First, some multiple choice!
-- 1. A value of type [a] is....
--    a list whose elements are all of some type a
-- 2. A function of type [[a]] -> [a] could...
--    take a list of strings as an argument.
-- 3. A function of type [a] -> Int -> a...
--    returns one element of type a from a list.
-- 4. A function of type (a, b) -> a...
--    takes a tuple argument and returns the first value.

-- Determine the type
-- For these functions, determine the type of the specified value.
-- 1a) Num, 54
dtt1a = (* 9) 6
-- 1b) (0,"doge"), (Num,[Char])
dtt1b = head [(0, "doge"), (1, "kitteh")]
-- 1c) (0, "doge"), (Integer, [Char])
dtt1c = head [(0 :: Integer, "doge"),( 1, "kitteh")]
-- 1d) False, Bool
dtt1d = if False then True else False
-- 1e) 5, Int
dtt1e = length [1, 2, 3, 4, 5]
-- 1f) False, Bool
dtt1f = (length [1, 2, 3, 4]) > (length "TACOCAT")
-- 2) Given this, what's the type of dtt2w?
-- Num a => a
dtt2x = 5
dtt2y = dtt2x + 5
dtt2w = dtt2y * 10
-- 3) Given this, what's the type of dtt3z?
-- Num a => a -> a
dtt3x = 5
dtt3y = dtt3x + 5
dtt3z y = y * 10
-- 4) Given this, what's the type of dtt4f?
-- Fractional a => a
dtt4x = 5
dtt4y =  dtt4x + 5
dtt4f = 4 / dtt4y
-- 5) Given this, what's the type of dtt5f?
-- [Char]
dtt5x = "Julie"
dtt5y = " <3 "
dtt5z = "Haskell"
dtt5f = dtt5x ++ dtt5y ++ dtt5z

-- Does it compile?
-- For each set of expressions, determine if it will
-- compile and if not why not. Fix if possible.
-- 1)
-- y is not defined, we need to add y as a parameter for bigNum
-- bigNum = (^) y $ 10
bigNum y = (^) y $ 10
wahoo = bigNum $ 10
-- 2)
-- Works with no modifications.
dic2x = print
dic2y = print "wohooo!"
dic2z = dic2x "hello world"
-- 3)
dic3a = (+)
dic3b = 5
-- These two lack operators. Let's add dic3a in there.
-- dic3c = dic3b 10
-- dic3d = dic3c 200
dic3c = dic3a dic3b 10
dic3d = dic3a dic3c 200
-- 4)
-- dic4c is undefined. let's define it.
dic4a = 12 + dic4b
dic4b = 10000 * dic4c
dic4c = 1337

-- Type variable or specific type constructor?
-- Given a type declaration, categorize each type into:
-- fully polymorphic, constrained polymorphic, concrete
-- (Exercise 1 is an example with answers given)
-- 1) f :: Num a => a -> b -> Int -> Int
--              [0]  [1]   [2]    [3]
--   [0] constrained pm (Num), [1] fully pm, [2][3] concrete
-- 2) f :: zed -> Zed -> Blah
--    fully pm, concrete, concrete
-- 3) f :: Enum b => a -> b -> C
--    fully pm, constrained pm (Enum), concrete C
-- 4) f :: f -> g -> C
--    fully pm, fully pm, concrete

-- Write a type signature
-- 1)
functionH :: [a] -> a
functionH (x:_) = x
-- 2)
functionC :: Ord a => a -> a -> Bool
functionC x y = if (x > y) then True else False
-- 3)
functionS :: (a,b) -> b
functionS (x, y) = y

-- Given a type, write the function
wtf1 :: a -> a
wtf1 x = x
wtf2 :: a -> b -> a
wtf2 x y = x
wtf3 :: b -> a -> b
wtf3 x y = x
wtf4 :: a -> b -> b
wtf4 x y = y
wtf5a :: [a] -> [a]
wtf5a x = x
wtf5b :: [a] -> [a]
wtf5b x = reverse x
wtf6 :: (b -> c) -> (a -> b) -> a -> c
wtf6 bToC aToB a = bToC (aToB a)
wtf7 :: (a -> c) -> a -> a
wtf7 _ x = x
wtf8 :: (a -> b) -> a -> b
wtf8 aToB a = aToB a

-- Fix it
-- 1)
-- fstString :: [Char] ++ [Char]
fstString :: [Char] -> [Char]
fstString x = x ++ " in the rain"
-- sndString :: [Char] -> Char
sndString :: [Char] -> [Char]
sndString x = x ++ " over the rainbow"
-- sing = if (x > y) then fstString x or sndString y
sing = if (x > y) then fstString x else sndString y
    where x = "Singin"
          y = "Somewhere"
-- 2)
-- Now that it's fixed, make a minor change to make it sing the other song:
--    Just reverse the comparator or whatever it's called. Make it (x < y).
-- 3)
main :: IO ()
-- Main = do
main = do
    print $ show $ 1 + 2
    -- putStrLn 10
    putStrLn "10"
    -- print (negate -1)
    print $ negate $ -1
    print $ (+) 0 blah
    where blah = negate 1

-- Type-Kwon-Do
data A
data B
data C
data X
data Y
data Z

tkd1f :: Int -> String
tkd1f = undefined
tkd1g :: String -> Char
tkd1g = undefined
tkd1h :: Int -> Char
tkd1h x = tkd1g (tkd1f x)

tkd2q :: A -> B
tkd2q = undefined
tkd2w :: B -> C
tkd2w = undefined
tkd2e :: A -> C
tkd2e x = tkd2w (tkd2q x)

tkd3xz :: X -> Z
tkd3xz = undefined
tkd3yz :: Y -> Z
tkd3yz = undefined
tkd3xform :: (X, Y) -> (Z, Z)
tkd3xform (x, y) = (tkd3xz x, tkd3yz y)

tkd4munge :: (x -> y)
          -> (y -> (w,z))
          -> x
          -> w
tkd4munge xToY yToWZ x = fst (yToWZ y)
    where y = xToY x









