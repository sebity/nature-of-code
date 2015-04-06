(in-package #:noc-intro)

(defun draw-walker-bias (w)
  (let ((r (random 1.0)))
    (cond ((< r 0.4) (setf (walker-x w) (incf (walker-x w))))
	  ((< r 0.6) (setf (walker-x w) (decf (walker-x w))))
	  ((< r 0.8) (setf (walker-y w) (incf (walker-y w))))
	  (t (setf (walker-y w) (decf (walker-y w))))))
  
  (draw-pixel (walker-x w) (walker-y w) 0 0 0))


(defun render-walker-bias ()
  (update-swank)
  (draw-walker-bias *walker*)
  (sdl:update-display))


(defun setup-walker-bias ()
  (setf *width* 640)
  (setf *height* 300)
  (setf *walker* (make-walker :x (/ *width* 2)
			      :y (/ *height* 2))))


(defun random-walk-right-bias ()
  (setup-walker-bias)
  (sdl:with-init (sdl:sdl-init-video)
    (sdl:window *width* *height* :title-caption "Random Walker with Right Bias")
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
	     (render-walker-bias)))))
