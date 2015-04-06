(in-package #:noc-vectors)

(defun render ()
  (update-swank)
  (sdl:update-display))


(defun setup ()
  (setf *width* 600)
  (setf *height* 400))


(defun bouncing-ball-no-vectors ()
  (setup)
  (sdl:with-init (sdl:sdl-init-video)
    (sdl:window *width* *height* :title-caption "Bouncing Ball No Vectors")
    (setf (sdl:frame-rate) 30)
    (sdl:clear-display sdl:*black*)

    (sdl:with-events ()
      (:quit-event () t)
      (:key-down-event (:key key)
		       (case key
			 (:sdl-key-escape (sdl:push-quit-event))))
      (:key-up-event (:key key)
		     (case key))
      (:idle ()
	     (render)))))
