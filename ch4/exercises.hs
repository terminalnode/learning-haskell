-- Exercises for Chapter 4: Basic datatypes
-- End of chapter exercises are in chapterExercises.hs

module ExercisesCh4 where
-- Exercises: Mood Swing
-- Ch 4.3:    Anatomy of a data declaration
-- Given the following datatype
data Mood = Blah | Woot deriving Show

-- (1) What is the type constructor/name of this type?
-- Mood
--
-- (2) What values does it take?
-- Blah and Woot
--
-- (3) Why can't `changeMood Mood -> Woot` work as a not-like type signature for the datatype?
-- Woot is not a datatype. Furthermore if we input Woot we wan't
-- it to output Blah so it's wrong in lots of ways.
changeMood :: Mood -> Mood
-- (4) Fix some pattern matching thing.
changeMood Blah = Woot
changeMood    _ = Blah
-- (5) Enter everything into a source file lol done

-- Exercises: Find the Mistakes
-- Ch 4.6:    Go on and Bool me
x = 1 -- Needs to be defined
-- Find the mistakes and correct them.
-- (1) not True && true
ftm1 = not True && True
-- (2) not (x = 6)
ftm2 = not (x == 6)
ftm3 = (1 * 2) > 5 -- This compiles just fine.
-- (4) [Merry] > [Happy]
ftm4 = ["Merry"] > ["Happy"]
-- (5) [1,2,3] ++ "look at me!"
ftm5 = "1,2,3" ++ "look at me!"

-- greetIfCool1.hs
-- wat
greetIfCool :: String -> IO ()
greetIfCool coolness = 
    if cool
       then putStrLn "eyyyy. What's shakin'?"
    else
       putStrLn "pshhhh"
    where cool =
            coolness == "downright frosty yo"

-- Ch 4.7 Tuples















