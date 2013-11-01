-module(rpn).
-export([rpn/1]).


rpn(Exp) ->
	read(string:tokens(Exp, " "), 0).


read(["+"|T1], [H1,H2|T2]) ->
	read(T1, [H1+H2,T2]);

read(["-"|T1], [H1,H2|T2]) ->
	read(T1, [H2-H1|T2]);

read(["*"|T1], [H1,H2|T2]) ->
	read(T1, [H1*H2|T2]);

read(["/"|T1], [H1,H2|T2]) ->
	read(T1, [H2/H1|T2]);

read(["^"|T1], [H1,H2|T2]) ->
	read(T1, [math:pow(H2,H1),T2]);	  

read(["sqrt"|T1], [H|T2]) ->
	read(T1, [math:sqrt(H),T2]);

read(["sin"|T1], [H|T2]) ->
	read(T1, [math:sin(H),T2]);

read(["cos"|T1], [H|T2]) ->
	read(T1, [math:cos(H),T2]);	

read(["tan"|T1], [H|T2]) ->
	read(T1, [math:tan(H),T2]);		

read([H|T], Acc) ->
	case string:to_float(H) of
		{error,no_float} -> read(T, [list_to_integer(H)|Acc]);
		{F,_} -> read(T, [F|Acc])
	end;

read([], [Acc|_]) ->
	Acc.