# Chapter 9: Lists
## Using ranges to construct lists
We've used the `enumFrom*` functions and ranges such as `[1..10]` before. Well, apparently the double-dot syntax is just syntactic sugar for `enumFrom*` and it actually can handle stuff like `[1,2..10]`, `[1,2..]` and `[1..]` (as well as ['t'..'z'], of course).

## List comprehensions
Coming from python, the base case of a list comprehension is very familiar. `[x^2 | x <- [0..10]]` is the same as `[ i*i for i in range(10) ]`, only difference being that the haskell syntax looks way cooler.

### Predicates
Optionally, a predicate can be added to the list. This works the same as adding an if clause to a pythonic list comprehension. `[x^2 | x <- [0..10], rem x 2 == 0]` is the same as `[i*i for i in range(10) if (i % 2 == 0)]`

### Multiple generators
List comprehensions also support adding multiple generators, the list will then loop through both of them. For something like [x^y | x <- [1..5], y <- [2..3]] the list will loop `(x=1, y=2), (x=1, y=3), (x=2, y=2), (x=2, y=3)` and so on.

And since we're comparing to Python, this is the equivalent of adding two "for i in [...]" which I didn't know you could actually do. The more you know! `[i*j for i in range(10) for j in range(3)]` is valid syntax (though not equivalent to the Haskell variant above).

Of course you can add a predicate to this as well if you'd like. Perhaps something combining the two variables such as `((x^y) < 200)`.

### Tuple lists
Look, this is pretty cool: `[(x,y) | x <- [1..3], y <- ['a'..'c']]`

We made a tuple list!

### I heard you like list comprehensions, so...
`[x^2 | x <- [x^2 | x <- [1..10]]]`

## New operation: elem
`elem` is a fantastic operation that tells us if an element is a member of a list. It's type is `Eq a => a -> [a] -> Bool`. `elem 'z' "Zootopia"` is False because 'z' is not in "Zootopia", `elem 'z' "zootopia"` is True because 'z' is in "zootopia".

It can also be useful for predicates in list comprehensions. Just look at this beauty! `[x | x <- ["Alexander","Linux","Windows","macOS"], elem 'x' x]`

## New operations: zip, zipWith, unzip, unzip3
zip is pretty self explanatory, `zip [1,2,3] [4,5,6]` produces `[(1,4), (2,5), (3,6)]`. Neat.

zipWith is also pretty simple, but very cool. It takes a function (a -> b -> c), a list a and a list b to produce a list c. `zipWith (+) [1,2,3] [4,5,6]` produces `[5,7,9]`.

Both of these functions will stop as soon as either of the lists run out of values. So something like `zip [1] [1..9001]` will return `[(1,1)]`.

`unzip` works to undo what `zip` does, so `unzip [(1,4), (2,5), (3,6)]` will return the afforementioned `([1,2,3], [456])` (in a tuple as shown).

There's also `zip3` `zipWith3` and `unzip3` which all work more or less as you'd expect. `unzip3 [(1,4,7), (2,5,8), (3,6,9)]` returns `([1,2,3], [4,5,6], [7,8,9])`.

## Pattern matching on _
We've done _ pattern matching before, a lot. In this chapter we learned that apart from having the compiler not warn us about variables not being used, this also serves the purpose of telling the compiler that a value need not be evaluated and thus we can save a few cycles.

## How map is defined in base
```haskell
map :: (a -> b) -> [a] -> [b]
map _ [] = []
map f (x:xs) = f x : map f xs
```
Note that if it matches to an empty list, the function is discarded and an empty list is returned. This kind of recursive pattern in general seems really common and useful, and something that might be useful to commit to memory.

## Product types and sum types
In type theory, a product type is a type made of a set of types compounded over each other, if you have a product of Bool and Int the terms much each contain both a Bool and an Int value. A sum type of two types is one where the type is one of two types - not both at the same type. A sum type of Bool and int will be one of the two - not both.

## Cons'ing
To cons a value means placing it at the head of the list (which in Haskell is done with the cons operator), as in `1 : [2,3]`. `1` has now been consed onto `[2,3]`.

## Spine
*Spine* refers to the structure that glues a collection of values together. In the list datatype this is formed by a recursive nesting of cons cells. Often it refers to the spine of a list, but it applies to various different types of trees.
