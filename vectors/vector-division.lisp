(in-package #:noc-vectors)

(defun draw-ex-1-4-b (mouse center)
  (setf (x mouse) (sdl:mouse-x))
  (setf (y mouse) (sdl:mouse-y))
  
  (sub-vectors mouse center)
  
  (div-vectors mouse 2)

  (draw-line (x center) (y center) 
	     (floor (+ (x mouse) (x center))) (floor (+ (y mouse) (y center))) 0 0 0))
  

(defun render-ex-1-4-b ()
  (update-swank)
  (sdl:clear-display sdl:*white*)
  (draw-ex-1-4-b *mouse* *center*)
  (sdl:update-display))


(defun setup-ex-1-4-b ()
  (setf *width* 600)
  (setf *height* 360)
  (setf *mouse* (make-instance 'pvector :x 100 :y 100))
  (setf *center* (make-instance 'pvector :x (/ *width* 2) :y (/ *height* 2))))


(defun vector-division ()
  (setup-ex-1-4-b)
  (sdl:with-init (sdl:sdl-init-video)
    (sdl:window *width* *height* :title-caption "Vector Division")
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
	     (render-ex-1-4-b)))))
