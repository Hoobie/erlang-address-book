-module(pFactorial).
-compile(export_all).

factorial(0) -> 1;
factorial(N) -> factorial(N-1) * N.

get_factorial(N) ->
        spawn(?MODULE, concurrent_factorial, [N, self()]),
        receive
                X -> X
        end.

get_factorial_list(List, Pid) ->
        Pid ! [factorial(N) || N <- List].

concurrent_factorial(N) ->
        Processors = erlang:system_info(logical_processors_available),
        L = lists:seq(1, N),
        ListsToGet = [lists:filter(fun(X) -> X rem Processors == C end, L) || C <- lists:seq(0, Processors-1)],
        Listener = spawn(?MODULE, listener, [Processors, self(), []]),
        [spawn(?MODULE, get_factorial_list, [L2, Listener]) || L2 <- ListsToGet],
        receive
                List -> lists:sort(List)
        end.

listener(0, Pid, List) ->
        Pid ! List;
listener(N, Pid, Lists) ->
        receive
                L -> L
        end,
        listener(N-1, Pid, Lists ++ L).

sequential(N) ->
        [factorial(X) || X <- lists:seq(0, N)].

stupid_concurrent(N) ->
        [get_factorial(X) || X <- lists:seq(0, N)].
