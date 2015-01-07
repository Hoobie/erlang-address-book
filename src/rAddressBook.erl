-module(rAddressBook).
-compile(export_all).

start() -> register(addressBookServer, spawn(rAddressBook, init, [])).

init() -> loop(addressBook:createAddressBook()).

start_link() -> 
	Pid = spawn_link(fun init/0),
	register(addressBookServer, Pid).

%% main server loop
loop(Book) ->
	receive
		{request, Pid, addContact, {FirstName, LastName}} ->
			Pid ! {reply, ok},
			loop(addressBook:addContact(Book, FirstName, LastName));
		{request, Pid, addEmail, {FirstName, LastName, Email}} ->
			Pid ! {reply, ok},
			loop(addressBook:addEmail(Book, FirstName, LastName, Email));
		{request, Pid, findByEmail, Email} ->
			Contact = addressBook:findByEmail(Book, Email),
			Pid ! {reply, Contact},
			loop(Book);
		{request, Pid, book, _} ->
			Pid ! {reply, Book},
			loop(Book);
		{request, Pid, crash, _} ->
			Pid ! {reply, crash},
			1 / 0	
	end.

%% client
call(Function, Params) ->
	addressBookServer ! {request, self(), Function, Params},
	receive
		{reply, Reply} -> Reply
	end.

book() -> call(book , []).

crash() -> call(crash, []).

addContact(FirstName, LastName) -> call(addContact, {FirstName, LastName}).

addEmail(FirstName, LastName, Email) -> call(addEmail, {FirstName, LastName, Email}).

findByEmail(Email) -> call(findByEmail, Email).