(in-package #:noc-vectors)

(defun draw-ex-1-2 (loc vel)
  (add-vectors loc vel)

  (when (or (> (x loc) *width*)
	    (< (x loc) 0))
    (setf (x vel) (* (x vel) -1)))

  (when (or (> (y loc) *height*)
	    (< (y loc) 0))
    (setf (y vel) (* (y vel) -1)))

  (draw-ellipse-filled (floor (x loc)) (floor (y loc)) 16 16 150 150 150))
  

(defun render-ex-1-2 ()
  (update-swank)
  (sdl:clear-display sdl:*white*)
  (draw-ex-1-2 *location* *velocity*)
  (sdl:update-display))


(defun setup-ex-1-2 ()
  (setf *width* 600)
  (setf *height* 360)
  (setf *location* (make-instance 'pvector :x 100 :y 100))
  (setf *velocity* (make-instance 'pvector :x 2.5 :y 5.0)))


(defun bouncing-ball ()
  (setup-ex-1-2)
  (sdl:with-init (sdl:sdl-init-video)
    (sdl:window *width* *height* :title-caption "Bouncing Ball")
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
	     (render-ex-1-2)))))
