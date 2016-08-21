module Day2 where

--simple quicksort
quicksort [] = []
quicksort (h:t) = quicksort(filter (< h) t) ++ [h] ++ quicksort(filter (> h) t)

--custom comparator sort

--customQuicksort [] f = []
--customQuicksort (h:t) f = customQuicksort(filter ( let f h) t) ++ customQuicksort(filter (not let  f h) t)
