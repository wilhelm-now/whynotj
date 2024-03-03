fake_gaussian =: monad : 0
NB. right argument is number of generated numbers
a =. ? y $ 0
b =. ? y $ 0
cos =. 2&o. NB. not loading trig for this
NB. sqrt(-2 * ln a) * cos (2 * pi * b)
(%: _2 * ^. a) * cos (o. 2) * b
)

fake_gaussian_central =: monad : 0
NB. fake gaussian distribution, right argument is number of generated numbers
NB. dyadic for sets number of random numbers to show central limit
12 fake_gaussian_central y
:
samples =. ? (x, y) $ 0
(+/ samples) - x%2
)