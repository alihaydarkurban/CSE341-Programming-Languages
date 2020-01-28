/*
	same_room(X, Y) fonksiyonu girilen iki dersin odalari ayni ise true dondurur.
		X ve Y CourseID anlamindadir.
*/

/*
	hour_control(X,Y) fonksiyonu girilen iki dersin saatlari ayni ise true dondurur.
		X ve Y CourseID anlamindadir.
*/

/*
	conflict(X,Y) fonksiyonu girilen iki dersin cakisip cakismadigina bakar.
		Icerinde same_rom ve hour_control fonksiyonlarinin cagirir.
		Cakisma varsa true, yoksa false return eder.
*/

/*
	enroll(X,Y) fonskiyonu bir ogrencinin hcapped' ine gore alabilecegi derslere bakar.
		X StudentID, Y CourseID anlamindadir.
		DERSIN OLDUGU SINIFTAKI HCAPPED DURUMUA GORE ALABILME IHTIMALININ OLDUGU BUTUN DERSLERI YAZDIRIR
		Dersin verildigi sinifta hcapped ozelligi var ise o dersi alabilir.
		Dersin verildigi sinifta hcapped ozelligi yoksa alamaz.
		Mesela benim eklemis oldugum cseyy dersi zyy sinifinda veriliyor fakat zyy sinifinda hcapped ozelligi yok.
		Bu yuzden 6 yani hcapped ozelligi olan ogrenci bu dersi alamaz.
		
*/

/*
	assign(X,Y) fonksiyonu bir dersin gerektirdigi ekipmanlari hangi sinifin icerdigine bakar.
		Mesela bir sinifta projektor yoksa o sinifa projektorun gerektigi bir ders atanamaz.
		Icerisinde equipment_room2 lesson_need fonksiyonlarini kullaniyorum.

*/


/*
	csexxx dersi ve cse341 dersini saatleri cakisicak sekilde z06 sinifinda ayarladim.
	conflict(csexxx, cse341). sorgusunda true verir yani cakisma var anlaminda.
	conflict(csexxx, Y). sorgusunda Y = cse341 verir.
	Saatleri veya siniflari farkli olan iki ders icin ornegin cse341 cse343 ya da 
	cse331 cse321 sorgu yapildiginda false verir.

*/

/*
	cseyyy dersini enroll(X,Y) assign(X,Y) fonksiyonlarinin testleri icin ben ekledim.
	cseyyy dersi zyy sinifinda veriliyor ve zyy sinifinin hcapped ogrenciler icin ozelligi yok.
	Yani hcapped olan ogrenci cseyyyd dersinin alamaz cunku verildigi sinif olan zyy de hcapped ozelligi yok. 

	Ayrica zyy sinifinda projector ozelligi ekledim. Projector gereken dersler zyy sinifinda verilebilir. 
*/

/*
	Your expert system should be able to add a new student, course or a room to the system.
	Kismini yapamadim onun yerine kendim csexxx, cseyyy derslerini zyy sinifini ekledim.
	csexxx cseyyy derslerini bazi ogrencilere verdim.
	Yeni ogrenciyi add_student ile ekliyebiliyorum.
	---> add_student(student_id, course_id, hcappec(yes or no)).
	ile ogrenci derse eklenir
	enroll ile o dersi alip alamayacagi belli olur. Yani o dersin sinifinda hcapped ozelligi var mi yok mu kontrolu yapilinca true ya da false verir.

*/


dyn(student_taking_lessons / 2).
dyn(student_handicapped / 2).


% Dersin oldugu saatler
lesson_hour(cse341, 8).
lesson_hour(cse341, 9).
lesson_hour(cse341, 10).
lesson_hour(cse341, 11).
lesson_hour(cse331, 13).
lesson_hour(cse331, 14).
lesson_hour(cse331, 15).
lesson_hour(cse343, 8).
lesson_hour(cse343, 9).
lesson_hour(cse343, 10).
lesson_hour(cse343, 11).
lesson_hour(cse321, 14).
lesson_hour(cse321, 15).
lesson_hour(cse321, 16).

%%CONFLICT GOSTERMEK ICIN EKLEDIGIM SINIF
lesson_hour(csexxx, 8).
lesson_hour(csexxx, 9).

%%HANDICAPLI OGRENCILERIN GIREMEMESI ICIN EKLEDIGIM SINIF
lesson_hour(cseyyy, 10).
lesson_hour(cseyyy, 11).
lesson_hour(cseyyy, 12).


% Dersin toplam suresi
lesson_total_hour(cse341, 4).
lesson_total_hour(cse331, 3).
lesson_total_hour(cse343, 3).
lesson_total_hour(cse321, 4).

%%%%%%%%%
lesson_total_hour(csexxx, 2).
lesson_total_hour(cseyyy, 3).

% Dersin odalari
lesson_room(cse341, z06).
lesson_room(cse331, z06).
lesson_room(cse343, z11).
lesson_room(cse321, z11).

%%%%%%%%%
lesson_room(csexxx, z06).
lesson_room(cseyyy, zyy).


lesson_room2(z06, cse341).
lesson_room2(z06, cse331).
lesson_room2(z11, cse343).
lesson_room2(z11, cse321).

%%%%%%%%%
lesson_room2(z06, csexxx).
lesson_room2(zyy, cseyyy).


% Hocanin ogrenci kapasitesi
teacher_capacity(genc, 10).
teacher_capacity(turker, 6).
teacher_capacity(bayrakci, 5).
teacher_capacity(gozupek, 10).


% Odanin ekipmanlari
equipment_room(hcapped, z06).	% hcapped' i olan ogrenciler icin 
equipment_room(without_hcapped, z06). % hcapped' i olmayan ogrenciler icin 
equipment_room(hcapped ,z11).	% hcapped' i olan ogrenciler icin 
equipment_room(without_hcapped, z11).	% hcapped' i olmayan ogrenciler icin 
equipment_room(without_hcapped, zyy).	% hcapped' i olmayan ogrenciler icin 


equipment_room2(z06, projector).
equipment_room2(z11, smartboard).
% zyy sinifina projector ekledim. smartboard gerektiren dersler bu zyy sinina atanamaz
equipment_room2(zyy, projector).


% Odanin kapasitesi
room_capacity(z06, 10).
room_capacity(z11, 10).
room_capacity(zyy, 10).


% Dersin ekipmanlari
lesson_need(cse341, projector).
lesson_need(cse343, smartboard).
lesson_need(cse331, _).
lesson_need(cse321, smartboard).
lesson_need(csexxx, _).


% Dersi veren hocalar
lesson_teacher(cse341, genc).
lesson_teacher(cse343, turker).
lesson_teacher(cse331, bayrakci).
lesson_teacher(cse321, gozupek).
lesson_teacher(csexxx, xxx).
lesson_teacher(cseyyy, yyy).


% Ogrencilerin aldigi dersler
student_taking_lessons(1, cse341).
student_taking_lessons(1, cse343).
student_taking_lessons(1, cse331).
student_taking_lessons(1, csexxx).	 % Bu dersi alabilir cunku bu dersin sinifinda hcapped ozelligi var 
student_taking_lessons(1, cseyyy).	 % Bu dersi alabilir cunku bu dersin sinifinda hcapped ozelligi yok ama ogrencinin hcapped i yok
student_taking_lessons(2, cse341).
student_taking_lessons(2, cse343).
student_taking_lessons(2, csexxx).	% Bu dersi alabilir cunku bu dersin sinifinda hcapped ozelligi var 
student_taking_lessons(2, cseyyy).	% Bu dersi alabilir cunku bu dersin sinifinda hcapped ozelligi yok ama ogrencinin hcapped i yok
student_taking_lessons(3, cse341).
student_taking_lessons(3, cse343).
student_taking_lessons(4, cse341).
student_taking_lessons(5, cse343).
student_taking_lessons(5, cse331).
student_taking_lessons(6, cse341).
student_taking_lessons(6, cse343).
student_taking_lessons(6, cse331).
student_taking_lessons(6, csexxx).	% Bu dersi alabilir cunku bu dersin sinifinda hcapped ozelligi var 
student_taking_lessons(6, cseyyy). % Bu dersi alamaz cunku dersin sinifinda hcapped ozelligi yok ama ogrencinin hcapped i var
student_taking_lessons(7, cse341).
student_taking_lessons(7, cse343).
student_taking_lessons(8, cse341).
student_taking_lessons(8, cse331).
student_taking_lessons(9, cse341).
student_taking_lessons(10, cse341).
student_taking_lessons(10, cse321).
student_taking_lessons(11, cse341).
student_taking_lessons(11, cse321).
student_taking_lessons(12, cse341).
student_taking_lessons(12, cse321).
student_taking_lessons(13, cse341).
student_taking_lessons(13, cse321).
student_taking_lessons(14, cse341).
student_taking_lessons(14, cse321).
student_taking_lessons(15, cse341).
student_taking_lessons(15, cse321).
student_taking_lessons(15, csexxx).	% Bu dersi alabilir cunku bu dersin sinifinda hcapped ozelligi var 
student_taking_lessons(15, cseyyy).  % Bu dersi alamaz cunku dersin sinifinda hcapped ozelligi yok ama ogrencinin hcapped i var


% Ogrencilerin ozel durumlari
student_handicapped(1, no).
student_handicapped(2, no).
student_handicapped(3, no).
student_handicapped(4, no).
student_handicapped(5, no).
student_handicapped(6, yes).
student_handicapped(7, no).
student_handicapped(8, yes).
student_handicapped(9, no).
student_handicapped(10, no).
student_handicapped(11, no).
student_handicapped(12, no).
student_handicapped(13, no).
student_handicapped(14, no).
student_handicapped(15, yes).

yes_to_hcapped(yes, hcapped). %student_handicapped yes dondurucek onu hcapped e cevirdim.
yes_to_hcapped(no, without_hcapped).	%student_handicapped no dondurucek onu without_hcapped e cevirdim.


% StudentID, CourseID, HCAPPED
add_student(X,Y,Z) :-
	Adding1 = student_taking_lessons(X,Y),
	Adding2 = student_handicapped(X,Z),
	asserta(Adding1),
	asserta(Adding2).

% ROOMID, CourseID, EQUIPMENT

/*add_lesson(ROOM, X, Y) :-
	Adding3= lesson_room(ROOM, X),
	Adding4= lesson_room2(X, ROOM),
	Adding5= equipment_room(Y, ROOM),
	Adding6= equipment_room2(ROOM, Y),
	asserta(Adding3),
	asserta(Adding4),
	asserta(Adding5),
	asserta(Adding6).

*/

% Odalarin ayni olma fonksiyonu
same_room(X, Y) :-
	lesson_room(X, ROOM1),
	lesson_room(Y, ROOM2),
	ROOM1 == ROOM2.

% Ders saatlerinin ayni olmasi
hour_control(X,Y) :-
	lesson_hour(X,HOUR1),
	lesson_hour(Y,HOUR2),
	HOUR1 == HOUR2.


% true donmesi durumunda zaman cakismasi anlami vardir
% Ayni odada ayni anda farkli ders verilir mi onun 
conflict(X,Y) :-
	same_room(X,Y),
	hour_control(X,Y),
    !.	

% true donmesi o dersi alabilcegi anlamina gelir
enroll(X,Y) :-
	student_handicapped(X, YES_NO),
	yes_to_hcapped(YES_NO, HCAPPED),
	equipment_room(HCAPPED, ROOM),
	lesson_room2(ROOM, Y).

% true donmesi durumunda o sinifta o ders verilebilir anlamina gelir
assign(X,Y) :-
	equipment_room2(X, EQUIPMENT),
	lesson_need(Y, EQUIPMENT).