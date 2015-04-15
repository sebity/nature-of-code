(in-package #:noc-vectors)

;;;; update-ex-1-10
(defun update-ex-1-10 ()
  (let ((vel *velocity*)
	(loc *location*)
	(acc *acceleration*)
	(mouse *mouse*))

    (setf (x mouse) (sdl:mouse-x))
    (setf (y mouse) (sdl:mouse-y))

    (sub-vectors mouse loc)
    (setmag-vectors mouse 0.3)
    (equal-vectors acc mouse)

    (add-vectors vel acc)
    (limit-vectors vel *topspeed*)
    (add-vectors loc vel)))


;;;; display-ex-1-10
(defun display-ex-1-10 (loc)
  (draw-ellipse-filled (floor (x loc)) (floor (y loc)) 24 24 0 0 0))


;;;; render-ex-1-10
(defun render-ex-1-10 ()
  (update-swank)
  (sdl:clear-display sdl:*white*)
  (update-ex-1-10)
  (display-ex-1-10 *location*)
  (sdl:update-display))


;;;; setup-ex-1-10
(defun setup-ex-1-10 ()
  (setf *width* 600)
  (setf *height* 360)
  (setf *location* (make-instance 'pvector :x (/ *width* 2) :y (/ *height* 2)))
  (setf *velocity* (make-instance 'pvector :x 0 :y 0))
  (setf *acceleration* (make-instance 'pvector :x 0 :y 0))
  (setf *mouse* (make-instance 'pvector :x (sdl:mouse-x) :y (sdl:mouse-y)))
  (setf *topspeed* 5))


(defun motion-101-acceleration-towards-mouse ()
  (setup-ex-1-10)
  (sdl:with-init (sdl:sdl-init-video)
    (sdl:window *width* *height* :title-caption "Motion 101 (Acceleration Towards the Mouse)")
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
	     (render-ex-1-10)))))
