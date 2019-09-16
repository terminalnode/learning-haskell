{-# LANGUAGE NoMonomorphismRestriction #-}

module ChapterExercises7 where
-- code here lol
-- Multiple choice
-- 1) A polymorphic function....
--    d) may resolve into values of different types depending on inputs
-- 2) Two functions named f and g have types Char -> String and String -> [String]
--    respectively. The composed function g . f has the types...
--    should be b) Char -> [String] 
mc2f :: Char -> [Char]
mc2f = undefined
mc2g :: String -> [String]
mc2g = undefined
mc2fusion :: Char -> [String]
mc2fusion = mc2g . mc2f -- confirmed
-- 3) A function f has type Ord a => a -> a -> Bool and we apply it to one numeric value.
--    What is the type now?
--    (Ord a, Num a ) => a -> Bool
mc3 :: Ord a => a -> a -> Bool
mc3 = undefined
mc3' :: (Ord a, Num a) => a -> Bool
mc3' = mc3 1 -- Confirmed
-- 4) A function with the type (a -> b) -> c........
--    b) is a higher-order function
-- 5) Given the following definition of f, what is the type of f True?
mc5f :: a -> a
mc5f x = x
-- mc5f True :: Bool

-- Let's write code
-- The following function returns the tens digit of an integral argument.
tensDigit :: Integral a => a -> a
tensDigit x = d
    where xLast = x `div` 10     -- removes everything right of the tens digit
          d     = xLast `mod` 10 -- removes everything left of the tens digit.
-- a) rewrite it using divMod
tensDigit2 :: Integral a => a -> a
tensDigit2 x = snd (divMod d 10)
    where (d,_) = divMod x 10
-- b) Does the divMod version have the same type as the original? Yes
-- c) Next let's change it so we're getting the hundredsdigit instead.
hunsD :: Integral a => a -> a
hunsD x = mod (mod d 100) 10
    where d = div x 100

-- 2) Implement the function of the type:
foldBool :: a -> a -> Bool -> a
foldBool x1 x2 b
  | b         = x1
  | otherwise = x2

-- It should work like this:
foldbool3 :: a -> a -> Bool -> a
foldbool3 x _ False = x
foldbool3 _ y True  = y

-- 3) Fill in the definition.
-- Note that first argument is a function and the second is a tuple.
lwc3 :: (a -> b) -> (a, c) -> (b, c)
lwc3 aToB (a, c) = (aToB a, c)

-- 4) Time to write some pointfree versions of existing code.
-- Note these types before reading the code below:
--   read :: Read a => String -> a
--   show :: Show a => a -> String
roundTrip :: (Show a, Read a) => a -> a
-- This should render a into a String and then that String back into a
roundTrip a = read (show a) 

-- 5) Make it pointfree
-- roundTripPF :: (Show a, Read a) => a -> a
-- 6) Make it not know what type to return
roundTripPF :: (Show a, Read b) => a -> b
roundTripPF = read . show

merryGoRound :: IO ()
merryGoRound = do
    putStrLn ("id:                   " ++ (show int4))
    putStrLn ("roundTrip:            " ++ (show rt))
    putStrLn ("roundTripPF:          " ++ (show rtPF))
    putStrLn ("Functions are equal:  " ++ (show theyreEqual))
        where int4        = 4 :: Integer
              rt          = roundTrip   int4
              -- rtPF        = roundTripPF int4
              -- 6) In order to make the new version work we need to specify datatype
              rtPF        = roundTripPF int4 :: Integer
              theyreEqual = (rt == rtPF)
