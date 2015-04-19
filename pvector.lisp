(in-package #:pvector)

(defclass pvector ()
  ((x :initarg :x :initform 0 :accessor x)
   (y :initarg :y :initform 0 :accessor y)
   (z :initarg :z :initform 0 :accessor z)))


(defgeneric add (vec-1 vec-2)
  (:documentation "Add two vectors"))

(defgeneric dist (vec-1 vec-2)
  (:documentation "Distance between two vectors"))

(defgeneric div (vec n)
  (:documentation "Divide Vector by a Number"))

(defgeneric equal-to (vec-1 vec-2)
  (:documentation "Set Vector 1 equal to Vector 2"))

(defgeneric get-x (vec)
  (:documentation "Get X Vector"))

(defgeneric get-y (vec)
  (:documentation "Get Y Vector"))

(defgeneric get-z (vec)
  (:documentation "Get Z Vector"))

(defgeneric limit (vec n)
  (:documentation "Limit Vector by a Number"))

(defgeneric mag (vec)
  (:documentation "Get Vector Magnitude"))

(defgeneric mult (vec n)
  (:documentation "Multiply Vector by a Number"))

(defgeneric normalize (vec)
  (:documentation "Normalize a Vector"))

(defgeneric random-2d (vec)
  (:documentation "Randomize Vectors X, Y"))

(defgeneric random-3d (vec)
  (:documentation "Randomize Vectors X, Y, Z"))

(defgeneric set-x (vec n)
  (:documentation "Set X Vector"))

(defgeneric set-y (vec n)
  (:documentation "Set Y Vector"))

(defgeneric set-z (vec n)
  (:documentation "Set Z Vector"))

(defgeneric setmag (vec n)
  (:documentation "Set Vector Magnitude"))

(defgeneric sub (vec-1 vec-2)
  (:documentation "Subtract two vectors"))



; pvector methods

(defmethod add ((v1 pvector) (v2 pvector))
  (setf (x v1) (+ (x v1) (x v2)))
  (setf (y v1) (+ (y v1) (y v2)))
  (setf (z v1) (+ (z v1) (z v2))))

(defmethod dist ((v1 pvector) (v2 pvector))
  (sqrt (+ (square (- (x v1) (x v2)))
	   (square (- (y v1) (y v2)))
	   (square (- (z v1) (z v2))))))

(defmethod div ((vec pvector) (n number))
  (setf (x vec) (/ (x vec) n))
  (setf (y vec) (/ (y vec) n))
  (setf (z vec) (/ (z vec) n)))

(defmethod equal-to ((v1 pvector) (v2 pvector))
  (setf (x v1) (x v2))
  (setf (y v1) (y v2))
  (setf (z v1) (z v2)))

(defmethod get-x ((vec pvector))
  (x vec))

(defmethod get-y ((vec pvector))
  (y vec))

(defmethod get-z ((vec pvector))
  (z vec))

(defmethod limit ((vec pvector) (n number))
  (let ((length-squared (+ (* (x vec) (x vec))
			   (* (y vec) (y vec))
			   (* (y vec) (y vec)))))
    (unless (< length-squared (* n n))
      (setf (x vec) (* (x vec) (/ n (sqrt length-squared))))
      (setf (y vec) (* (y vec) (/ n (sqrt length-squared))))
      (setf (z vec) (* (z vec) (/ n (sqrt length-squared)))))))

(defmethod mag ((vec pvector))
  (sqrt (+ (* (x vec) (x vec))
	   (* (y vec) (y vec))
	   (* (z vec) (z vec)))))

(defmethod mult ((vec pvector) (n number))
  (setf (x vec) (* (x vec) n))
  (setf (y vec) (* (y vec) n))
  (setf (z vec) (* (z vec) n)))

(defmethod normalize ((vec pvector))
  (let ((m (mag vec)))
    (if (zerop m)
	0
	(div vec m))))

(defmethod random-2d ((vec pvector))
  (setf (x vec) (- (random 2.0) 1))
  (setf (y vec) (- (random 2.0) 1)))

(defmethod random-3d ((vec pvector))
  (setf (x vec) (- (random 2.0) 1))
  (setf (y vec) (- (random 2.0) 1))
  (setf (z vec) (- (random 2.0) 1)))

(defmethod set-x ((vec pvector) (n number))
  (setf (x vec) n))

(defmethod set-y ((vec pvector) (n number))
  (setf (y vec) n))

(defmethod set-z ((vec pvector) (n number))
  (setf (z vec) n))

(defmethod setmag ((vec pvector) (n number))
  (normalize vec)
  (mult vec n))

(defmethod sub ((v1 pvector) (v2 pvector))
  (setf (x v1) (- (x v1) (x v2)))
  (setf (y v1) (- (y v1) (y v2)))
  (setf (z v1) (- (z v1) (z v2))))


; Extra Functions

(defun square (x)
  (* x x))
