# Numeric types
## Integral numbers
- `Int` is a regular integer type, it can't be arbitrarily large or small. There are a few related types such as `Int8` for 8-bit integers, `Int16` etc. Don't use any of them. If you want to see the maximum or minimum bound for the Int types, use `minBound :: Int<num>` or `maxBound :: Int<num>`. For any type we can see if it has an instance of Bounded by checking :info for the desired type.
- `Integer` is a more powerful variant of `Int` which can be arbitrarily large or small.
- `Word` is similar to `Int` but doesn't handle negative numbers.

## Fractional numbers
- `Float` is a single-precision floating point number like in every other language.
- `Double` is a double-precision floating point number.
- `Rational` carries fractional numbers such as `1 / 2 :: Rational`. Arbitrarily precise but less efficient than Scientific.
- `Fixed` is a fixed-point/fixed-precision type that can represent varying numbers of decimal points depending on the exact type chosen. `Fixed E2` for example tracks up to two digits after the decimal point. The `base` library provides E0, E1, E2, E3, E6, E9 and E12.
- `Scientific` is a space efficient and almost arbitrarily precise scientific number type. It stores the coefficient as an `Integer` and the exponent as an `Int`.

# Tuples
`swap` swaps the two values in a two-tuple, but is not included in prelude. `import Data.Tuple` to get it.

## Arity
A tuples *arity* is the number of values it can hold. A two-tuple/pair has an arity of two. A triple or three-tuple has an arity of 3. 

## Product type
A tuple is a product type because you need to supply *both* arguments to construct a value, not just one. This is different from the boolean sum type where the value is one of multiple possible values.

If you require your tuple to be a certain pattern, a tuple's type is represented as (a, b). So a pattern signature such as myFunc :: (Int, [a]) -> (Int, [a]) -> (Int, [a]) will only allow tuples with one Int and one list.

## Contained types
A tuple allows the contained values to be of different types.

# Lists
Similarily to tuples lists contain multiple values (the content of the list) within a single value (the list itself), however unlike tuples all values within the list need to be of the same type and the length isn't fixed.

It's important to note that lists do not contain variables, only value. If a list is defined using a variable, that variable's value is what's going to be put into the list.
