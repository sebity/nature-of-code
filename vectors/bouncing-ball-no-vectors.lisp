(in-package #:noc-vectors)

(defun draw-ex-1-1 ()
  (setf *x* (+ *x* *xspeed*))
  (setf *y* (+ *y* *yspeed*))

  (when (or (> *x* *width*)
	    (< *x* 0))
    (setf *xspeed* (* *xspeed* -1)))

  (when (or (> *y* *height*)
	    (< *y* 0))
    (setf *yspeed* (* *yspeed* -1)))

  (draw-ellipse-filled (floor *x*) (floor *y*) 16 16 150 150 150))
  

(defun render-ex-1-1 ()
  (update-swank)
  (sdl:clear-display sdl:*white*)
  (draw-ex-1-1)
  (sdl:update-display))


(defun setup-ex-1-1 ()
  (setf *width* 600)
  (setf *height* 400)
  (setf *x* 100)
  (setf *y* 100)
  (setf *xspeed* 1)
  (setf *yspeed* 3.3))


(defun bouncing-ball-no-vectors ()
  (setup-ex-1-1)
  (sdl:with-init (sdl:sdl-init-video)
    (sdl:window *width* *height* :title-caption "Bouncing Ball No Vectors")
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
	     (render-ex-1-1)))))
