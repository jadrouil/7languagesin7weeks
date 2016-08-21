module Day1 where

--This is the example allEven recursive
allEven :: [Integer] -> [Integer]

allEven [] = []
  
allEven (h:t) = if even h then h:allEven t else allEven t
--End of the example

--List comprehension approach
allEven1 :: [Integer] -> [Integer]

allEven1 (l) = [x  | x <- l, even x]

--the reverse name was already taken
myReverse [] = []

myReverse (h:t) =  reverse t ++ [h]

--Color tuple constructor

colors = ["black", "white", "blue", "yellow", "red"]
colorCombinations = [(x, y) | x <- colors, y <- colors, x < y]

--Multiplication tables
numbers = [1..12]
numberTable = [ (x,y, x*y) | x <- numbers, y <- numbers, x <=y]



