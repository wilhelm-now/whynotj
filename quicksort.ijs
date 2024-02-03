quicksort =: monad : 0
if. (#y) < 2 do.
y
elseif. (#y) = 2 do.
<./ y, >./ y NB. append min and max values
else.
pivot_idx =. ? #y
pivot_val =. pivot_idx { y

higher_mask =. pivot_val < y
pivot_mask =. pivot_idx ~: i. #y

higher_values =. (I. pivot_mask *. higher_mask) { y
lower_values =. (I. pivot_mask *. -. higher_mask) { y
NB. append recursed sorted lists
(quicksort lower_values), pivot_val, (quicksort higher_values)
end.
)