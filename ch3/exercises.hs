-- Exercises for Chapter 2: Strings
-- End of chapter exercises are in chapterExercises.hs

module ExercisesCh2 where
-- print1.hs
main :: IO ()
main = putStrLn "hello world!"

-- print2.hs
-- This naming is a bit stupid, but keeping all exercises in one file is handy.
main2 :: IO () 
main2 = do
    putStrLn "Count to four for me:"
    putStr   "one, two"
    putStr   ", three and"
    putStrLn " four!"

-- print3.hs
myGreeting :: String -- set type signature to String
myGreeting = "hello" ++ " world!"

-- Set type signature to [Char].
-- Interestingly :t hello and :t world list [Char] and String respectively,
-- even though the book says that they are synonyms.
hello :: [Char] 
hello = "hello"

world :: String
world = "world!"

main3 :: IO ()
main3 = do
    putStrLn myGreeting
    putStrLn secondGreeting
    -- important that concat is more indented than secondGreeting
    where secondGreeting =
           concat [hello, " ", world] 

-- 3.4 Top-level versus local definitions
topLevelFunction :: Integer -> Integer
topLevelFunction x =
    x + woot + topLevelValue
    where woot :: Integer
          woot = 10

topLevelValue :: Integer
topLevelValue = 5

-- Exercises: Scope
-- Ch 3.4:    Top-level versus local definitions
-- These lines of code are from a REPL session. Is y in scope for z?
scopeX = 5
scopeY = 7
scopeZ = scopeX * scopeY -- Yes it is.
-- Same question, is h in scope for g?
--scopeF = 3
--scopeG = 6 * scopeF + scopeH -- No it's not, h is undefined.
--These lines are from a source file, is everything area needs in scope?
--scopeArea d = pi * (r * r)
--scopeR = d / 2 -- Nope, d is undefined.
-- Now are they in scope?
scopeArea d = pi * (r * r)
    where r = d / 2 -- yes, d is half of whatever argument you pass in

-- Exercises: Syntax Errors
-- Ch 3.5:    Types of Concatenation functions
-- Read the following statements and decide whether they will compile. If not, fix them.
-- 1. ++ [1,2,3] [4,5,6]
serr1 = (++) [1,2,3] [4,5,6]
-- 2. '<3' ++ ' Haskell'
serr2 = "<3" ++ " Haskell"
-- 3. concat ["<3", " Haskell"]
serr3 = concat ["<3", " Haskell"]

-- 3.6 concatenation and scoping

myGreeting36 :: String
myGreeting36 = (++) "hello" " world!"

hello36 :: String
hello36 = "hello"

world36 :: String
world36 = "world!"

main36 :: IO ()
main36 = do
    putStrLn myGreeting36
    putStrLn secondGreeting
    where secondGreeting =
            (++) hello36 ((++) " " world36)
            -- This won't work:
            -- (++) hello36 (++) " " world36

-- Alternative solution: 
--    Declare greeting in the global scope so printSecond can access it.
main362 :: IO ()
main362 = do
    putStrLn greeting
    putStrLn greeting
    where greeting =
            "Yarrrrr"

