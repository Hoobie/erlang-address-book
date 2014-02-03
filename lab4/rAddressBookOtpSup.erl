-module(rAddressBookOtpSup).
-version('1.0').
-behaviour(supervisor).

-export([start_link/1, init/1, start/0]).

start() -> start_link(addressBook:createAddressBook()).

start_link(Book) ->
	supervisor:start_link({local, rAddressBookOtpSup}, ?MODULE, Book).

init(Book) ->
	{ok, {
		{one_for_all, 2, 2000},
		[	{rAddressBookOtp,
			{rAddressBookOtp, start_link, [Book]},
			permanent, brutal_kill, worker, [rAddressBookOtp]}
		]}
	}.