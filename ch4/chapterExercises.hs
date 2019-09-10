module ChapterExercises4 where
-- These variables need to be in scope for these exercises.
awesome = ["Papuchon", "curry", ":)"]
also = ["Quake", "The Simpsons"]
allAwesome = [awesome, also]

-- Length is a function that takes a list and returns the number of items in that list.
-- (1.) What would the type signature for length be?
-- length :: [a] -> Integer
-- (actual: length :: Foldable t => t a -> Int, which is close enough)
-- (2.) What are the results of the following expressions?
lengthResult = a && b && c && d
    where a = (length [1, 2, 3, 4, 5]) == 5
          b = (length [(1,2), (2,3), (3,4)]) == 3
          c = (length allAwesome) == 2
          d = (length (concat allAwesome)) == 5
-- (3.) Which of these two will work and which will return an error? And why?
-- length returns an int however (/) demands a Fractional.
thisOneWorks = 6 / 3
-- thisOneWorks = 6 / length [1, 2, 3]
-- (4.) How can we fix the broken code from the preceding
-- exercise using a different division function/operator?
-- Integer division, but only works because 6/3 -> an integer.
thisOneWorks2 = div 6 (length [1, 2, 3])
-- (5.) What is the type of the expression 2 + 3 == 5? What would we expect as a result?
itsABool = (2 + 3 == 5) == True
-- (6.) What's the type and expected result value of the following?
x = 5
itsFalse = (x + 3 == 5) == False
--(7.) Below are some bits of code, which will work. Why/why not?
-- These will work
q71 = length allAwesome == 2
q73 = length allAwesome + length awesome
q74 = (8 == 8) && ('b' < 'a')
-- length [1, 'a', 3, 'b']      -- Lists can only contain a single type.
-- (8 == 9) && 9                -- Integers are not booleans
-- (8.) Write a function that tells you whether or not a given list is a palindrome.
-- Use the builtin function reverse.
isPalindrome :: (Eq a) => [a] -> Bool
isPalindrome x = x == reverse x
-- (9.) Write a function to return the absolute value of a number using if-then-else.
myAbs :: Integer -> Integer
myAbs x = if (x < 0)
             then (-x)
             else (x)
-- (10.) Fill in the definition of the following function using fst and snd.
f :: (a, b) -> (c,d) -> ((b, d), (a, c))
f x y = ((snd x, snd y), (fst x, fst y))

-- Correcting syntax
-- Int the following examples you'll be shown syntactically incorrect code.
-- Type it in and try to correct it.
-- (1.) We want a function that adds 1 to the length of a string arg.
cs1x = (+)              -- This is some trippy shit.
cs1F xs = w `cs1x` 1    -- (+) operator is being prefixisized, aliased, then infixisized
    where w = length xs
-- If we want to also fix sanity, maybe this:
cs1F2 x = 1 + length x
-- (2.) This is supposed to be the identity function, id.
-- I don't know what \X = x is intended to mean, but here's an identity function:
cs2 x = x
-- (3.) When fixed, this function will return 1 from the value (1,2)
cs3 (a, b) = a
 -- Match the function names to their types
 -- Try as I might, these are multiple choice questions and can't really be done in code.
 -- (1) c   (3) a
 -- (2) b   (4) d






















