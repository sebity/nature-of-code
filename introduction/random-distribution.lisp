(in-package #:noc-intro)

(defun draw-bars ()
  (let ((i (random (length *random-counts*)))
	(w (/ *width* (length *random-counts*))))
    (setf (aref *random-counts* i) (incf (aref *random-counts* i)))

    (dotimes (x (length *random-counts*))
      (noc:draw-box-stroke (* x w) (- *height* (aref *random-counts* x)) 
			   w (aref *random-counts* x)
			   '(175 175 175) '(50 50 50)))))


(defun render-bars ()
  (update-swank)
  (draw-bars)
  (sdl:update-display))


(defun setup-bars ()
  (setf *width* 640)
  (setf *height* 240)
  (setf *random-counts* (make-array 20 :initial-element 0)))


(defun random-distribution ()
  (setup-bars)
  (sdl:with-init (sdl:sdl-init-video)
    (sdl:window *width* *height* :title-caption "Random Distribution")
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
	     (render-bars)))))
