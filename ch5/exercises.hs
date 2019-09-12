-- Exercises for Chapter 5: Types
-- End of chapter exercises are in chapterExercises.hs

module ExercisesCh5 where
-- Exercises: Type Matching
-- Ch 5.3:    How to read type signatures
-- Match the function to it's type. This can't really be done programatically
-- so I'll just be writing down the answers like a normal person.
-- a) not    :: Bool -> Bool            -- (c)
-- b) length :: [a] -> Int              -- (d)
-- c) concat :: [[a]] -> [a]            -- (b)
-- d) head   :: [a] -> a                -- (a)
-- e) (<)    :: Ord a => a -> a -> Bool -- (e)

-- Exercises: Type Arguments
-- Ch 5.4:    Currying
-- Given a function and its type, what's the result of
-- applying some or all of the arguments?
-- Same here, they can't really be verified programatically except by manually checking.
-- 1) f :: a -> a -> a -> a; x :: Char
--    f x :: Char -> Char -> Char
-- 2) g :: a -> b -> c -> b
--    g 0 'c' "woot" :: Char
-- 3) h :: (Num a, Num b) => a -> b -> b
--    h 1.0 2 :: Num b => b
-- 4) h 1 (5.5 :: Double) :: Double
-- 5) jackal :: (Ord a, Eq b) => a -> b -> a
--    jackal "keyboard" "has the work jackal in it" :: [Char]
-- 6) jackal "keyboard" :: Eq b => b -> [Char]
-- 7) kessel :: (Ord a, Num b) => a -> b -> a
--    kessel 1 2 :: (Num a, Ord a) => a
-- 8) kessel 1 (2 :: Integer) :: (Ord a, Num a) => a
-- 9) kessel (1 :: Integer) 2 :: Integer

-- Exercises: Parametricity
-- Ch 5.5:    Polymorphism
-- The first two exercises are thought experiments, but the third one we can do!
-- Implement a function with type signature a -> b -> b, how many implementations can it have?
-- Does the behaviour change when the types of a and b change?
parametricity :: a -> b -> b
parametricity a b = b
-- Apart from discarding the first value it's identical to the id function, and it's behaviour
-- can't change because we don't know what the types are. We could do something like put
-- them in a tuple, but then the return value type would change so that would only be possible
-- with something like parametricity :: a -> b -> c

-- Ch 5.6:    Type inference
typeInference :: Num a => a -> a -> a
typeInference x y = x + y + 3
-- Exercises: Apply yourself.
-- 1) How does the type signature of (++) :: [a] -> [a] -> [a] change
--    when we apply one of the arguments such that myConcat x = x ++ " yo"
-- myConcat :: [Char] -> [Char]
-- 2) (*) :: Num a => a -> a -> a
--    myMult x = (x / 3) * 5
-- myMult :: Fractional a => a -> a
-- 3) take :: Int -> [a] -> [a]
--    myTake x = take x "hey you"
-- myTake :: Int -> [Char]
-- 4) (>) :: Ord a => a -> a -> Bool
--    myCom x = x > (length [1..10])
-- myCom :: Int -> Bool
-- 5) (<) :: Ord a => a -> a -> Bool
--    myAlph x = x < 'z'
-- myAlph :: Char -> Bool
