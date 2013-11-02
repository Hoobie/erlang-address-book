-module(addressBook).
-compile(export_all).

-record(address, {name, surname, mobile, email}).

createAddressBook() ->
	[].

addContact(AddressBook, Name, Surname) -> 
	addContact2(AddressBook, Name, Surname, []).

addEmail(AddressBook, Name, Surname, Email) -> 
	addEmail2(AddressBook, Name, Surname, Email, []).


%% Helpers

addContact2([H|T], Name, Surname, Acc) ->
	case H of
		#address{name=Name, surname=Surname} -> 
			already_exists;
		_ -> 
			addContact2(T, Name, Surname, [H|Acc])
	end;
addContact2([], Name, Surname, Acc) ->
	[#address{name=Name, surname=Surname}|Acc].  

addEmail2([H|T], Name, Surname, Email, Acc) ->
	case H of
		#address{name=Name, surname=Surname, email=Email} -> 
			already_exists;
		#address{email=Email} -> 
			already_exists;
		#address{name=Name, surname=Surname} -> 
			addEmail2(T, Name, Surname, Email, Acc);
		_ -> 
			addEmail2(T, Name, Surname, Email, [H|Acc])
	end;
addEmail2([], Name, Surname, Email, Acc) ->
	[#address{name=Name, surname=Surname, email=Email}|Acc].  