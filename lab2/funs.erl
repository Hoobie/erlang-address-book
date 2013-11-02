-module(funs).
-compile(export_all).

map(Fun, [H|T]) -> [Fun(H)|map(Fun, T)];
map(_, []) -> [].

filter(Fun, List) -> lists:reverse(filter(Fun, List, [])).
 
filter(Fun, [H|T], Acc) ->
	case Fun(H) of
		true  -> filter(Fun, T, [H|Acc]);
		false -> filter(Fun, T, Acc)
	end;
filter(_, [], Acc) -> Acc.

% map with lists comprehensions
map2(Fun, List) ->
	[Fun(X) || X <- List].

% filter with lists comprehensions
filter2(Fun, List) ->
	[X || X <- List, Fun(X)].

% generates list with 1.000.000 random elements from 1 to 2.000.000
generate() ->
	[random:uniform(2000000) || _ <- lists:seq(1, 1000000)].

% filters random numbers divisable by 3 and 13
rems() ->
	List = generate(),
	Fun = fun(X) -> X rem 3 == 0 andalso X rem 13 == 0 end,
	%lists:filter(Fun, List),
	filter2(Fun, List).

% counts sum of digits
sum_digits(N) ->
	lists:foldl(fun(X, Acc) -> list_to_integer([X]) + Acc end, 0, integer_to_list(N)).

% filters random numbers with sum of digits divisable by 3 
sum_rems() ->
	List = generate(),
	Fun = fun(X) -> sum_digits(X) rem 3 == 0 end,
	lists:filter(Fun, List).