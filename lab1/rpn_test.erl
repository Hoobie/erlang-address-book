-module(rpn_test).
-include_lib("eunit/include/eunit.hrl").
-compile(export_all).

rpn_test() ->
	% 1 + 2 * 3 - 4 / 5 + 6
	12.2 = rpn:rpn("1 2 3 * + 4 5 / - 6 +"),
	% 1 + 2 + 3 + 4 + 5 + 6 * 7 
	57 = rpn:rpn("1 2 + 3 + 4 + 5 + 6 7 * +"),
	% ( (4 + 7) / 3 ) * (2 - 19)
	-62.33333333333333 = rpn:rpn("4 7 + 3 / 2 19 - *"),
	% 17 * (31 + 4) / ( (26 - 15) * 2 - 22 ) - 1
	% division by zero
	?assertException(error, badarith, rpn:rpn("17 31 4 + * 26 15 - 2 * 22 - / 1 -")),
	25.0 = rpn:rpn("5 2 ^"),
	2.0 = rpn:rpn("4 sqrt"),
	0.0 = rpn:rpn("0 sin"),
	1.0 = rpn:rpn("0 cos"),
	0.0 = rpn:rpn("0 tan"),
	ok.