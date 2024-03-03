round =: monad : 0
NB. floor arg + arg modulo 1 greater than equal than 0.5
(<. y) + (1 | y) >: 0.5
)

linspace =: 3 : 0
NB. monadic version returns right-argument evenly spaced numbers from 0-1 inclusive
NB. dyadic version expects two left arguments and evenly spaces numbers from first to second left arg
NB. example (10 20 linspace 3) gives 10 15 20
(%y-1) * i. y
:
'lower upper' =. x
lower + (upper - lower) * linspace y
)