"Do:\n\n" print
(1 + 1) print
//io is strongly typed.
//different types are not easily smooshed together
//("one" + 1) print

("one" type) print
"\n" print
(1 type) print

if(0, "0 is true\n" print, "0 is false\n" print)

if("", "empty str is true\n" print, "empty str is false\n" print)

if(nil, "nil is true\n" print, "nil is false\n" print)

//to figure out what slots are supported:
//(1 slotNames) print
N := 1 clone
//(Object slotNames) print

// = updates a slot
// := sets a slot
// ::= creates a new slot


N test_method := method("this is a method in N\n" print)

N test_method






"\n\n" print
