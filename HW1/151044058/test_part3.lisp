(load "csv-parser.lisp")
(in-package :csv-parser)

;; (read-from-string STRING)
;; This function converts the input STRING to a lisp object.
;; In this code, I use this function to convert lists (in string format) from csv file to real lists.

;; (nth INDEX LIST)
;; This function allows us to access value at INDEX of LIST.
;; Example: (nth 0 '(a b c)) => a

;; !!! VERY VERY VERY IMPORTANT NOTE !!!
;; FOR EACH ARGUMENT IN CSV FILE
;; USE THE CODE (read-from-string (nth ARGUMENT-INDEX line))
;; Example: (mypart1-funct (read-from-string (nth 0 line)) (read-from-string (nth 1 line)))

;; DEFINE YOUR FUNCTION(S) HERE
(defun insert-n(my_list n index)

	(if (> index (length my_list))	;;Index listenin uzunlugundan buykse hata mesaji verir ve cikar
		(abort (print "Index can not be more than length of list")) 
	)

	(if (< index 0)	;; Index negatifse hata verir ve cikar
		(abort (print "Index can not be negative number")) 
	)

	(if (null my_list)	;;Listenin bos olup olmama kosulu
		(push n my_list)	;;Bossa ekleme yapilir
		(if (= index 0)	;;Liste bos degil ve index' in 0 olup olmama kosulu
			(push n my_list)	;;Index 0 olduysa ekleme yapilir
			(cons (car my_list)( insert-n (cdr my_list) n (- index 1))) ;; Index 0 olmadiysa listenin ilk elemani eklenir ve index azaltilarak fonksiyon cagirilir 
		)
 	)
)


;; MAIN FUNCTION
(defun main ()
  (with-open-file (stream #p"input_part3.csv")
    (loop :for line := (read-csv-line stream) :while line :collect
      (format t "~a~%"
      ;; CALL YOUR (MAIN) FUNCTION HERE
      (insert-n (read-from-string (nth 0 line)) (read-from-string (nth 1 line)) (read-from-string (nth 2 line)))


      )
    )
  )
)

;; CALL MAIN FUNCTION
(main)
