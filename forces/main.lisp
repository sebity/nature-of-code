(in-package #:noc-forces)

(defparameter *width* 600)
(defparameter *height* 400)

(defparameter *movers* nil)
(defparameter *liquids* nil)
(defparameter *wind* nil)
(defparameter *gravity* nil)
(defparameter *friction* nil)
(defparameter *drag* nil)

(defclass mover ()
  ((location :initarg :location :initform nil :accessor location)
   (velocity :initarg :velocity :initform nil :accessor velocity)
   (acceleration :initarg :acceleration :initform nil :accessor acceleration)
   (topspeed :initarg :topspeed :initform nil :accessor topspeed)
   (mass :initarg :mass :initform 1 :accessor mass)))


(defclass liquid ()
  ((x :initarg :x :initform 0 :accessor x)
   (y :initarg :y :initform 0 :accessor y)
   (w :initarg :w :initform 0 :accessor w)
   (h :initarg :h :initform 0 :accessor h)
   (c :initarg :c :initform 0 :accessor c)))

;;;; apply-force
(defun apply-force (m force)
  (div force (mass m))
  (add (acceleration m) force))


;;;; drag
(defun drag (m d l)
  (let* ((speed (mag (velocity m)))
	 (drag-mag (* (c l) speed speed)))
    (equal-to d (velocity m))
    (mult d -1)
    (normalize d)
    (mult d drag-mag)))


;;;; help
(defun help ()
  (format t "Introduction~%")
  (format t "============~%~%")
  (format t "> forces-2-1~%")
  (format t "> forces-2-2~%")
  (format t "> forces-2-3~%")
  (format t "> forces-2-4~%")
  (format t "> forces-2-5~%"))
