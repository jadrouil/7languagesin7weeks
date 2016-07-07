Fib := method(num, if(num <= 2, return 1, return Fib(num - 1) + Fib(num - 2) ))

Fib(1) print
Fib(2) print
Fib(3) print
Fib(4) print

"looping method\n" print

FibLoop := method(num,
  currentNum := 1
  prevNum := 0
  hold := 0
  for(i,2, num,hold = currentNum; currentNum = currentNum + prevNum; prevNum = hold;)
  return currentNum
)

FibLoop(1) print
FibLoop(2) print
FibLoop(3) print
FibLoop(4) print

//changing / to return 0 if denom is zero
"\ndone with fibs\n" print
Number oldDiv := Number getSlot("/")
Number / := method(denominator, if(denominator == 0, return 0,  return (self oldDiv(denominator))))
(4/0) print

//already returns zero?

"\n add numbers in 2d array \n" print
SumArray := method(array,
  sum := 0
  array foreach(index, sublist,
    sublist foreach(index2, value,
        sum = value + sum
    )
  )
  return sum
)

array := list(
  list(3,3,3),
  list(2,2,2),
  list(1,1,1)
);

SumArray(array) print
"\nList averaging \n\n" print

List myAverage := method(
  sum := 0
  count := 0
  foreach(index, value,
    if((value type) == "Number",
      count = count + 1
      sum = sum + value
    , //else
      Exception raise("bad data type in list")
    )
  )
  return (sum/count)
)

b := list(1,2,3,4,5,6,7,8,9,10)
(b myAverage) print

"\nMoving on to prototype two dimension list\n" print

TwoDList := List clone
TwoDList dim := method(x, y,
    if(self proto type == "List", return TwoDList clone dim(x,y))

    self setSize(x)
    for(i,0, x - 1,
      self atPut(i, list() setSize(y))
    )
    return self
)

TwoDList get := method(x,y,
  return(self at(x) at(y))
)

TwoDList set := method(x,y,value,

  return(self at(x) atPut(y, value))
)

mdArray := TwoDList dim(2,2)
mdArray print
mdArray set(0,0,1)
mdArray set(0,1,2)
mdArray set(1,0,3)
mdArray set(1,1,4)
mdArray print
"\ngetting.. \n" print

mdArray get(0,0) print
mdArray get(0,1) print
mdArray get(1,0) print
mdArray get(1,1) print

"\n\n\n" print
