load 'trig'

qplus =: +

qminus =: -

qprod =: dyad : 0
NB. extract named components
NB. 0=w, 1=x, 2=y, 3=z
NB. l for left, r for right
'l0 l1 l2 l3' =. x
'r0 r1 r2 r3' =. y
a0 =. (l0*r0) - ((l1*r1) + (l2*r2) + (l3*r3))
a1 =. (l0*r1) + (r0*l1) + ((l2*r3) - (l3*r2))
a2 =. (l0*r2) + (r0*l2) + ((l3*r1) - (l1*r3))
a3 =. (l0*r3) + (r0*l3) + ((l1*r2) - (l2*r1))
a0, a1, a2, a3
)

qreal =: monad : 0
0 { y
)

qimag =: monad : 0
1 2 3 { y
)

qconjugate =: monad : 0
(qreal y), -qimag y
)

qconj =: qconjugate

magsquared =: monad : 0
+/ *: y
)

magnitude =: monad : 0
%: magsquared y
)

qmag =: magnitude

qnormalize =: monad : 0
y % magnitude y
)

qinverse =: monad : 0
(qconjugate y) % magsquared y
)

qinv =: qinverse

qrotv =: dyad : 0
NB. this is the typical sandwich operation to rotate a vector (right argument) by a quaternion (left argument)
q =. x
v =. 0, y
qimag q qprod v qprod qconj q
)

q2rotmat =: monad : 0
NB. equivalent matrix to applying qrotv
'w i j k' =. y
'ww ii jj kk' =. *: y
r0 =. (ww + ii + (-jj) -kk) , (+: (i*j) - k*w) , (+: (i*k) + j*w)
r1 =. (+: (i*j) + k*w) , (ww + (-ii) + jj - kk) , (+: (j*k) - i*w)
r2 =. (+: (i*k) - j*w) , (+: (j*k) + i*w) , (ww + (-ii) + (-jj) + kk)
> r0 ; r1 ; r2
)

q2rotmat2 =: monad : 0
NB. alternate form
NB. stack rotation of each unit vector, transpose  to form matrix
|: > y & qrotv each 1 0 0 ; 0 1 0 ; 0 0 1
)

q2axisangle =: monad : 0
NB. Q = q_real + q_imag = cos(angle/2) + axis*sin(angle/2)
NB. boxed result angle, axis
angle =. 2 * arccos qreal y
axis =. (qimag y) % (sin angle % 2)
angle ; axis
)

qaxisangle2quat =: dyad : 0
NB. left argument axis right argument angle in radians
axis =. qnormalize x
angle =. y
w =. cos -: angle
n =. axis * sin -: angle
w, n
)

qx =: 1 0 0 & qaxisangle2quat
qy =: 0 1 0 & qaxisangle2quat
qz =: 0 0 1 & qaxisangle2quat

deg2rad =: (pi % 180) & *
rad2deg =: deg2rad^:_1
