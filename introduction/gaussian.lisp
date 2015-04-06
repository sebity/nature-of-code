(in-package #:noc-intro)

(defun draw-gaussian ()
  (draw-circle-filled-alpha (floor (random-gaussian (/ *width* 2) 60)) (/ *height* 2)
		       16 0 0 0 10))

(defun render-gaussian ()
  (update-swank)
  (draw-gaussian)
  (sdl:update-display))


(defun setup-gaussian ()
  (setf *width* 640)
  (setf *height* 300))


(defun gaussian ()
  (setup-gaussian)
  (sdl:with-init (sdl:sdl-init-video)
    (sdl:window *width* *height* :title-caption "Gaussian")
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
	     (render-gaussian)))))
