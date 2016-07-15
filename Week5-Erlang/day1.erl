-module(day1).
-export([word_count/1]).
-export([count_down_to_ten/0]).
-export([success_or_error/1]).

word_count(Str) -> Tokens = string:tokens(Str, " "), list_count(Tokens).

list_count([Head|Tail]) -> 1 + list_count(Tail);
list_count([]) -> 0.

count_down_to_ten() -> count_down(10).

count_down(10) -> io:fwrite("10\n"), count_down(9);
count_down(0)-> io:fwrite("0\n");
count_down(N) -> io:fwrite("~w\n",[N]), count_down(N -1).
 

success_or_error(success) -> io:fwrite("success\n");
success_or_error({error, Message}) -> io:fwrite("error: ~s\n", [Message]).
