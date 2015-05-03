(in-package #:noc-forces)

;;;; update-2-8
(defun update-2-8 (m)
  (let ((location (location m))
	(velocity (velocity m))
	(acceleration (acceleration m)))
    (add velocity acceleration)
    (add location velocity)
    (mult acceleration 0)))


;;;; display-mover-2-8
(defun display-mover-2-8 (m)
  (let ((location (location m)))
    (draw-circle 
     (floor (get-x location)) (floor (get-y location)) 
     (floor (* 16 (mass m))) 50 50 50)

    (draw-circle-filled-alpha 
     (floor (get-x location)) (floor (get-y location)) 
     (floor (* 16 (mass m))) 50 50 50 100)))


;;;; check-edges-2-8
(defun check-edges-2-8 (m)
  (let ((location (location m))
	(velocity (velocity m)))
    (when (> (get-x location) *width*)
      (set-x location *width*)
      (set-x velocity (* (get-x velocity) -1)))

    (when (< (get-x location) 0)
      (set-x location 0)
      (set-x velocity (* (get-x velocity) -1)))
    
    (when (> (get-y location) *height*)
      (set-y location *height*)
      (set-y velocity (* (get-y velocity) -1)))

    (when (< (get-y location) 0)
      (set-y location 0)
      (set-y velocity (* (get-y velocity) -1)))))


;;;; render-2-8
(defun render-2-8 ()
  (update-swank)
  (sdl:clear-display sdl:*white*)
  (loop for i below (length *movers*)
     do (loop for j below (length *movers*)
	   do (if (not (eql i j))
		  (apply-force (aref *movers* i) (attract (aref *movers* j) 
						      (aref *movers* i)))))
       (update-2-8 (aref *movers* i))
       (display-mover-2-8 (aref *movers* i)))
  (sdl:update-display))


;;;; setup-2-8
(defun setup-2-8 ()
  (setf *width* 800)
  (setf *height* 600)
  (setf *movers* (make-array 20))
  (dotimes (i (length *movers*))
    (setf (aref *movers* i) 
	  (make-instance 'mover
			 :location (make-instance 'pvector 
						  :x (random *width*)
						  :y (random *height*))
			 :velocity (make-instance 'pvector
						  :x 0 :y 0)
			 :acceleration (make-instance 'pvector
						      :x 0 :y 0)
			 :topspeed 5
			 :mass (+ (random 2.0) 0.5)
			 :gravity 0.4))))

;;;; forces-2-8
(defun forces-2-8 ()
  (setup-2-8)
  (sdl:with-init (sdl:sdl-init-video)
    (sdl:window *width* *height* :title-caption "Forces 2.8 (Mutual Attraction)")
    (setf (sdl:frame-rate) 60)
    (sdl:clear-display sdl:*white*)

    (sdl:with-events ()
      (:quit-event () t)
      (:key-down-event (:key key)
		       (case key
			 (:sdl-key-escape (sdl:push-quit-event))))
      (:key-up-event (:key key)
		     (case key))
      (:idle ()
	     (render-2-8)))))
