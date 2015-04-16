(in-package #:noc-vectors)

;;;; update-ex-1-11
(defun update-ex-1-11 (mover)
  (dotimes (i (length mover))
    (update-ex-1-11-aux (aref *movers* i))))


;;;; update-ex-1-11-aux
(defun update-ex-1-11-aux (m)
  (let ((vel (velocity m))
	(loc (location m))
	(tspd (topspeed m))
	(acc *acceleration*)
	(mouse *mouse*))

    (setf (x mouse) (sdl:mouse-x))
    (setf (y mouse) (sdl:mouse-y))

    (sub-vectors mouse loc)
    (setmag-vectors mouse 0.3)
    (equal-vectors acc mouse)

    (add-vectors vel acc)
    (limit-vectors vel tspd)
    (add-vectors loc vel)))


;;;; display-ex-1-11
(defun display-ex-1-11 (mover)
  (dotimes (i (length mover))
    (display-ex-1-11-aux (aref *movers* i))))


;;;; display-ex-1-11-aux
(defun display-ex-1-11-aux (m)
  (draw-circle (floor (x (location m)))
	       (floor (y (location m)))
	       16 50 50 50)
  (draw-circle-filled-alpha (floor (x (location m)))
			    (floor (y (location m)))
			    16 0 0 0 50))

;;;; render-ex-1-11
(defun render-ex-1-11 ()
  (update-swank)
  (sdl:clear-display sdl:*white*)
  (update-ex-1-11 *movers*)
  (display-ex-1-11 *movers*)
  (sdl:update-display))


;;;; setup-ex-1-11
(defun setup-ex-1-11 ()
  (setf *width* 600)
  (setf *height* 360)
  (setf *movers* (make-array 20))

  (dotimes (i (length *movers*))
    (setf (aref *movers* i) (make-instance 'mover 
					   :location (make-instance 'pvector 
								    :x (random *width*) 
								    :y (random *height*))
					   :velocity (make-instance 'pvector :x 0 :y 0)
					   :topspeed 5)))

  (setf *acceleration* (make-instance 'pvector :x 0 :y 0))
  (setf *mouse* (make-instance 'pvector :x (sdl:mouse-x) :y (sdl:mouse-y))))


(defun motion-101-array-movers-towards-mouse ()
  (setup-ex-1-11)
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
	     (render-ex-1-11)))))
