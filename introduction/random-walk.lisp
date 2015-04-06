(in-package #:noc-intro)

(defun draw-walker (w)
  (let ((r (random 4)))
    (cond ((zerop r) (setf (walker-x w) (incf (walker-x w))))
	  ((= r 1) (setf (walker-x w) (decf (walker-x w))))
	  ((= r 2) (setf (walker-y w) (incf (walker-y w))))
	  (t (setf (walker-y w) (decf (walker-y w))))))

  (draw-pixel (walker-x w) (walker-y w) 0 0 0))


(defun render-walker ()
  (update-swank)
  (draw-walker *walker*)
  (sdl:update-display))


(defun setup-walker ()
  (setf *width* 640)
  (setf *height* 300)
  (setf *walker* (make-walker :x (/ *width* 2)
			      :y (/ *height* 2))))


(defun random-walk ()
  (setup-walker)
  (sdl:with-init (sdl:sdl-init-video)
    (sdl:window *width* *height* :title-caption "Random Walker")
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
	     (render-walker)))))
