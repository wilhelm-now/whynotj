load 'trig'


make_circle_points =: monad define
NB. right arg number of points
NB. left arg radius
1 make_circle_points y
:
theta =. o. 2 * ? y $ 0
x * (cos ,: sin) theta
)

solve_circle =: monad define
NB. returns circle_x, circle_y, radius
b =. |: +/ y^2
'xs ys' =. +: y
A =. xs ,. ys ,. 1

x =. b %. A
'x0 y0 k' =. x
r =. %: k + (*: x0) + *: y0
x0, y0, r
)

