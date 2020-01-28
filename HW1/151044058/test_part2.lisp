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
(defun merge-list(my_list1 my_list2)

	(if (not (null my_list2))    ;;Ikinci listemin bos olup olmama durumu
		
		(cons (car my_list2)( merge-list my_list1 (cdr my_list2))) ;;Bos degilse ikinsi listenin ilk elemanini ekler ve fonksiyonu tekrar cagirir 
		my_list1	 ;;Bos ise eklenme yapilan listeyi return eder
	)
)



;; MAIN FUNCTION
(defun main ()
  (with-open-file (stream #p"input_part2.csv")
    (loop :for line := (read-csv-line stream) :while line :collect
      (format t "~a~%"
      ;; CALL YOUR (MAIN) FUNCTION HERE

      (merge-list (read-from-string (nth 0 line)) (read-from-string (nth 1 line)))

      )
    )
  )
)

;; CALL MAIN FUNCTION
(main)
