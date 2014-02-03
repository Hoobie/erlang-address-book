-module(rAddressBookOtp).
-behaviour(gen_server).
-version('1.0').

-export([start/0, stop/0, start_link/1, init/1, handle_call/3, handle_cast/2, terminate/2]).

-export([addContact/2, addEmail/3, findByEmail/1]).

start() -> start_link(addressBook:createAddressBook()).

start_link(Book) -> 
	gen_server:start_link(
		{local, rAddressBookOtp},
		rAddressBookOtp,
		Book, []).

init(Book) -> 
	{ok, Book}.

%% user interface
stop() ->
	gen_server:cast(rAddressBookOtp, stop).

addContact(FirstName, LastName) ->
	gen_server:call(rAddressBookOtp, {addContact, FirstName, LastName}).

addEmail(FirstName, LastName, Email) ->
	gen_server:call(rAddressBookOtp, {addEmail, FirstName, LastName, Email}).

findByEmail(Email) ->
	gen_server:call(rAddressBookOtp, {findByEmail, Email}).

%% callbacks
handle_cast(stop, Book) ->
	{stop, normal, Book}.

terminate(Reason, Value) ->
	io:format("exit with value ~p~n", [Value]), Reason.

handle_call({addContact, FirstName, LastName}, _From, Book) ->
	{reply, ok, addressBook:addContact(Book, FirstName, LastName)};

handle_call({addEmail, FirstName, LastName, Email}, _From, Book) ->
	{reply, ok, addressBook:addEmail(Book, FirstName, LastName, Email)};

handle_call({findByEmail, Email}, _From, Book) ->
	Value = addressBook:findByEmail(Book, Email),
	{reply, Value, Value}.