(in-package #:maths)

(defun square (x)
  (* x x))

(defun random-gaussian (mean std-dev)
  (+ mean (* std-dev 
	     (sqrt (* -2 (log (random 1.0))))
	     (cos (* 2 pi (random 1.0))))))

(defun map-range (value min1 max1 min2 max2)
  (+ min2 
     (* (- max2 min2) 
	(/ (- value min1) (- max1 min1)))))
