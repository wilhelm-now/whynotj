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

convolve =: dyad : 0
NB. left argument weights
NB. right argument data to convolve
NB. only returns valid area of convolution, padding must be done externally
|: +/ (|. x) * |: (#x) ]\ y
)

sg_weights =: monad : 0
NB. Savitzky-Golay filter weights
NB. left argument is order of fit, default = 1
NB. right argument is width of filter and optionally derivative order (default = 0)
1 sg_weights y
: 
'width deriv' =. 2 {. y, 0
vander =. (i: <. -: width) ^/ i. >: x
scale =. */ 1 >. i. >: deriv NB. factorial of derivative power
scale * |. deriv { %. vander NB. reverse to be used in convolution filter
)