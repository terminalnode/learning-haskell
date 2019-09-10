module ChapterExercises3 where

-- Reading syntax
-- Decide if the syntax of the following statements is correct. If not correct them.
rsa = concat [[1,2,3], [4,5,6]] -- Works with no modification.
-- rsb = ++ [1,2,3] [4,5,6]
rsb = (++) [1,2,3] [4,5,6]      -- Infix operator used as prefix needs paretheses
rsc = (++) "hello" " world"     -- Works with no modification.
-- rsd = ["hello" ++ " world]
-- rsd = ["hello" ++ " world"]  -- Works, but creates a list containing one string.
rsd = "hello" ++ " world"       -- Probably the intended result.
-- rse = 4 !! "hello"
rse = "hello" !! 4              -- First list, then index.
rsf = (!!) "hello" 4            -- Works with no modification.
-- rsg = take "4 lovely"
rsg = take 4 "lovely"           -- Returns the a list containing the first four entries.
rsh = take 3 "awesome"          -- Works with no modification.

-- Match expressions and results
-- Expressions
rsExpA = concat [[1 * 6], [2 * 6], [3 * 6]]
rsExpB = "rain" ++ drop 2 "elbow"
rsExpC = 10 * head [1, 2, 3]
rsExpD = (take 3 "Julie") ++ (tail "yes")
rsExpE = concat [ tail [1, 2, 3],
                  tail [4, 5, 6],
                  tail [7, 8, 9]]
-- Results
rsResA = "Jules"
rsResB = [2, 3, 5, 6, 8, 9]
rsResC = "rainbow"
rsResD = [6, 12, 18]
rsResE = 10
allMatchesCorrect = a && b && c && d && e
    where a = checkMatches rsExpA rsResD
          b = checkMatches rsExpB rsResC
          c = checkMatches rsExpC rsResE
          d = checkMatches rsExpD rsResA
          e = checkMatches rsExpE rsResB
          checkMatches a b = a == b

-- Building functions
-- (1) Use the list-manipulation functions in the chapter to produce
-- the expected result from the given inputs.
bf1 x = x ++ "!"
bf2 x = [(x !! 4)]
bf3 x = "" ++ (drop 9 x)
allFunctionsCorrect = a && b && c
    where a = (bf1 "Curry is awesome")  == "Curry is awesome!"
          b = (bf2 "Curry is awesome!") == "y"
          c = (bf3 "Curry is awesome!") == "awesome!"
-- (2) Now take each of the above and rewrite it in a source file bla bla, all done.
-- (3) Write a function of type String -> Char returning the third letter of a String.
thirdLetter :: String -> Char
thirdLetter x = x !! 2
-- (4) Now reverse it so the string is always the same but the number changes.
letterIndex :: Int -> Char
letterIndex x = "Curry is awesome!" !! x
-- (5) Make a function that can reverse "Curry is awesome" to "awesome is Curry".
-- It doesn't need to work on every sentence, just this one.
rvrs x = (drop 9 x) ++ (take 4 (drop 5 x)) ++ (take 5 x)
