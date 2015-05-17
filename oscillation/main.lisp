(in-package #:noc-oscillation)

(defparameter *width* 600)
(defparameter *height* 400)

(defparameter *movers* nil)

(defclass mover ()
  ((location :initarg :location :initform nil :accessor location)
   (velocity :initarg :velocity :initform nil :accessor velocity)
   (acceleration :initarg :acceleration :initform nil :accessor acceleration)
   (topspeed :initarg :topspeed :initform nil :accessor topspeed)
   (mass :initarg :mass :initform 1 :accessor mass)
   (angle :initarg :angle :initform 0 :accessor angle)
   (a-velocity :initarg :a-velocity :initform 0 :accessor a-velocity)
   (a-acceleration :initarg :a-acceleration :initform 0 :accessor a-acceleration)))


;;;; check-edges
(defun check-edges (m)
  (let ((location (location m))
	(velocity (velocity m)))
    (when (> (get-x location) *width*)
      (set-x location *width*)
      (set-x velocity (* (get-x velocity) -1)))

    (when (< (get-x location) 0)
      (set-x location 0)
      (set-x velocity (* (get-x velocity) -1)))
    
    (when (> (get-y location) *height*)
      (set-y location *height*)
      (set-y velocity (* (get-y velocity) -1)))

    (when (< (get-y location) 0)
      (set-y location 0)
      (set-y velocity (* (get-y velocity) -1)))))


;;;; help
(defun help ()
  (format t "Oscillations~%")
  (format t "============~%~%")
  (format t "> oscillation-3-1~%"))
