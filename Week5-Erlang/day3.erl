-module(day3).
-export([translate/0, doctor/0, ask_translation/1]).

translate() -> 
    receive
        {From, "casa"} ->
            From ! "house",
            translate();
        
        {From, "blanca"} ->
            From ! "white",
            translate();
            
        muere -> %translates to imperative die command
            io:format("Adios Amigo ~n"),
            exit({translate, die, at ,erlang:time()});
        {From, _} ->
            From ! "I don't understand",
            translate()
            
    end.
    

doctor() ->
    process_flag(trap_exit, true),
    receive 
        new ->
            io:format("Creating and monitoring process.~n"),
            register(translator, spawn_link(fun translate/0)),
            doctor();
        {'EXIT', From, Reason} -> 
            io:format("The process ~p died with reason ~p ~n Starting another one.", [From, Reason]),
            self() ! new,
            doctor();
        quit -> 
            io:format("Doctor exiting.~n"),
            exit({doctor, exit, at, erlang:time()})
    end.

ask_translation(Word) ->
    translator ! {self(), Word},
    receive
        T -> T
    end.