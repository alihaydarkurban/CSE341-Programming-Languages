% knowledge base
flight(edirne, erzurum, 5).
flight(erzurum, antalya, 2).
flight(antalya, diyarbakir, 5).
flight(diyarbakir, ankara, 8).
flight(antalya, izmir, 1).
flight(izmir, istanbul, 3).
flight(istanbul, ankara, 2).
flight(istanbul, trabzon, 3).
flight(trabzon, ankara, 6).
flight(ankara, kars, 3).
flight(kars, gaziantep, 3).
flight(ankara, izmir, 6).


% rules
route(START, FINISH, C) :- 
	find_flight(START, FINISH, C, [START]).

best_flight(START, FINISH, C) :- 
	flight(START, FINISH, C);
	flight(FINISH, START, C).

find_flight(START, FINISH, C, TEMP_CITY) :- 
	best_flight(START, FINISH, C),
	not(member(FINISH, TEMP_CITY));

	best_flight(START, TEMP, C1),
	not(member(TEMP, TEMP_CITY)),
	append([TEMP], TEMP_CITY, NEW_TEMP_CITY),
	find_flight(TEMP, FINISH, C2, NEW_TEMP_CITY),
	C is C1 + C2.