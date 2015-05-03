(in-package #:noc-forces)

;;;; update-2-7
(defun update-2-7 (m)
  (let ((location (location m))
	(velocity (velocity m))
	(acceleration (acceleration m)))
    (add velocity acceleration)
    (add location velocity)
    (mult acceleration 0)))


;;;; display-mover-2-7
(defun display-mover-2-7 (m)
  (let ((location (location m)))
    (draw-circle 
     (floor (get-x location)) (floor (get-y location)) 
     (floor (* 16 (mass m))) 50 50 50)

    (draw-circle-filled-alpha 
     (floor (get-x location)) (floor (get-y location)) 
     (floor (* 16 (mass m))) 50 50 50 100)))


;;;; display-attractor-2-7
(defun display-attractor-2-7 (a)
  (let ((location (location a)))
    (draw-circle 
     (floor (get-x location)) (floor (get-y location)) 
     24 50 50 50)

    (draw-circle-filled-alpha 
     (floor (get-x location)) (floor (get-y location)) 
      24 50 50 50 100)))


;;;; check-edges-2-7
(defun check-edges-2-7 (m)
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


;;;; render-2-7
(defun render-2-7 ()
  (update-swank)
  (sdl:clear-display sdl:*white*)
  (dotimes (m (length *movers*))
    (apply-force (aref *movers* m) (attract *attractors* (aref *movers* m)))
    (update-2-7 (aref *movers* m))
    (display-mover-2-7 (aref *movers* m)))
  (display-attractor-2-7 *attractors*)
  (sdl:update-display))


;;;; setup-2-7
(defun setup-2-7 ()
  (setf *width* 800)
  (setf *height* 600)
  (setf *movers* (make-array 10))
  (dotimes (i (length *movers*))
    (setf (aref *movers* i) 
	  (make-instance 'mover
			 :location (make-instance 'pvector 
						  :x (+ (random (- *width* 300)) 150)
						  :y (+ (random (- *height* 300)) 150))
			 :velocity (make-instance 'pvector
						  :x 1 :y 0)
			 :acceleration (make-instance 'pvector
						      :x 0 :y 0)
			 :topspeed 5
			 :mass (+ (random 2.0) 0.5))))

  (setf *attractors* 
	(make-instance 'attractor
		       :location (make-instance 'pvector 
						:x (/ *width* 2) :y (/ *height* 2))
		       :mass 20 :gravity 1 :dragging 0 :rollover 0
		       :drag-offset (make-instance 'pvector
						   :x 0 :y 0))))

;;;; forces-2-7
(defun forces-2-7 ()
  (setup-2-7)
  (sdl:with-init (sdl:sdl-init-video)
    (sdl:window *width* *height* :title-caption "Forces 2.7 (Attraction Many)")
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
	     (render-2-7)))))
