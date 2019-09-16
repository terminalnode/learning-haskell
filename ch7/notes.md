# More on type inference
The type inference will always infer the broadest possible (most polymorphic) type. If a function takes one or more arguments that it doesn't use these will be infered to be t, t1, t2 and so on. Like `a` the type `t` is a variable, it just means the types for these don't matter since we're not actually doing anything with them.

# newtype vs data declarations
newtype is a special case of data declarations. Instead of the keyword data it uses `newtype` and permits only one constructor and one field. Later chapters will dive deeper into how it's different.

# :browse module
Use :browse to view all the type signatures and functions loaded from module.

# Composition operator (.)
The composition operator allows us to combine two different functions. For example `(take 5 . filter odd) xs` till first apply `filter odd` to xs, then pass that result on to `take 5`. Basically it seems to work like pipes in shell scripting. Very cool.

`(.) :: (b -> c) -> (a -> b) -> (a -> c)`, given a function bToC and aToB, return a function aToC.

# Terminology
## Binding a value to a parameter
Consider a function such as `addOne x = x + 1`, until the function is called with an argument x we don't know what value it will return. If we call it with an argument we say that the value is *x is bound to* the value we applied to the function.

## Shadowing
A variable is said to be shadowed when a variable in a local scope goes by the same name. For example the function `z y = y + 5` can not access a value assigned to y in the global scope.

## Pointfree style
Pointfree style defines compound functions which arguments are then applied to, rather than applying the arguments directly. This makes the code easier to read and is generally speaking just very cool.

## Bottom
Bottom is a non-value used to denote that the program can't return a value or result, an example of this is a program that loops infinitely. Another kind of bottom are programs with incomplete pattern matching, which can be useful for signaling when various code paths are being evaluated and when they're not. There will be much more on bottom later, but these are the basics.
