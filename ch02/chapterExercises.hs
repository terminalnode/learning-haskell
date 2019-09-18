module ChapterExercises where

-- Parenthesization
-- Rewrite the original expressions (_before) with parentheses to make them more explicit.
parens1_before = 2 + 2 * 3 - 1
parens1 = 2 + (2 * 3) - 1

parens2_before = (^) 10 $ 1 + 1
parens2 = 10 ^ (1 + 1)

parens3_before = 2 ^ 2 * 4 ^ 5 + 1
parens3 = (2 ^ 2) * (4 ^ 5) + 1

-- Equivalent expressions
-- Which of these expressions return the same result when evaluated?
-- All of these should return True
equiv1         = exp1 == exp2
    where exp1 = 1 + 1
          exp2 = 2

equiv2         = exp1 == exp2
    where exp1 = 10 ^ 2       -- 100
          exp2 = 10 + 9 * 10  -- 10 + 90 = 100

equiv3         = exp1 /= exp2
    where exp1 = 400 - 37
          exp2 = (-) 37 400

-- This gives some kind of type error because 100 / 3 is of ambiguous type.
-- They are not equivalent because / is fractional division and div is integral division.
-- The ambguousness arise from the fact that a fractional can be both Double and Float.
-- equiv4         = exp1 /= exp2
--     where exp1 = (100 `div` 3)
--           exp2 = (100 / 3)

equiv5         = exp1 /= exp2
    where exp1 = 2 * 5 + 18
          exp2 = 2 * (5 + 18)

-- More fun with functions
z = 7
x = y ^ 2
waxOn = x * 5
y = z + 8
triple x = x * 3

-- What happens if you enter:
--    a) 10 + waxOn
--    b) (+10) waxOn
--    c) (-) 15 waxOn
--    d) (-) waxOn 15
--    waxOn = x * 5 = y^2 * 5 = (z + 8)^2 * 5 = 15^2 * 5 = 225 * 5 = 1125
fun1a = (10 + waxOn) == 1135
fun1b = ((+10) waxOn) == 1135
fun1c = ((-) 15 waxOn) == (-1110)
fun1d = ((-) waxOn 15) == 1110

-- Rewrite waxOn with a where clause.
waxOn2      = x * 5
    where x = y ^ 2
          y = z + 8
          z = 7
reWax = waxOn2 == waxOn

-- Make a waxOff function
waxOff x = triple x











