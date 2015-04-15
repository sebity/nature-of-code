(in-package #:noc-vectors)

(defparameter *width* 600)
(defparameter *height* 400)
(defparameter *location* nil)
(defparameter *velocity* nil)
(defparameter *acceleration* nil)
(defparameter *mouse* nil)
(defparameter *center* nil)

(defparameter *x* 0)
(defparameter *y* 0)
(defparameter *xspeed* 0)
(defparameter *yspeed* 0)
(defparameter *topspeed* 0)


(defclass pvector ()
  ((x :initarg :x :initform 0 :accessor x)
   (y :initarg :y :initform 0 :accessor y)))


(defun add-vectors (vec-1 vec-2)
  (setf (x vec-1) (+ (x vec-1) (x vec-2)))
  (setf (y vec-1) (+ (y vec-1) (y vec-2))))

(defun sub-vectors (vec-1 vec-2)
  (setf (x vec-1) (- (x vec-1) (x vec-2)))
  (setf (y vec-1) (- (y vec-1) (y vec-2))))

(defun mult-vectors (vec n)
  (setf (x vec) (* (x vec) n))
  (setf (y vec) (* (y vec) n)))

(defun div-vectors (vec n)
  (setf (x vec) (/ (x vec) n))
  (setf (y vec) (/ (y vec) n)))

(defun mag-vectors (vec)
  (sqrt (+ (* (x vec) (x vec))
	   (* (y vec) (y vec)))))

(defun normalize-vectors (vec)
  (let ((m (mag-vectors vec)))
    (if (zerop m)
	0
	(div-vectors vec m))))

(defun limit-vectors (vec limit)
  (let ((length-squared (+ (* (x vec) (x vec))
			   (* (y vec) (y vec)))))
    (unless (< length-squared (* limit limit))
      (setf (x vec) (* (x vec) (/ limit (sqrt length-squared))))
      (setf (y vec) (* (y vec) (/ limit (sqrt length-squared)))))))


(defun random-2d-vectors (vec)
  (setf (x vec) (- (random 2.0) 1))
  (setf (y vec) (- (random 2.0) 1)))


(defun help ()
  (format t "Vectors~%")
  (format t "=======~%~%")
  (format t "> bouncing-ball-no-vectors~%")
  (format t "> bouncing-ball~%")
  (format t "> vector-subtraction~%")
  (format t "> vector-multiplication~%")
  (format t "> vector-division~%")
  (format t "> vector-magnitude~%")
  (format t "> vector-normalize~%")
  (format t "> motion-101~%")
  (format t "> motion-101-acceleration~%")
  (format t "> motion-101-random-acceleration~%"))
