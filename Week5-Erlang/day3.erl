
% http://learnyousomeerlang.com/errors-and-processes
%Don't drink too much kool-aid:
%You might have heard that Erlang is usually free of race conditions or deadlocks and makes parallel code safe. This is true in many circumstances, but never assume %your code is really that safe. Named processes are only one example of the multiple ways in which parallel code can go wrong.

%Other examples include access to files on the computer (to modify them), updating the same database records from many different processes, etc.




-module(day3).
-export([translate/0, doctor/0, ask_translation/1, superviseDoctor/0, doctorPair/0]).

%part 1
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
    
  
ask_translation(Word) ->
    translator ! {self(), Word},
    receive
        T -> T
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
            exit({doctor, exit, at, erlang:time()});
        {checkIn, From} -> 
            From ! aknowledgement,
            doctor()
    end.

% part2    
superviseDoctor() ->
    process_flag(trap_exit, true),
    receive
        new ->
            io:format("Creating auto-heal doctor. ~n"),
            register(dr, spawn_link(fun doctor/0)),
            superviseDoctor();
        {'EXIT', From, Reason} ->
            io:format("Doctor ~p died with reason ~p ~n Starting another Dr.", [From, Reason]),
            self() ! new,
            superviseDoctor();
        quit ->
            io:format("supervisor died. ~n"),
            exit(qutting)
    end.
    
    
    
    
    

    
    
  
    
    
    
    
    
    
%part 3    
    
    
  
createSingleDoctor() ->
    process_flag(trap_exit, true),
    receive
        {checkIn, From} -> 
            From ! aknowledgement,
            createSingleDoctor();
        {LorR, Partner} ->
            io:format("Registering self as ~p ~n", [LorR]),
            register(LorR, self()),
            link(Partner),
            createSingleDoctor();
        {'EXIT', From, Reason} ->
            io:format("Doctor ~p died w/ ~p ~n.", [From, Reason]),
            LeftDead = whereis(left) == undefined,
            RightDead = whereis(right) == undefined, 
            if 
                LeftDead ->
                    Left = spawn_link(fun createSingleDoctor/0),
                    Left ! {left, self()},
                    io:format("Revived left.~n");
                 RightDead ->
                    Right = spawn_link(fun createSingleDoctor/0),
                    Right ! {right, self()},
                    io:format("Revived right.~n")
            end,
            createSingleDoctor();
        kill -> 
            io:format("Doctor exiting.~n"),
            exit({doctor, exit, at, erlang:time()})
    end.
  
    
doctorPair() ->
    Left = spawn(fun createSingleDoctor/0),
    Right = spawn(fun createSingleDoctor/0),
    timer:sleep(200),
    Left  ! {left, Right},
    Right ! {right, Left}.


            
    
    
    
    
    