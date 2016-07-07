/*
This rule states that the factorial of 0 is 1.
*/
factorial(0,Fact):- Fact is 1.

/*
These rules state:
1. X must be greater than 0.
2. Y is 1 less than X.
3. Y! must equal SubFact.
4. Fact is SubFact * X.
*/
factorial(X, Fact) :- X > 0, Y is X - 1,  factorial(Y, SubFact), Fact is SubFact * X.

/*
These rules are fairly trivial
1) An empty list reversed is itself.
2) A single element list is also itself reversed.
3)A two element list reversed is just the same list with the two elements swapped.
*/
reversed([], L2) :- L2 = [].
reversed([X], [X]).
reversed([X,Y], [Y,X]).

/*This rule is the moneymaker.
The first term unifies Len to the Length of L1.
The second term  asserts that L2 and L1 are the same length.
The third term dictates Length must be greater than 2. This step is important. Otherwise, we would be applying these rules to trivial/base cases.
The four term L1 = [Head|Tail] simply unifies the first element of L1 to Head.
The append statement unifies RemainingL2 to the rest of L2 if Head is the last element in L2. Otherwise the rule is broken.
The last statement says the remianing list must be reversals of one another.
*/
reversed(L1, L2):-
  length(L1, Len), length(L2, Len), Len > 2, L1 = [Head|Tail],  append(RemainingL2,[Head],L2), reversed(Tail, RemainingL2).


  /* Finding the smallest element*/

/*
findSmallest is a helper rule. I wrote it so I could figure out how to exactly select the smallest number of two values in prolog.
It is not enough to say Result =< X, Result =< Y. This will result in an improperly instantiated error.
Thinking through the statement though, Result could be any value less than X and Y. This rule isn't strict enough.
Therefore the Result is X if X is the smallest and Y otherwise.
*/
findSmallest(X,Y,Result) :- (X =< Y, Result is X); (Y < X, Result is Y).
/*This is the simple rule. The smallest number in a single element list is the sole entry.*/
smallest([X], Smallest) :- number(X), Smallest is X.
/*This rule is for non trivial cases.
We first unify Head to the first value in the list.
For sake of simplicity, I enforce a rule that every element must be a number.
Then the SmallestFromLeftovers is unified from the rest of the List.
Finally, we select the smallest value from the head and leftovers.
*/
smallest(List, Smallest):-
  [Head|Tail] = List, number(Head), smallest(Tail, SmallestFromLeftovers), findSmallest(Head,SmallestFromLeftovers, Smallest).


/*Sorting a list */
mysort([], []).
/* Basecase ^*/

/*
These rules can be summarized as:
The Sorted list will have the minimum value at the front and the rest of the list will be sorted.
*/
mysort(List, Sorted):-
  min_list(List, Min),
  select(Min, List, Remainder),
  mysort(Remainder, SubSort),
  append([Min], SubSort, Sorted).
