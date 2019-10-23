# Chapter 10: Folding Lists
Folds are a way to reduce list, for very simple folds it can be thought of as replacing the cons operators (`:`) in a list with the given function and the final [] with the initialised value. For example `foldr (+) 0 [1,2,3]` would reduce to `1 + (2 + (3 + 0))`.

The type signature for `foldr` is:
```haskell
foldr :: Foldable t =>
         (a -> b -> b) -> b -> t a -> b
```
where a and b *can* be the same type, but they don't have to be. The important thing is that the function can use its own return value as well as a value from the provided foldable.

The gist of this chapter is how foldl and foldr work, which can be summarised as follows:
* **foldr** starts with `f lastElement acc` and ends with `f firstElement acc`, then returns the same type as .
* **foldl** starts with `f acc firstElement` and ends with `f acc lastElement`, then returns the same type as `acc`.

Also:
foldr f z xz = foldl (flip f) z (reverse xs)

Do note that this only holds true for when both arguments need to be evaluated. For other cases consult the section on visualizing the folding process.

## scanr/scanl vs foldr/foldl
The scan functions will print a list with every step of the reduction made in a fold. The relation between these functions is such that the last entry in scanl will be the output of foldl, and the first entry of scanr will be the output of foldr.

In other words:
`last (scanl f z xs) = foldl f z xs`
`head (scanr f z xs) = foldr f z xs`

# Visualizing the folding process
We can define our own foldr as follows:
```haskell
foldr :: (a -> b -> b) -> b -> [a] -> b
foldr _ z [] = z -- End of the list / default case
foldr f z (x:xs) = f x (foldr f z xs)
```
If we follow the application of `foldr f z (1 : 2 : 3 : [])` it will look like this:
```haskell
foldr f z [1, 2, 3]
1 `f` (foldr f z [2, 3])
1 `f` (2 `f` (foldr f z [3]))
1 `f` (2 `f` (3 `f` (foldr f z [])))
1 `f` (2 `f` (3 `f` z)) -- End of list / default case triggered
```
The parentheses are important, the inner most parentheses are evaluated first, and so in this example ``3 `f` z`` is evaluated first. Due to lazy evaluation it's possible that we will not have to evaluate every set of parentheses, for example if the list is cut short.

Another example, this time illustrating the difference between `foldr` and `foldl`.
```haskell
foldr (^) z [1..3]
(1 ^ (2 ^(3 ^ z)))
(1 ^ (2 ^9)) -- z = 2
1 ^ 512
1
```
```haskell
foldl (^) z [1..3] -- same arguments, different function
((z ^ 1) ^ 2) ^ 3
(2 ^ 2) ^ 3 -- z = 2
4 ^ 3
64
```

# foldl'
`foldl'` is the same as `foldl`, except that it forces evaluation of the values inside of cons cells as it traverses the list. Both `foldl'` and `foldl` are forced to traverse the entire spine before it begins evaluation, however since `foldl'` evaluates the values of the cells as it traverses the spine it has less of an impact on performance for very long lists.

# Catamorphisms
Catamorphism applies the concept of breaking down a data struture into another (in folds that structure is a list or other foldable structure). A catamorphism breaks down the structure of any data type, some examples catamorphic functions are `Data.Bool (bool)`, `Data.Maybe (maybe)` and `Data.Either (either)`.
```haskell
-- Data.Bool (bool)
-- Takes two values and a boolean. Returns the first if False, otherwise the second.
bool :: a -> a -> Bool -> a
-- Example:
bool 1 2 False -- Returns 1
bool 1 2 True  -- Returns 2

-- Data.Maybe (maybe)
-- Takes a default value, an operation and a Maybe <type of default value>.
-- If the Maybe isn't Nothing, return operation applied to it. Otherwise default.
maybe :: b -> (a -> b) -> Maybe a -> b
-- Example:
maybe 1 negate Nothing  -- Returns 1
maybe 1 negate (Just 1) -- Returns -1

-- Data.Either (either)
-- If Either a b is of type a, apply (a -> c). If not, apply (b -> c). Return c.
either :: (a -> c) -> (b -> c) -> Either a b -> c
-- Example:
x1 = Left "foo" :: Either String Int
x2 = Right 2 :: Either String Int
either length (*2) x1 -- Returns 3
either length (*2) x2 -- Returns 4
```
