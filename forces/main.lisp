(in-package #:noc-forces)

(defparameter *width* 600)
(defparameter *height* 400)

(defparameter *movers* nil)
(defparameter *wind* nil)
(defparameter *gravity* nil)
(defparameter *friction* nil)

(defclass mover ()
  ((location :initarg :location :initform nil :accessor location)
   (velocity :initarg :velocity :initform nil :accessor velocity)
   (acceleration :initarg :acceleration :initform nil :accessor acceleration)
   (topspeed :initarg :topspeed :initform nil :accessor topspeed)
   (mass :initarg :mass :initform 1 :accessor mass)))


;;;; apply-force
(defun apply-force (m force)
  (div force (mass m))
  (add (acceleration m) force)) 


(defun help ()
  (format t "Introduction~%")
  (format t "============~%~%")
  (format t "> forces-2-1~%")
  (format t "> forces-2-2~%")
  (format t "> forces-2-3~%")
  (format t "> forces-2-4~%"))
