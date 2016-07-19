-module(day3test).
-export([all/0]).
-import(day3,[doctor/0, ask_translation/1]).


setup() -> 
        Dr = spawn(fun day3:doctor/0),
        Dr ! new,
        register(dr, Dr),
        timer:sleep(1000).
        
        
 %The registered processes are shared across all processes.
 %So, even though erlang is functional, there is still room for race conditions.
 %When the doctor process is spawned, it won't necessarily finish constructing the translator and registering it
 %before the following test begins to run.
 %This causes the test to run without translator being registered as a process.
 %This will cause an error. 
 %I looked for a cleaner way to ensure that the registration of translator is done, rather than use a sleep but I couldn't find anything in a cursory search.
 %It appears that the call to register is not performed sequentially, this is the root cause for the sleep.
 
 %This is also why I was able to run the test in the command line without an issue. 
 %I'm too slow to ever win the race with doctor.

 teardown()->
        dr ! quit.
        
all()->
    setup(),
    shouldTranslateCasatoHouse(),
    shouldTranslateBlancatoWhite(),
    translatorShouldBeRevivedAfterKilling(),
    teardown().

shouldTranslateCasatoHouse() ->
    ShouldBeHouse = "house",
    Translate = "casa",
    ShouldBeHouse = day3:ask_translation(Translate).
    
shouldTranslateBlancatoWhite() ->
    ShouldBeWhite = "white",
    Translate = "blanca",
    ShouldBeWhite = day3:ask_translation(Translate).
    
translatorShouldBeRevivedAfterKilling() ->
    translator ! muere,
    timer:sleep(200),
    "house" = day3:ask_translation("casa").