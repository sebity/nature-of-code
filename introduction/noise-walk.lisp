(in-package #:noc-intro)

(defparameter *tx* (random 1d0))
(defparameter *ty* (random 1d0))


(defun draw-noise-walker ()
  (let ((dx (maths:map-range (noise:noise-1d *tx*) -1 1 0 *width*))
	(dy (maths:map-range (noise:noise-1d *ty*) -1 1 0 *height*)))
    (declare (type double-float dx dy))
    (draw-circle-filled (floor dx) (floor dy) 16 50 50 50))
  
  (setf *tx* (+ *tx* 0.01d0))
  (setf *ty* (+ *ty* 0.01d0)))


(defun render-noise-walker ()
  (update-swank)
  (sdl:clear-display sdl:*white*)
  (draw-noise-walker)
  (sdl:update-display))


(defun setup-noise ()
  (setf *width* 640)
  (setf *height* 300))


(defun noise-walk ()
  (setup-noise)
  (sdl:with-init (sdl:sdl-init-video)
    (sdl:window *width* *height* :title-caption "Perlin Noise")
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
	     (render-noise-walker)))))
