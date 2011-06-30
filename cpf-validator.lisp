(load "pregexp/pregexp.lisp")

(defun cpf-validator (num)
  (setf only-numbers (pregexp-replace* "\\.|-" num "" ))
    (if (/= (length only-numbers) 11)
      (error "Invalid length"))
    (if (pregexp-match "^(\\d)\\1{10}$|[^\\d]|123456789" only-numbers)
      (error "Not valid"))
    (setf i 0 first 0 second 0)
    (loop for x from 10 downto 2
      do (setf first (+ first (* x (parse-integer only-numbers :start i :end (+ 1 i)))))
      do (setf i (+ i 1)))
    (setf first (- 11 (mod first 11)))
    (setf i 0)
    (loop for y from 11 downto 3
      do (setf second (+ second (* y (parse-integer only-numbers :start i :end (+ 1 i)))))
      do (setf i (+ i 1))    )
    (setf second (+ second (* 2 first)))
    (setf second (- 11 (mod second 11)))
    (if (>= first 10)
      (setf first 0))
    (if (>= second 10)
      (setf second 0))
    (and (= first (parse-integer only-numbers :start 9 :end 10)) (= second (parse-integer only-numbers :start 10 :end 11))))
