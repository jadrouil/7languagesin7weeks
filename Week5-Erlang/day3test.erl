-module(day3test).
-export([all/0]).
-import(day3,[doctor/0, ask_translation/1]).

all()->
    Dr = spawn(fun day3:doctor/0),
    Dr ! new,
    ShouldBeHome = "home",
    registered(),
    ShouldBeHome = day3:ask_translation("casa").
%For whatever reason running the above steps from the command line isn't an issue.
%However, here ask_translation fails with bad argument. I think the reason for this is
% the translator atomic isn't recognized across files.
% the call to registered() shows that translator is not registered.
%will fix tomorrow.
