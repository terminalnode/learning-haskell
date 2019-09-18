-- Exercises for Chapter 6: Type classes
-- End of chapter exercises are in chapterExercises.hs

module ExercisesCh6 where
data Trivial =
    Trivial'
-- With no deriving clause this will throw an error if you try to
-- evaluate say Trivial == Trivial, saying there's no instance for (Eq Trivial).
instance Eq Trivial where
    Trivial' == Trivial' = True
    -- This is also valid:
    -- (==) Trivial' Trivial' = True
-- Now we have it!
-- Trivial' == Trivial' will now return true
-- We could also name the data constructor here Trivial without the "prim" at
-- the end, which is kind of strange, but differentiating between the two is easier.

-- Less trivial, days of the week and a datatype utilising dayofweek
data DayOfWeek =
    -- We can chuck deriving Show at the end here to make it printable.
    Mon | Tue | Wed | Thu | Fri | Sat | Sun
    -- Hi, I'm from the future, page 222.
    -- Your datatype has been upgraded with Ord!
    -- By deriving Ord automatically like this, the order in which the
    -- values are defined define the outcome. So Mon < Tue but Wed > Tue.
    deriving (Ord, Show) 
data Date =
    -- Date here below can be replaced by whatever nonsense word you
    -- want to start your dates with. However all other terms
    -- must be valid data types or it will give a compilation error.
    Date DayOfWeek Int
    -- For some reason chucking deriving Show at the end of this doesn't work.
    -- Something about not being able to bind it's type to IO ().

instance Eq DayOfWeek where
    Mon == Mon = True
    Tue == Tue = True
    Wed == Wed = True
    Thu == Thu = True
    Fri == Fri = True
    Sat == Sat = True
    Sun == Sun = True
    _   == _   = False

instance Eq Date where
    (==) (Date weekday dayOfMonth)
         (Date weekday' dayOfMonth') =
      weekday == weekday' &&
        dayOfMonth == dayOfMonth'

-- patternMatching thing. Returns true for 1 and 2 and false for anything else.
-- If you leave out the catch-all case and have -Wall turned on, you'll get a warning
-- saying that any case not matching 1 and 2 will be unmatched.
patternMatch :: Int -> Bool
patternMatch 1 = True
patternMatch 2 = True
patternMatch _ = False

-- Datatypes can also accept polymorphic parameters, and instances can be defined
-- so that these put some constraint on this polymorphism.
data Identity a =
    Identity a

-- This will work for any a that has in instance of Eq.
instance Eq a => Eq (Identity a) where
    (Identity v) == (Identity v') =
              v  ==  v'

-- It will not work if a is this.
data NoEq = NoEqInst deriving Show

-- Exercises: Eq Instances
-- Ch 6.5:    Writing Type class Instances
-- Write the Eq instance for the datatype provided.
data TisAnInteger = TisAn Integer
instance Eq TisAnInteger where
    (TisAn i) == (TisAn i') = 
           i  ==  i'

data TwoIntegers = Two Integer Integer
instance Eq TwoIntegers where
    (Two i1 i2) == (Two i1' i2') =
      (i1 == i1') && (i2 == i2')

data StringOrInt = TisAnInt Int | TisAString String
instance Eq StringOrInt where
    TisAnInt i == TisAnInt i' = i == i'
    TisAString s == TisAString s' = s == s'
    _ == _ = False

data Pair a = Pair a a
instance Eq a => Eq (Pair a) where
        (Pair a b) == (Pair a' b') =
         a  ==  a' && b == b'

data  Tuple a b = Tuple a b
instance (Eq a, Eq b) => Eq (Tuple a b) where
    (Tuple a b) == (Tuple a' b') =
        a == a' && b == b'

-- This one is stupid :p
data Which a = ThisOne a | ThatOne a
instance Eq a => Eq (Which a) where
    ThisOne a == ThisOne a' = a == a'
    ThatOne a == ThatOne a' = a == a'
    ThisOne a == ThatOne a' = a == a'
    ThatOne a == ThisOne a' = a == a'

data EitherOr a b = Hello a | Goodbye b
instance (Eq a, Eq b) => Eq (EitherOr a b) where
    Hello   a == Hello   a' = (a == a')
    Goodbye a == Goodbye a' = (a == a')
    Hello   _ == Goodbye _  = False
    Goodbye _ == Hello   _  = False

-- Exercises: Will they work?
-- Ch 6.8:    Ord
-- Take a look at the following code examples and try to decide if they will work.
wtw1 = max (length [1,2,3]) (length [8, 9, 10, 11, 12])
wtw2 = compare (3 * 4) (3 * 5)
wtw4 = (5 + 3) > (3 + 6)
-- Only one that doesn't work is (3) because
-- the compared values are from different types.
--wtw3 = compare "Julie" True


-- Ch 6.13: Gimme more operations
-- add :: a -> a -> a
add x y = x + y
-- This will give a compilation error because (+) is more specific
-- about the types it's allowed to operate on than our type signature
-- for "add". We're implying that add can process any datatype you throw
-- at itt, however (+) only allow datatypes that have a Num instance.
add :: Num a => a -> a -> a
-- Now it works.
