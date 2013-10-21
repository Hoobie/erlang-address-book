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
    lists:foldl(fun(X,Y) -> X+Y end, 0, lists:filter(fun(X) -> is_float(X) end, List)).
    
