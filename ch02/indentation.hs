module Learn where
-- Note: Order doesn't matter
--       All variables are loaded "at the same time"
x = 10 * 5 + y
myResult = x * 5
y = 10

foo x =
    let y = x * 2
        z = x ^ 2
    in 2 * y * z

-- Indentation stuff
-- Ofc this doesn't work:
-- a = 10
-- * 5 + y
--
-- But wah, this works:
ab = 10
    * 5 + y
-- 
-- And so does this:
abc = 10
      * 5 + y
-- This also works:
abcd = 10
 * 5 + y
-- So basically any level of indentation I suppose?
abcde = 10
                                * 5 + y
-- Don't do that... but hey it works.
-- One last try....
abcdef = 10
            * 5
    + y
        / 10
              - 32
-- Fucking hell
