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


(defun constrain (value min max)
  (if (< value min)
      min
      (if (> value max)
	  max
	  value)))

(defun rad-to-deg (radians)
  (/ (* radians 180.0) pi))

(defun deg-to-rad (degrees)
  (/ (* degrees pi) 180.0))

(defun rotate (pt-x pt-y pos-x pos-y angle)
  (let* ((dx (- (* pt-x (cos (deg-to-rad angle)))
		(* pt-y (sin (deg-to-rad angle)))))
	 (dy (+ (* pt-x (sin (deg-to-rad angle)))
		(* pt-y (cos (deg-to-rad angle))))))
    (list (+ (floor dx) pos-x) (+ (floor dy) pos-y))))
