-- Exercises for Chapter 7: More functional patterns
-- End of chapter exercises are in chapterExercises.hs

module ExercisesCh7 where
-- A let expression, for practice. And some terminology.
bindExp :: Integer -> String
bindExp x = 
    -- let binds y to 5
    -- if we call bindExp with an argument, we say this binds x to that value
    let y = 5 :: Integer in -- :: Integer to avoid annoying warnings
    "the integer was: " ++ show x
    ++ " and y was: " ++ show y

-- Exercises:   Grab Bag
-- Chapter 7.2: Arguments and parameters
-- Determine which (two or more) of these functions evaluate to the same value.
-- (Comment out the type signatures to test what the actual types are.)
-- (I added type signatures because loading the source file resulted in lots of warnings)
mTha :: Num a => a -> a -> a -> a
mThb :: Num a => a -> a -> a -> a
mThc :: Num a => a -> a -> a -> a
mThd :: Num a => a -> a -> a -> a
mTha x y z = (x * y * z)
mThb x y   = \z -> (x * y * z)
mThc x     = \y -> \z -> (x * y * z)
mThd       = \x -> \y -> \z -> (x * y * z)
-- They should all be equivalent
-- For some reason mThd has the type Integer -> Integer -> Integer -> Integer
-- This is very strange.

-- Which is the type of mTh 3?
-- Should be Num a => a -> a -> a
-- And it is. Except for the last one which inexplicably must be Integer.

-- Next we'll practice writing anonymous lambda syntax.
-- These functions do the same thing:
rewrite1 :: Num a => a -> a
rewrite2 :: Num a => a -> a
rewrite1 x = x + 1
rewrite2 = \x -> x + 1

addOneIfOdd :: Integral a => a -> a
addOneIfOdd n = case odd n of
    True -> f n
    False -> n
    where f = \a -> a + 1

addFive :: (Ord a, Num a) => a -> a -> a
addFive2 :: (Ord a, Num a) => a -> a -> a
addFive x y = (if x > y then y else x) + 5
addFive2 = \x -> \y -> (if x > y then y else x) + 5

mflip :: (a -> a -> c) -> a -> a -> c
mflip2 :: (a -> a -> c) -> a -> a -> c
mflip f = \x -> \y -> f y x
mflip2 f x y = f y x

-- Some pattern matching shenanigans
isItTwo :: Integer -> Bool
-- isItTwo _ = False -- Order matters! This will prevent any matching with 2.
isItTwo 2 = True
isItTwo _ = False -- Match anything else, default case

-- Cooler pattern matching shenanigans
newtype Username =
    Username String

newtype AccountNumber =
    AccountNumber Integer

data User =
    UnregisteredUser
  | RegisteredUser Username AccountNumber

-- Woah dude
printUser :: User -> IO ()
printUser UnregisteredUser =
    putStrLn "Unregistered user"

printUser (RegisteredUser
           (Username name)
           (AccountNumber acctNum)) =
    putStrLn $ name ++ " " ++ show acctNum

-- Penguin examples
data WherePenguinsLive = 
    Galapagos
  | Antarctica
  | Australia
  | SouthAfrica
  | SouthAmerica
  deriving (Eq, Show)

data Penguin = 
    Peng WherePenguinsLive
    deriving (Eq, Show)

isSouthAfrica :: WherePenguinsLive -> Bool
isSouthAfrica SouthAfrica = True
isSouthAfrica _ = False

-- Is this really pattern matching though? Penguin always has a location, and 
-- we're just returning what it is. Oh well, cool anyway.
gimmeWhereTheyLive :: Penguin -> WherePenguinsLive
gimmeWhereTheyLive (Peng location) = location

humboldt :: Penguin
humboldt = Peng SouthAmerica
gentoo :: Penguin
gentoo = Peng Antarctica
macaroni :: Penguin
macaroni = Peng Antarctica
little :: Penguin
little = Peng Australia
galapagos :: Penguin
galapagos = Peng Galapagos

galapagosPenguin :: Penguin -> Bool
galapagosPenguin (Peng Galapagos) = True
galapagosPenguin _                = False

antarcticPenguin :: Penguin -> Bool
antarcticPenguin (Peng Antarctica) = True
antarcticPenguin _                 = False

antarcticOrGalapagos :: Penguin -> Bool
antarcticOrGalapagos p =
       galapagosPenguin p
    || antarcticPenguin p
-- Very neat.

-- Let's use pattern matching for tuple thingies.
-- We've done this before:
tupleMatch1 :: (a,b) -> (c,d) -> ((b,d),(a,c))
tupleMatch1 x y = ((snd x, snd y), (fst x, fst y))
-- But not this:
tupleMatch2 :: (a,b) -> (c,d) -> ((b,d),(a,c))
tupleMatch2 (a,b) (c,d) = ((b,d), (a,c)) -- Daaaaaamn son

addEmUp2 :: Num a => (a,a) -> a
addEmUp2 (a, b) = a + b

addEmUp2Alt :: Num a => (a,a) -> a
addEmUp2Alt tup = (fst tup) + (snd tup)

fst3 :: (a,b,c) -> a
fst3 (a, _, _) = a

third3 :: (a,b,c) -> c
third3 (_, _, c) = c

-- Exercises: Variety Pack
-- 1. Given the following declarations:
-- What's the type of k?
--    k :: (a,b) -> a
-- What's the type of k2? Is it the same as k1 or k3?
--    k1 :: Integer -- Why integer and not num?
--    k2 :: [Char]
--    k3 :: Integer
-- Of k1, k2, k3 which will return the number 3 as result?
--    k1 and k3, and kinda k2 as well
k :: (a, b) -> a
k (x,_) = x

k1 :: Num a => a
k1 = k ((4-1), 10 :: Integer)

k2 :: [Char]
k2 = k ("three", (1 + 2) :: Integer)

k3 :: Num a => a
k3 = k (3, True)

-- 2. Fill in the definition based on the type signature.
vpack :: (a,b,c)
      -> (d,e,f)
      -> ((a,d),(c,f))
vpack (a,_,c) (d,_,f) = ((a,d),(c,f))

-- Haskell has case switches!
funcZ :: (Eq a, Num a) => a -> [Char]
funcZ x =
    case x + 1 == 1 of
      True -> "Awesome!"
      False -> "w00t"

palindrome :: Eq a => [a] -> [Char]
palindrome xs =
    case xs == reverse xs of
      True -> "yes"
      False -> "nah"

palindrome' :: Eq a => [a] -> [Char]
palindrome' xs =
    case y of
      True -> "yup"
      False -> "nah"
    where y = xs == reverse xs

-- Exercises: Case Practice
-- Rewrite the following if then else expressions to case of syntax.
cp11 :: Ord a => a -> a -> a
cp12 :: Ord a => a -> a -> a
cp11 x y = if (x > y) then x else y
cp12 x y =
    case x > y of
      True -> x
      False -> y

cp21 :: Integral a => a -> a
cp22 :: Integral a => a -> a
cp21 n = if even n then (n+2) else n
cp22 n =
    case even n of
      True -> n + 2
      False -> n

-- Complete the function
cp3 :: (Ord a, Num a) => a -> a
cp3 x =
    case compare x 0 of
      LT -> -1
      GT -> 1
      -- Added case
      EQ -> 0

-- Functions as arguments to change how arguments are applied to functions.
data Employee =
    Coder
  | Manager
  | Veep
  | CEO
  deriving (Eq, Ord, Show)

reportBoss :: Employee -> Employee -> IO ()
reportBoss e e' =
    putStrLn $ show e ++
               " is the boss of " ++
               show e'

employeeRank :: Employee
             -> Employee
             -> IO ()

employeeRank e e' = 
    case compare e e' of
      GT -> reportBoss e e' -- Argument order unchanged
      EQ -> putStrLn "Employees are the same rank."
      LT -> (flip reportBoss) e e'
      -- Perhaps the above is clearer, but this of course works too:
      -- LT -> reportBoss e' e

-- "Improved" function that can take any function capable of
-- producing an Ordering from two Employees.
-- employeeRank' compare e e'
--      should be the same as
-- employeeRank e e'
-- (and it is)
employeeRank' :: (Employee -> Employee -> Ordering)
              -> Employee
              -> Employee
              -> IO ()
employeeRank' f e e' =
    case f e e' of
      GT -> reportBoss e e'
      EQ -> putStrLn "Employees are the same rank."
      LT -> (flip reportBoss) e e'

-- We can now subvert the hierarchy with our 1337 h4xx0r skills
codersRule :: Employee
           -> Employee
           -> Ordering
codersRule Coder Coder = EQ
codersRule _     Coder = LT
codersRule Coder _     = GT
-- Why is this needed?
-- Oh right because we should be able to compare all other employees as well.
codersRule e e' = compare e e'

-- Exercises: Artful Dodgy
-- Given the following definitions, tell us what value results from further applications.
-- Also fill in the type signatures.
dodgy :: Num a => a -> a -> a
dodgy x y = x + y * 10
oneIsOne :: Num a => a -> a
oneIsOne = dodgy 1
oneIsTwo :: Num a => a -> a
oneIsTwo = (flip dodgy) 2

-- This function will return True if I'm right
-- If you downloaded this from github, it will return true :p
checkAnswersArtfulDodgy :: Bool
checkAnswersArtfulDodgy = a && b && c && d && e && f && g && h && i && j
    where a = dodgy 1 1  == (11 :: Integer)
          b = dodgy 2 2  == (22 :: Integer)
          c = dodgy 1 2  == (21 :: Integer)
          f = dodgy 2 1  == (12 :: Integer)
          d = oneIsOne 1 == (11 :: Integer)
          e = oneIsOne 2 == (21 :: Integer)
          i = oneIsOne 3 == (31 :: Integer)
          g = oneIsTwo 1 == (21 :: Integer)
          h = oneIsTwo 2 == (22 :: Integer)
          j = oneIsTwo 3 == (23 :: Integer)

-- 7.7: GUARDS
myAbs :: Integer -> Integer
myAbs x -- No equals, just parameter
  | x < 0       = negate x -- Here we have equals.
  | otherwise   = x        -- and here. After every guard a condition and an equals.
-- otherwise is literally an alias for True.
-- Like everything else, guards evaluate top to bottom so conditions should
-- be ordered from more specific to less specific with otherwise at the bottom.

bloodNa :: Integer -> String
bloodNa x
  | x < 135   = "needz moar salt"
  | x > 145   = "needz less salt"
  | otherwise = "good amount of salt"

isRightTriangle :: (Eq a, Num a) => a -> a -> a -> [Char]
isRightTriangle a b c
  | cbd a + cbd b == cbd c = "Good triangle!"
  | otherwise              = "Bad triangle!"
  where cbd x = x ^ (2 :: Integer)

dogYrs :: Integer -> Integer
dogYrs x
  | x <= 0    = 0
  | x <= 1    = x * 15
  | x <= 2    = x * 12
  | x <= 5    = x * 8
  | otherwise = x * 6

-- Exercises: Guard Duty
-- 1) Try putting an otherwise on top of all other guards
-- | otherwise = 'G'
avgGrade :: (Fractional a, Ord a)
         => a
         -> Char
avgGrade x
  | y >= 0.9  = 'A'
  | y >= 0.8  = 'B'
  | y >= 0.7  = 'C'
  | y >= 0.59 = 'D'
  | otherwise = 'F'
  -- | y <  0.59 = 'F' -- GHCi complains that we lack an otherwise if I use this one.
  where y = x / 100 

-- 2) Try moving the arguments around, does it still work the same?
-- No of course not.
-- 3) The following function:
pal :: (Eq a) => [a] -> Bool
pal xs
  | xs == reverse xs = True
  | otherwise        = False
-- Returns True when xs is a palindrome.
-- 5) Take types: [a] as long as a has an instance of Eq
-- 6) Has type function: See above, I'm an A-student and wrote a type signature.
-- 7) the following function:
numbersGD :: (Ord a, Num a) => a -> a
numbersGD x
  | x < 0      = -1
  | x == 0     = 0
  | otherwise  = 1
  -- | x > 0  = 1 - Same here, GHCi requires an otherwise.
-- Returns an indication of whether its argument is a positive or negative number or zero.
-- 7) Any Num implementing Ord, see type signature.
-- 8) See type signature.

-- Function composition
-- (This is what that blasted dot you see everywhere is used for!)
-- (.) :: (b -> c) -> (a -> b) -> a -> c
-- Note that function application has higher prescendence than composition
-- so we need to use $ or parens to get the order straight. For example:
-- (negate . sum) [1,2,3,4,5], or negate . sum $ [1,2,3,4,5]

add :: Int -> Int -> Int
add x y = x + y

addPF :: Int -> Int -> Int
addPF = (+)

addOne :: Int -> Int
addOne = \x -> x + 1

addOnePF :: Int -> Int
addOnePF = (+1)

addStuff :: IO ()
addStuff = do
    print (0 :: Int)
    print (add 1 0)
    print (addOne 0)
    print (addOnePF 0)
    print (addOne.addOne $ 0)
    print (addOne.addOnePF $ 0)
    print (addOnePF . addOnePF $ 0)
    print (negate $ addOne 0)
    print (negate . addOne $ 0)
    print (negate . addOne . addOne . negate . addOne $ 0)
