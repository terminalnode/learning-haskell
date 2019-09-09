-- Just "Hello world!" in Haskell
sayHello :: String -> IO()
sayHello x =
    putStrLn ("Hello, " ++ x ++ "!")

triple x = x * 3

-- Exercises: Comprehension check
-- Ch 2.5:    Evaluation
double x = x * 2
half   x = x / 2
square x = x * x
circleArea r = pi * (square r)

-- Exercises: Heal the Sick
-- Ch 2.7:    Declaring values (Troubleshooting)
-- 1. area x = 3. 14 * (x * x)
-- 3. 14 shouldn't have a space, and could be replaced with pi.
area x = pi * (x * x) -- or (pi * x * x)

-- 2. double x = b * 2
-- The argument is named x, not b.
double2 x = x * 2 
-- This approach also works,
-- but is probably not the intended result.
b = 2
double3 x = b * 2

-- 3. x = 7
--     y = 10
--    f = x + y
-- Indentation is wrong, just unindent y.
x = 7
y = 10
f = x + y

-- Exercises: A Head Code
-- Ch 2.10:   Let and where
-- let-part of this exercise is made in the REPL.
-- where-part is here:
mult1       = x * y
    where x = 5
          y = 6
-- let x = 3; y = 1000 in x * 3 + y
mult2       = x * 3 + y
    where x = 3
          y = 1000
-- let y = 10; x = 10 * 5 + y in x * 5
mult3       = x * 5      -- 300
    where x = 10 * 5 + y -- 60
          y = 10         -- 10
-- let x = 7
--     y = negate x
--     z = y * 10
-- in z / x + y
mult4       = z / x + y -- -17.0 (.0 due to fractional division)
    where x = 7         -- 7
          y = negate x  -- -7
          z = y * 10    -- -70
