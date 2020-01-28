
;; ** operatorunu yapamadim
;; - sayilari yapamadim

(setq temp_result '())	;Gecici liste parca parca ifadeleri birlestirmek icin
(setq my_liste '())		;Dosyadan okudugum karakterleri attigim listem
(setq word_liste '())	;Kelimeleri attigim liste		
(setq number_liste '())	;Sayilari attigim liste
(setq result '()) ;Sonucu attigim liste
(setq output_list '()) ;result listesini reverse edip ekrana bastirdigim liste
(setq letter_flag 0) ;Harfler icin kontrol degiskeni	
(setq number_flag 0) ;Sayilar icin kontrol degiskeni

(defun lexer(file_name)	;Dosyadan okuma ve parcalama fonksiyonu
	;;Asagida karakter karakter okuma islemi
	(with-open-file (stream file_name)
		(do ((char (read-char stream nil)	
			(read-char stream nil)))
			((null char))
			(push char my_liste) ;Karakteri listeye atma
			
			;;Sayi kontrolu
			(if (and (is_number(car my_liste)) (= letter_flag 0)) ;Listemdeki ilk eleman rakam ve hic harf yoksa sayidir	
				(setq number_flag (+ number_flag 1) ) ;Sayi icin kontrol degiskenini arttirma
			)

			(cond ;Sayi disinda karakter gelemedigi surece sayidir ve sayi atamasi yapilir
				((and (>= number_flag 1) (is_number (car my_liste))) (push (string (car my_liste)) number_liste)) ;Daha once rakam gelmisse ve listede yine rakam vara number_list e string seklinde atama
				((and (>= number_flag 1) (equal (is_number (car my_liste)) nil) ) ;Daha once rakam gelmis ve yeni gelen rakam degilse artik sayi olmus olur 
					(setq number_flag 0) ;Kontrolu 0 yapma	
					;;Push yaptigim icin listeyi ters cevirmem lazim concatString ile stringleri birlestirdim 
					(push (concatString  (setq number_liste_r (reverse number_liste)) ) temp_result)	
					(push "integer" temp_result) ;temp_result a intiger ekleme
					(push temp_result result) ;result a temp_result i ekleme	
					;;Listeleri bosaltma
					(setq temp_result '())	
					(setq number_liste '())	
					(setq number_liste_r '())
				)
			)

			;;Kelime kontrolu
			(if (equal (is_letter(car my_liste)) t) ;Listemdeki ilk eleman rakam ve hic harf yoksa sayidir	
				(setq letter_flag (+ letter_flag 1) ) ;Harf icin kontrol degiskenini arttirma
			)

			(cond ;Harf disinda karakter gelemdigi surece kelime olur ve keyword mu degil mi kontrolu yapilip karar verilir
				((and (>= letter_flag 1) (is_letter(car my_liste))) (push (string (car my_liste)) word_liste)) ;Daha once rakam gelmisse ve listede yine rakam vara number_list e string seklinde atama
				((and (>= letter_flag 1) (equal (is_letter(car my_liste)) nil))	;Daha once harf gelmis ve yeni gelen harf degilse artik kelime olmus olur 
					(setq letter_flag 0)	;Kontrolu 0 yapma
					;;Push yaptigim icin listeyi ters cevirmem lazim concatString ile stringleri birlestirdim 
					(push (concatString (setq word_liste_r (reverse word_liste)) ) temp_result)	
					
					(if (equal (is_keyword (concatString  ( setq word_liste_r (reverse word_liste)))) t) ;is_keyword fonksiyonuna yollanir
						(push "keyword" temp_result) ;Keyword ise  keyword eklenir
						(push "identifier" temp_result)	;Keyword degilse identifier dir
					)
					(push temp_result result) ;result a temp result u ekleme
					;;Listeleri bosaltma
					(setq temp_result '())	
					(setq word_liste '())	
					(setq word_liste_r '())
				)
			)

			;;Operator kontrolu
			(cond
				((equal (is_operator(car my_liste)) t)	;Operator olma durumu
				(push (string (car my_liste)) temp_result)	;Karakeri stringe cevirip temp_result a atma
				(push "operator" temp_result)	;operator eklenir
				(push temp_result result)	;result a temp result eklenir
				(setq temp_result '())	;Listeyi bosaltma
				)
			)
		)	
	)
	(setq output_list (reverse result))	;result listesi ters cevirme
)

;;Keywordlerin tanimli oldugu fonksiyon. Eger herhangi bir keyword olursa t olmazsa nil dondurur
(defun is_keyword(key_list)
	(if (or 
		(equal key_list "and")
		(equal key_list "or")
		(equal key_list "not")
		(equal key_list "equal")
		(equal key_list "append")
		(equal key_list "concat")
		(equal key_list "set")
		(equal key_list "deffun")
		(equal key_list "for")
		(equal key_list "while")
		(equal key_list "if")
		(equal key_list "exit") )
		t
		nil
	)
)

;;Operatorlerin tanimli oldugu fonksiyon. Eger herhangi bir operator olursa t olmazsa nil dondurur
(defun is_operator(op_list)
	(if (or
		(equal op_list #\+)
		(equal op_list #\-)
		(equal op_list #\/)
		(equal op_list #\*)
		(equal op_list #\()
		(equal op_list #\))
		;(equal op_list "**") ** kontrolunu yapamadım
		)
		t
		nil
	)
)

;;Bu fonksiyon buyuk harf kontrolu yapar. Eger herhangi bir buyuk harf olursa t olmazsa nil dondurur 
(defun is_upper(ch)
	(if (or 
		(equal ch #\A)
	    (equal ch #\B)
	    (equal ch #\C)
	    (equal ch #\D)
	    (equal ch #\E)
	    (equal ch #\F)
	    (equal ch #\G)
	    (equal ch #\H)
	    (equal ch #\I)
	    (equal ch #\J)
	    (equal ch #\K)
	    (equal ch #\L)
	    (equal ch #\M)
	    (equal ch #\N)
	    (equal ch #\O)
	    (equal ch #\P)
	    (equal ch #\R)
	    (equal ch #\S)
	    (equal ch #\T)
	    (equal ch #\U)
	    (equal ch #\V)
	    (equal ch #\W)
	    (equal ch #\Y)
	    (equal ch #\Z)
	    (equal ch #\X)
	    (equal ch #\Q)
	    )	
		t
		nil
	)
)

;;Bu fonksiyon kucuk harf kontrolu yapar. Eger herhangi bir kucuk harf olursa t olmazsa nil dondurur 
(defun is_lower(ch)
	(if (or 
		(equal ch #\a)
	    (equal ch #\b)
	    (equal ch #\c)
	    (equal ch #\d)
	    (equal ch #\e)
	    (equal ch #\f)
	    (equal ch #\g)
	    (equal ch #\h)
	    (equal ch #\i)
	    (equal ch #\j)
	    (equal ch #\k)
	    (equal ch #\l)
	    (equal ch #\m)
	    (equal ch #\n)
	    (equal ch #\o)
	    (equal ch #\p)
	    (equal ch #\r)
	    (equal ch #\s)
	    (equal ch #\t)
	    (equal ch #\u)
	    (equal ch #\v)
	    (equal ch #\w)
	    (equal ch #\y)
	    (equal ch #\z)
	    (equal ch #\x)
	    (equal ch #\q)
	    )	
		t
		nil
	)
)

;;Buyuk harf ya da kucuk harf ise harftir.
(defun is_letter(letter)
  	(if (or 
  		(is_lower letter)
        (is_upper letter ))
    	t
    	nil
    )
)

;;ASCII ile rakamlarin elde edildigi fonksiyon
(defun is_number(num)
	(if(and
		(>= (- (char-code num) 48) 0)
		(<= (- (char-code num) 48) 9) )
		t
		nil
	)
)


;;Stringleri birlestiren fonskiyon
(defun concatString (list)
	(if (listp list)
		(let ((result_string ""))
			(dolist (element list)
				(if (stringp element)
					(setq result_string (concatenate 'string result_string element))
				)
			)
			result_string
		)
	)
)