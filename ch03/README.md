# GHCi commands
- :type for printing out the type of a variable, function, expression or value (:t 'a')

# IO () type
Any function that involves other things than evaluating expressions and functions must have the IO type. This includes any function that's going to write things to screen. When entering functions directly into the REPL it's implied that you need IO, but for source files it should be specified (though the compiler can sometimes infer it from context).

The `main` function of a program always has to have this type.

# New operations
- `:` (cons) creates a list. (`'c' : "hris"` returns `"chris"`)
- `head` returns the first element of a list (`head "Chris"` returns `'p'`)
- `tail` returns all elements of a list that are not head (`tail "Chris"` returns `"hris"`)
- `take n` returns the first n elements from a list:
- - `take 0 "Papuchon"` returns `""`
- - `take 1 "Papuchon"` returns `"P"`
- - `take 2 "Papuchon"` returns `"Pa"`
- `drop n` returns what's left of the list after dropping n items of a list.
- - `drop 0 "Papuchon"` returns `"Papuchon"`
- - `drop 1 "Papuchon"` returns `"apuchon"`
- - `drop 2 "Papuchon"` returns `"puchon"`
- - `drop 9 "Papuchon"` returns `""`
- `[a] !! n` returns the n:th entry of the list [a]:
- - `"Chris" !! 0` returns `'C'`
- - `"Chris" !! 1` returns `'h'`
- - `"Chris" !! 9` returns an Exception (index too large)
