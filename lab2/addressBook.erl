-module(addressBook).
-compile(export_all).
-record(address, {name, phone=[], email=[]}).

createAddressBook() ->
	[].

addContact(AddressBook, FirstName, LastName) -> case getContact(AddressBook, FirstName, LastName) of
		false -> [#address{name=concatName(FirstName, LastName)}|AddressBook];
		_ -> {error, "Contact already exits."} end.

addEmail(AddressBook, FirstName, LastName, Email) -> case emailExists(AddressBook, Email) of
		true -> {error, "Contact already exits."};
		false -> case getContact(AddressBook, FirstName, LastName) of
				false -> [#address{name=concatName(FirstName, LastName), email=Email}|AddressBook];
				A -> A2 = A#address{email=[Email|A#address.email]}, lists:keyreplace(concatName(FirstName, LastName), #address.name, AddressBook, A2) end
	end.

addPhone(AddressBook, FirstName, LastName, Phone) -> case phoneExists(AddressBook, Phone) of
		true -> {error, "Contact already exits."};
		false -> case getContact(AddressBook, FirstName, LastName) of
				false -> [#address{name=concatName(FirstName, LastName), phone=Phone}|AddressBook];
				A -> A2 = A#address{phone=[Phone|A#address.phone]}, lists:keyreplace(concatName(FirstName, LastName), #address.name, AddressBook, A2) end
	end.

removeContact(AddressBook, FirstName, LastName) -> lists:keydelete(concatName(FirstName, LastName), #address.name, AddressBook).
removeEmail(AddressBook, Email) -> case lists:filter(fun(#address{email=E}) -> lists:member(Email, E) end, AddressBook) of
		[A] -> A2 = A#address{email=lists:delete(Email, A#address.email)}, lists:keyreplace(A#address.name, #address.name, AddressBook, A2); 
		_ -> {error, "Can not remove."}
	end.
removePhone(AddressBook, Phone) -> case lists:filter(fun(#address{phone=P}) -> lists:member(Phone, P) end, AddressBook) of
		[A] -> A2 = A#address{phone=lists:delete(Phone, A#address.phone)}, lists:keyreplace(A#address.name, #address.name, AddressBook, A2); 
		_ -> {error, "Can not remove."}
	end.
getEmails(AddressBook, FirstName, LastName) -> A = getContact(AddressBook, FirstName, LastName), A#address.email.
getPhones(AddressBook, FirstName, LastName) -> A = getContact(AddressBook, FirstName, LastName), A#address.phone.
findByEmail(AddressBook, Email) -> case lists:filter(fun(#address{email=E}) -> lists:member(Email, E) end, AddressBook) of
		[A] -> A#address.name;
		_ -> {error, "Not found."}
	end.	
findByPhone(AddressBook, Phone) -> case lists:filter(fun(#address{phone=P}) -> lists:member(Phone, P) end, AddressBook) of
		[A] -> A#address.name;
		_ -> {error, "Not found."}
	end.	

concatName(FirstName, LastName) -> string:join([FirstName, LastName], " ").
getContact(AddressBook, FirstName, LastName) -> lists:keyfind(concatName(FirstName, LastName), #address.name, AddressBook).
emailExists(AddressBook, Email) -> lists:any(fun(#address{email=E}) -> lists:member(Email, E) end, AddressBook).
phoneExists(AddressBook, Phone) -> lists:any(fun(#address{phone=P}) -> lists:member(Phone, P) end, AddressBook).