-module(qsort).
-export([qs/1, generate/0, compare/0]).

qs([Pivot|Tail]) -> 
	qs([X || X <- Tail, X < Pivot]) ++ [Pivot] ++ qs([X || X <- Tail, X >= Pivot]);
qs(X) ->
	X.

generate() ->
	[random:uniform(2000) || _ <- lists:seq(1, 1000)].

compare() ->
	List = generate(),
	{T1, _} = timer:tc(qsort, qs, [List]),
	{T2, _} = timer:tc(lists, sort, [List]),
	io:format("qsort:qs => ~p[ms]~nlists:sort => ~p[ms]~n", [T1, T2]).