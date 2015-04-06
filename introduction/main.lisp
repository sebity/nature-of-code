(in-package #:noc-intro)

(defparameter *width* 600)
(defparameter *height* 400)

(defparameter *walker* nil)
(defparameter *random-counts* nil)
(defparameter *tx* nil)
(defparameter *ty* nil)

(defstruct walker
  (x 0)
  (y 0))

(defun help ()
  (format t "Introduction~%")
  (format t "============~%~%")
  (format t "> random-walk~%")
  (format t "> random-distribution~%")
  (format t "> random-walk-right-bias~%")
  (format t "> gaussian~%")
  (format t "> noise-walk~%"))
