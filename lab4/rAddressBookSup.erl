-module(rAddressBookSup).
-compile(export_all).

start() -> register(addressBookSupervisor, spawn(rAddressBookSup, init, [])).

init() -> 
	process_flag(trap_exit, true), 
	rAddressBook:start_link(),
	supervise().

supervise() ->
	receive
		{'EXIT', Pid, Reason} ->
			rAddressBook:start_link(),
			supervise()
	end.