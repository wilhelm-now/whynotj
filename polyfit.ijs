vandermonde =: dyad : 0

NB. https://en.wikipedia.org/wiki/Vandermonde_matrix
NB. Creates matrix of (LHS arg x) + 1 columns and (RHS arg y) rows
NB. Each row has entries of y-element to the columnth power starting at 0

degree =. x
xs =. y

xs ^/ i. (degree + 1)
)

polyfit =: dyad : 0
NB. Attemps compatibily with polyfit in other packages
NB. usage DEGREE polyfit X_DATA;Y_DATA
NB. returns coefficients in decending order like numpy polyfit
NB. https://numpy.org/doc/stable/reference/generated/numpy.polyfit.html
degree =. x
'xs ys' =. y NB. J has structured bindings!

NB. using normal equations, @ = matrix multiplication
NB. originally A@coeffs = ys with A = vandermonde matrix of xs
NB. and originally number of datapoints makes the equation overdetermined
NB. write AT@A@coeffs = AT@ys to get compatible shapes
NB. then coeffs = (AT@A)_inverse @ AT @ ys

A =. degree vandermonde xs
AT =.|: A NB. transpose

lhs =. AT +/ .* A
rhs =. AT +/ .* ys
coeffs =. (%. lhs) +/ .* rhs NB. inverse lhs times rhs

|. coeffs NB. reverse so that highest power coefficient is first
)

polyeval =: dyad : 0
NB. given a series of coefficients evaluate the polynomial function
NB. lhs = coefficients, rhs = where to evaluate functions at

coeffs =. |. x  NB. mirror/reverse coefficients to go from lowest to highest
degree =. _1 + $ coeffs
xs =. y
powered =. degree vandermonde xs

+/"1 coeffs *"1 powered NB. "1 to apply on correct shape, might not be natural.
)


fitquality =: dyad : 0
NB. USAGE COEFFS fitquality X_DATA;Y_DATA
NB. Returns coefficient of determination https://en.wikipedia.org/wiki/Coefficient_of_determination
NB. Coefficient of determination = R^2 = 1 - sum(errors^2)/sum((y_DATA - Y_AVG)^2)
coeffs =. x
'xs ys' =. y
y_avg =. +/ ys % # y
y_fit =. coeffs polyeval xs
sum_of_squares =. monad : '+/ y^2'
res_sum_squares =. sum_of_squares ys - y_fit
tot_sum_squares =. sum_of_squares ys - y_avg

1 - (res_sum_squares % tot_sum_squares)
)