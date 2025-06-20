
# 1. type theory and type systems

- type theory to avoid paradoxes when working with 'higher-order' predicates in mathematics
    - a set cannot contain itself; a set of real numbers cannot contain an element that is, itself, a set of real numbers
    - consider a set of colors, and a set of fruits. both sets have 'orange'. what happens when you try to eat the color orange? would 'orange' be in the union twice? isn't that illegal for a set?
- applicable in computer systems:
    - how two values can interact safely (add, sort, compare, etc)
    - functions that can be applied to the values
    - size of object for easier memory addressing and calculations
    - higher-order types, unions, nullable, etc


terms to cover:

- invariance
- coercion
- inferrence
- boxing/unboxing


set theory? formal systems? or skip?


show an example or two, translate to typescript code




- identity types represent an equality between two values
- what is equality? it means you can substitute one value for another in _any_ situation

- to prove a theorem, we use antother theorem, which is proved by other theorem, etc.
- under all of that, the theorems are evaluated according to propositions called axioms
- if one of the underlying axioms changes, all of the theorems built on top of that axiom change as well
- a change in one axiom can one theorem to conflict with another, creating a situation where two unequal things are equal


type = set + functions


native set theory:

numbers are actually sets(?)
a set `contains` all of the elements of that set
set identity is based on the elemnts it contains
the ordering of elements in a set does not matter
repeated elements are ignored (do not change identity)
unrestricted composition
any subset is a set
a set can contain sets
a set can have just one member
a set can have no members
a set with no elements is a null set.
since a set's identity is determined by members, so _any_ two empty sets are equal
you can make a set of sets, or a set of all sets
sets can contain themselves (unrestricted composition makes this ok)

does the set of all sets contain itself?
yes

the set of all sets that do not contain themselves, does this set contain itself?
if it does contain itself, then it does.
if it does not contain itself, it is a part of the set of sets that do not contain themselves, therefore it does.

russell tried to ammend the rules and say a set cannot contain itself, but then you have to also change the rule that says you can have unrestricted composition.

the rules of set theory are kind of made up, but the issue comes from linguistics:

predication - the part of the sentence that says something about the subject ("garfield" _"is a cat"_)
set -- contain --> object
predicate -- is true of --> subject
there is a set for _anything_
you can predicate _anything_ about a subject
`"is a cat" sounds funny.` - "is a cat" is the subject, "sounds funny" is the predicate. this is legal. predicate of a predicate.
predicates can be true of themselves
"Is a cat" is a cat - false
"Is a predicate" is a predicate - true!
"a string of words" is a string of words - true!
"is true of itself" - a predicate that is true of all predicates that are true of themselves
what about "is not true of itself"?

this sounds like "this statement is false" from godel?





in math a function is just a mapping of every possible input to every possible output, short-hand and notation to represent that

(lambda is `ctrl-K l*` in insert mode)

`λx.M` is a lambda abstraction of a function that takes a value `x` and returns a result `M`

function application
`λx.x + 1`
to find the result mapping (remember that a function is just a set of every possible pair of input and output),
substitute `3` for every instance of `x`
notation: `(λx.x + 1) 3 -> 4`
beta reduction: `(λx.x + 1) 3 -> β 3 + 1`
`(λx.M) N` -> β `M[N substitued for x]`
replace `M[N substituted for x]` with `M[N/x]` notation

if you define:
- variables
- λ-abstractions
- applications
then you can compute anything using beta reduction
how? higer-order functions and notation. functions can be passed as arguments, returned as results
notice that lambda abstractions have only a single input.
how do you handle multiple inputs? returning a new function using the first argument that takes the second argument.
`(λx.λy.x + y) 1 2`
->
`(λy.1 + y) 2`
=>
`1 + 2`
this explains nixlang and haskell

boolean/conditionals
```
True = λx.λy.x
False = λx.λy.y
ifthen = λb.λx.λy.b x y
(λb.λx.λy.b x y) True M N = M
(λb.λx.λy.b x y) False M N = N
```



TODO:

- introduction
    - 'constructor' or 'accessor'; rule for how the input values are generated or validated; how to generate all the numbers in the set for the type?
    - like, what is a number, exactly? how do you prove, with types, that a value is in the set of all natural numbers?
    - i think the introduction is like a theorem for verifying an input/output value is part of the specified set
    - only then can you apply a higher-level 'type', like 'natural number'
- elimination (primitive recursion)
    - base, step?
- computation
- uniqueness
