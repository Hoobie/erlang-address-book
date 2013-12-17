-module(pingpong).
-compile(export_all).

start() ->
	register(pingRef, spawn(?MODULE, ping, [])),
	io:format("pingRef registered ~n", []),
	register(pongRef, spawn(?MODULE, pong, [])),
	io:format("pongRef registered ~n", []).

ping() ->
	receive
		0 -> ok;
		N ->
			io:format("ping got ~p ~n", [N]),
			timer:sleep(1000),
			pongRef ! N - 1,
			io:format("ping sent ~p ~n", [N-1])

		after 20000 ->
			stop()
	end,
	ping().

pong() ->
	receive
		0 -> ok;
		N ->
			io:format("pong got ~p ~n", [N]),
			timer:sleep(1000),
			pingRef ! N - 1,
			io:format("pong sent ~p ~n", [N-1])
		
		after 20000 ->
			stop()
	end,
	pong().

stop() ->
	io:format("stopping ~n", []),
	exit(whereis(ping)),
	exit(whereis(pong)).

play(N) ->
	pingRef ! N.