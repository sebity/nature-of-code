(in-package #:noc-vectors)

(defgeneric update-ex-1-7 (p1 p2)
  (:documentation "Update location"))

(defgeneric check-edges-ex-1-7 (loc)
  (:documentation "Check if ball reaches the edge"))

(defgeneric display-ex-1-7 (loc)
  (:documentation "Display the ball"))


;;;; update-ex-1-7
(defmethod update-ex-1-7 ((p1 pvector) (p2 pvector))
  (add-vectors p1 p2))


;;;; check-edges-ex-1-7
(defmethod check-edges-ex-1-7 ((loc pvector))
  (cond ((> (x loc) *width*) (setf (x loc) 0))
	((< (x loc) 0) (setf (x loc) *width*)))

  (cond ((> (y loc) *height*) (setf (y loc) 0))
	((< (y loc) 0) (setf (y loc) *height*))))


;;;; display-ex-1-7
(defmethod display-ex-1-7 ((loc pvector))
  (draw-ellipse-filled (x loc) (y loc) 24 24 0 0 0))


;;;; render-ex-1-7
(defun render-ex-1-7 ()
  (update-swank)
  (sdl:clear-display sdl:*white*)
  (update-ex-1-7 *location* *velocity*)
  (check-edges-ex-1-7 *location*)
  (display-ex-1-7 *location*)
  (sdl:update-display))


;;;; setup-ex-1-7
(defun setup-ex-1-7 ()
  (setf *width* 600)
  (setf *height* 360)
  (setf *location* (make-instance 'pvector :x (random *width*) :y (random *height*)))
  (setf *velocity* (make-instance 'pvector :x (- (random 4) 2) :y (- (random 4) 2))))


(defun motion-101 ()
  (setup-ex-1-7)
  (sdl:with-init (sdl:sdl-init-video)
    (sdl:window *width* *height* :title-caption "Motion 101 (Velocity)")
    (setf (sdl:frame-rate) 30)
    (sdl:clear-display sdl:*white*)

    (sdl:with-events ()
      (:quit-event () t)
      (:key-down-event (:key key)
		       (case key
			 (:sdl-key-escape (sdl:push-quit-event))))
      (:key-up-event (:key key)
		     (case key))
      (:idle ()
	     (render-ex-1-7)))))
