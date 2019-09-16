# Polymorphism
The compiler will try not to infer type until the last possible moment. For some types this is immediately, for example True/False can only ever be boolean values. But if we input a number such as `x = 13`, this will start out as the broadest possible type of number which is `Num`. This can later be interpreted as an `Integer` or `Fractional` at a later point when such detail is necessary.

A polpmorphic type can interract with more specific types, but specific types can not interract with eachother. For example Int + Num and Double + Num do work (and returns ints and doubles respectively), but Double + Int are incompatible.

## Going from specific Integral type to unspecific Num type.
`fromIntegral :: (Num b, Integral a) => a -> b` can force an integral number to become the Num type, making it available for a wide variety of interraction with other nums.

# Type class constraints in signatures
Signatures will often start with something like `Num a =>` followed by the regular `a -> a -> a` or whatever. This is a type class constraint, it's telling us that it accepts any type `a` that has an instance of the Num class. If we want to constrain multiple variables in this way this can be done like this: `(Num a, Int b) =>`. We can also put multiple constraints on a single variable, such as `(Num a, Ord a) =>`.

# Currying
Functions that take multiple arguments are an illusion in Haskell, such functions do not exist in reality. These are syntactic conveniences that construct *curried* functions by default, where currying refers to the nesting of multiple functions, each accepting one argument and returning one result.

This is also why the type signatures have so many `->`. Because technically a function taking two arguments is just taking one argument, returning a value (in this case another function taking one argument), then returning the final value. The normalized/fully reduced value.

## Partial application
A side-effect of currying is that we can do partial application of a function, meaning we can create a new function from a function with only some of it's argument applied. This is best explained through example:
- `addFive a b = a + b + 5`, takes two arguments and add 5 to them.
- `addTen = addStuff 5`, add ten has already applied one of the arguments to addFive and can take the other one whenever we feel like it.
- `addTen 5`, this outputs 15, because we've applied the argument 5 to addTen which in turn applied the argument 5 to addFive.

# List generation
We can generate a list using `..`. For example [1..10] creates a list of elements 1 to 10 (inclusive).

# Ignoring arguments
By defining a parameter as _ you can ignore whatever gets input there. For example with `myFunc _ x _ = x`, `myFunc 1 2 3` will output 2 while ignoring 1 and 3.
