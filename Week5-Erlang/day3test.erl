-module(day3test).
-export([all/0]).
-import(day3,[doctor/0, ask_translation/1]).

setup() -> 
        Dr = spawn(fun day3:doctor/0),
        Dr ! new,
        timer:sleep(1000), 
        Dr.

 %The registered processes are shared across all processes.
 %So, even though erlang is functional, there is still room for race conditions.
 %When the doctor process is spawned, it won't necessarily finish constructing the translator
 %before the following test begins to run.
 %This causes the test to run without translator being registered as a process.
 %This will cause an error.
 
 %This is also why I was able to run the test in the command line without an issue. 
 %I'm too slow to ever win the race with doctor.

all()->
    setup(),
    ShouldBeHouse = "house",
    Translate = "casa",
    ShouldBeHouse = day3:ask_translation(Translate).
    


