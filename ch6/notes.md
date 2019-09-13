# instance typeClass dataType
When querrying `:info dataType` in GHCi a class will get a list of instances which this class has. This can be thought of in similar terms to inheritance in OOP languages, but not exactly. For example Integer is a kind of Num because it has an `instance Num Integer`, meaning it has implemented all of the methods common to Num.

# Type class deriving
Deriving a type class instance means you don't have to manually type it out for each new datatype you create, this will be adressed in more detail later in the book but the type class instances we can "magically" derive are `Eq`, `Ord`, `Enum`, `Bounded`, `Read` and `Show`.

# Creating an Eq instance
Eq is very easy to create an instance for and thus used as an example. To investigate a type class refer to the Hackage documentation for that type class, for type classes in the base library you'd want to look at `http://hackage.haskell.org/package/base`, and for `Eq` specifically `/docs/Data-Eq.html`.

In the documentation a minimal complete definition will be listed, and for Eq this is "either == or /=" (because one can be derived from the other). You can define both of these, however in most cases it's a very silly thing to do.

# set -Wall
If we use `:set -Wall` before importing a module in GHCi, we will turn on more warnings (all of them, in fact: "Warnings all"). This will, among other things, give warnings when you have non-exhaustive pattern matches. Such as if we leave out the `_ == _ = False` from our DayOfWeek datatype in exercises.hs. If the pattern matches are non-exhaustive and an unexhausted match is encountered it will cause a runtime exception, which is terrible.

# Creating monomorphic functions from polymorphic functions
It's possible to redefine a common function so it's using a more narrow/specific type signature than the original. For example (+) normally takes any Num argument, but it's possible to define a function such that `add = (+) :: Integer -> Integer -> Integer`.

It is not however possible to go the other way. We can not define a new function based on our new add function that takes Num arguments. The following will raise an error: `addNum = add :: Num a => a -> a -> a`.

# How to read (use the read function)
Senpai tells us not to use read, but *if* we really want to we can. It's type signature is `read :: Read a => String -> a`, so it returns a readable datatype (one that implements Read) from a string. The syntax for this is `read "123456" :: Integer` for parsing the string "123456" and return an Integer type.

# Type class inheritance
Type class inheritance is when a type class has a superclass, meaning that the class requires another class to be available for a given type before you can write an instance. For example Fractional has the superclass Num, for a type to qualify as a Fractional it needs to implement Num. In the class definition this is expressed as `class Num a => Fractional a where [...]`.

# Effects
Effects are how we refer to observable actions programs may take, actions other than computing a value. For example `putStrLn x` produces an effect where x is printed to the screen. IO is the type for values whose evaluation produce an effect, or has the possibility to produce an effect.












