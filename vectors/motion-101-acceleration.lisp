(in-package #:noc-vectors)

;;;; update-ex-1-8
(defun update-ex-1-8 (loc vel acc)
  (add-vectors vel acc)
  (limit-vectors vel *topspeed*)
  (add-vectors loc vel))


;;;; check-edges-ex-1-8
(defun check-edges-ex-1-8 (loc)
  (cond ((> (x loc) *width*) (setf (x loc) 0))
	((< (x loc) 0) (setf (x loc) *width*)))

  (cond ((> (y loc) *height*) (setf (y loc) 0))
	((< (y loc) 0) (setf (y loc) *height*))))


;;;; display-ex-1-8
(defun display-ex-1-8 (loc)
  (draw-ellipse-filled (floor (x loc)) (floor (y loc)) 24 24 0 0 0))


;;;; render-ex-1-8
(defun render-ex-1-8 ()
  (update-swank)
  (sdl:clear-display sdl:*white*)
  (update-ex-1-8 *location* *velocity* *acceleration*)
  (check-edges-ex-1-8 *location*)
  (display-ex-1-8 *location*)
  (sdl:update-display))


;;;; setup-ex-1-8
(defun setup-ex-1-8 ()
  (setf *width* 600)
  (setf *height* 360)
  (setf *location* (make-instance 'pvector :x (/ *width* 2) :y (/ *height* 2)))
  (setf *velocity* (make-instance 'pvector :x 0 :y 0))
  (setf *acceleration* (make-instance 'pvector :x -0.001 :y 0.01))
  (setf *topspeed* 10))


(defun motion-101-acceleration ()
  (setup-ex-1-8)
  (sdl:with-init (sdl:sdl-init-video)
    (sdl:window *width* *height* :title-caption "Motion 101 (Constant Acceleration)")
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
	     (render-ex-1-8)))))
