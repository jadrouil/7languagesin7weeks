-module(day2).
-export([retrieve_value/2]).
-export([compute_total_prices/1]).
-export([tic_tac_toe_check/1]).

%if the key is not found the function fails.
%if the list doesn't have tuples of size 2 it will fail.
%if there is more than one entry for a Key it will fail.
%Is this what letting it fail means?  

retrieve_value(List, Key) ->[{Key,Value}] =  lists:filter(fun(X) ->{CompKey, _} = X, CompKey == Key end, List), 
			    Value.

compute_total_prices(Cart) -> [{Item, Quantity*Price} || {Item, Quantity, Price} <- Cart].

%T = Top, L = Left, M = Middle, R= Right, B = Bottom
   

rowsColsDiags([TL, TM, TR,
	       ML, MM, MR,
	       BL, BM, BR]) -> [[TL,TM,TR], [ML, MM, MR], [BL, BM, BR], 
				[TL,ML,BL], [TM, MM, BM], [TR, MR, BR],
				[TL, MM, BR], [TR, MM, BL]].


examineRCDs([H | T]) -> case H of 
			[x,x,x] -> x;
			[o,o,o] -> o;
			_ ->examineRCDs(T)
		     end;
examineRCDs([]) -> noWinner.


determineState(OrganizedBoard, EmptySpots)-> WinningState = examineRCDs(OrganizedBoard), 
					     case [WinningState, EmptySpots] of
						[noWinner, true] -> no_winner;
						[noWinner, false] -> cat;
						[X, _] -> X 
					     end.
						

tic_tac_toe_check(Board) -> EmptySpots = lists:any(fun(X) -> X == empty end, Board),   
			    determineState(rowsColsDiags(Board), EmptySpots). 


