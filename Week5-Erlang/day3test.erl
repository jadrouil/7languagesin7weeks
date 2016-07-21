-module(day3test).
-export([all/0]).
-import(day3,[doctor/0, ask_translation/1, superviseDoctor/0, doctorPair/0]).

all()->
     testRightLeftDoctors(),
     translatorWithDoctorTestSuite(),
     doctorWithSupervisorTestSuite().

%part 1

setupTranslatorWDoctor() -> 
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
    
 

 
 
teardownTranslatorWDoctor()->
        dr ! quit.
    
translatorWithDoctorTestSuite()-> 
    setupTranslatorWDoctor(),
    shouldTranslateCasatoHouse(),
    shouldTranslateBlancatoWhite(),
    translatorShouldBeRevivedAfterKilling(),
    teardownTranslatorWDoctor().
    
    
%part 2    

doctorWithSupervisorTestSuite() ->
    setupDoctorWSupervisor(),
    doctorShouldBeRevivedAfterQutting(),
    teardownDoctorWSupervisor().
    
 
 
 
 
 
doctorShouldBeRevivedAfterQutting() ->
    dr ! quit,
    timer:sleep(1000),
    dr ! {checkIn, self()},
    receive
        T-> T = aknowledgement
    end.

setupDoctorWSupervisor() -> 
    Supe = spawn(fun day3:superviseDoctor/0),
    Supe ! new,
    register(supervisor, Supe),
    timer:sleep(1000).

teardownDoctorWSupervisor() ->
    supervisor ! quit.

%part 3
testRightLeftDoctors() ->
    doctorPair(),
    timer:sleep(200),
    checkDoctorPairCheckIn(),
    checkDoctorPairRevive(),
    left ! terminate.
    
    
checkDoctorPairRevive() ->
    left ! kill,
    timer:sleep(200),
    checkDoctorPairCheckIn(),
    right ! kill,
    timer:sleep(200),
    checkDoctorPairCheckIn().
    
checkDoctorPairCheckIn() ->
    left ! {checkIn, self()},
    receive
        T -> T = aknowledgement
    end,
    right ! {checkIn, self()},
    receive
        R -> R = aknowledgement
    end.
    
 
 
 
 
 
