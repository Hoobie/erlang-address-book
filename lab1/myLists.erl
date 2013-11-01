-module(myLists).
-export([contains/2, duplicateElements/1, sumFloats/1]).

contains([], _) ->
	false;
contains([Element|_], Element) ->
	true;
contains([_|T], Element) ->
	contains(T, Element).

duplicateElements(List) ->
	lists:flatmap(fun(X) -> [X,X] end, List).

sumFloats(List)->
	sumFloats2(List, 0).

sumFloats2([H|T], Acc) when is_float(H) ->
	sumFloats2(T, Acc + H);
sumFloats2([_|T], Acc) ->
	sumFloats2(T, Acc);
sumFloats2(_, Acc) ->
	Acc.
