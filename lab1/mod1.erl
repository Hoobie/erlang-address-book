-module(mod1).
-export([power/2]).

power(X, Base) -> power2(X, Base, X).

%%
power2(_, 0, _) -> 1;
power2(_, 1, Acc) -> Acc;
power2(X, Base, Acc) -> power2(X, Base-1, Acc*X).