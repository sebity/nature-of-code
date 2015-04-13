(in-package #:noc-vectors)

(defun draw-ex-1-5 (mouse center)
  (let ((m nil))
    (setf (x mouse) (sdl:mouse-x))
    (setf (y mouse) (sdl:mouse-y))
  
    (sub-vectors mouse center)
  
    (setf m (mag-vectors mouse))
    (draw-box 0 0 m 10 0 0 0)
    
    (draw-line (x center) (y center) 
	       (floor (+ (x mouse) (x center))) (floor (+ (y mouse) (y center))) 0 0 0)))
  

(defun render-ex-1-5 ()
  (update-swank)
  (sdl:clear-display sdl:*white*)
  (draw-ex-1-5 *mouse* *center*)
  (sdl:update-display))


(defun setup-ex-1-5 ()
  (setf *width* 600)
  (setf *height* 360)
  (setf *mouse* (make-instance 'pvector :x 100 :y 100))
  (setf *center* (make-instance 'pvector :x (/ *width* 2) :y (/ *height* 2))))


(defun vector-magnitude ()
  (setup-ex-1-5)
  (sdl:with-init (sdl:sdl-init-video)
    (sdl:window *width* *height* :title-caption "Vector Magnitude")
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
	     (render-ex-1-5)))))
