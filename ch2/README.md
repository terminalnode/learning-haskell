# Type signature
sayHello :: String -> IO () tells us that sayHello has the type signature String -> IO ()

# GHCi commands
- :info for listing information (:i someFunction)
- :load for loading a module (:l myfile.hs)
- :module for unloading everything and returning to prelude (just :m)
- :quit for quitting (just :q)
- :reload for reloading module(s) (just :r)

# Arithmetic functions
The basic arithmetic functions are what you'd expect, there's plus, minus and multiplication. Division and remainder functions has a bit more flair than in some languages though.

- `/` is fractional division.
- `div` is integral division, rounding down.
- `quot` is integral division, rounding towards zero.
- `rem` is remainder after division.
- `mod` is like rem, but after modular division.

`div 20 (-6)` returns -4, because it rounds down.
`quot 20 (-6)` returns -3, because it rounds towards zero.

## Laws for quotients and remainders
`(quot x y) * y + (rem x y) = x`
`(div x y)  * y + (mod x y) = x`

## Positive and negative arguments
With `mod` the result has the same sign as the divisor.
With `rem` the result will have the same sign as the dividend.

# Dollar sign operator ($)
`$` has the lowest possible precedence score (0) and is defined as `f $ a = f a`. It's right associative, meaning that it processes a before f, and thus allows you to do things with fewer parentheses.

Basically, `(2 ^) (2 + 2)` is the same thing as `(2 ^) $ 2 + 2`, because `$` forces the right hand side to be evaluated first.

# Prefix and infix operators
Most haskell functions use a prefix style, i.e. `div arg1 arg2`. But the common operators use an infix style, i.e. `1 + 1`. By wrapping an infix operator in parenthesis you can make it behave as a prefix operator, and by wrapping a function in backticks you can make it work as an infix. ``(+) 1 1`` and ``arg1 `div` arg2``.

Alphanumeric function names are prefix by default but can *sometimes* be made infix via backticks. Symbolic function names such as `+`, `/` and `*` are infix by default but can always be made prefix by wrapping them in parenthesis.

## Associativity
By using the :i command in the GHCi we can get information about whether a command is an infix or a prefix and whether it's right or left associative, as well as it's precedence value.

For example `:i *` tells us `infixl 7 *`, meaning that it's a left-associative infix operator with presedence 7. High prescendence is indicated by high numbers, so a prescendence of 8 will have prescendence over a precedence of 7.

## Sectioning
When using infix operators you can use *sectioning* to pass around partially applied functions. The syntax for this with the `+` operator as example is `(+1)` or `(1+)`.

In case of the `(+)` operator it makes no difference whether you type `(+1) 1` or `(1+) 1` because addition is commutative. Division is not commutative, so `(1/) 2` will return `0.5` while `(/1) 2` will return `2.0`.

Subtraction is a special case. `(2-) 1` and `(-) 2 1` will work, but `(-2) 1` will not because `(-2)` is syntactic sugar for `(negate 2)`. Though you can use `(subtract 2) 1`, if you must.

# Terminology
## Normal or canonical form
We say an expression is in normal form (sometimes called canonical form) when it's not possible to reduce it any further, for example the expression `1+1` has the normal form `2`. The expression `1+1` is a reducable expression or a redex. The process of converting it to it's normal form is called evaluation or reduction (and sometimes normalization or execution).

## Currying
As in lambda calculus all functions in Haskell take one argument and return one result. When multiple arguments are passed to a function we are actually applying a series of nested functions, this process is called currying.
