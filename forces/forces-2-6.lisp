(in-package #:noc-forces)

;;;; update-2-6
(defun update-2-6 (m)
  (let ((location (location m))
	(velocity (velocity m))
	(acceleration (acceleration m)))
    (add velocity acceleration)
    (add location velocity)
    (mult acceleration 0)))


;;;; display-mover-2-6
(defun display-mover-2-6 (m)
  (let ((location (location m)))
    (draw-circle 
     (floor (get-x location)) (floor (get-y location)) 
     (floor (* 16 (mass m))) 50 50 50)

    (draw-circle-filled-alpha 
     (floor (get-x location)) (floor (get-y location)) 
     (floor (* 16 (mass m))) 50 50 50 100)))


;;;; display-attractor-2-6
(defun display-attractor-2-6 (a)
  (let ((location (location a)))
    (draw-circle 
     (floor (get-x location)) (floor (get-y location)) 
     24 50 50 50)

    (draw-circle-filled-alpha 
     (floor (get-x location)) (floor (get-y location)) 
      24 50 50 50 100)))


;;;; check-edges-2-6
(defun check-edges-2-6 (m)
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


;;;; render-2-6
(defun render-2-6 ()
  (update-swank)
  (sdl:clear-display sdl:*white*)
  (apply-force *movers* (attract *attractors* *movers*))
  (update-2-6 *movers*)
  (display-mover-2-6 *movers*)
  (display-attractor-2-6 *attractors*)
  (sdl:update-display))


;;;; setup-2-6
(defun setup-2-6 ()
  (setf *width* 800)
  (setf *height* 600)

  (setf *movers* (make-instance 'mover
				:location (make-instance 'pvector 
							 :x 300 :y 100)
				:velocity (make-instance 'pvector
							 :x 1 :y 0)
				:acceleration (make-instance 'pvector
							     :x 0 :y 0)
				:topspeed 5
				:mass 1))

  (setf *attractors* 
	(make-instance 'attractor
		       :location (make-instance 'pvector 
						:x (/ *width* 2) :y (/ *height* 2))
		       :mass 20 :gravity 1 :dragging 0 :rollover 0
		       :drag-offset (make-instance 'pvector
						   :x 0 :y 0))))

;;;; forces-2-6
(defun forces-2-6 ()
  (setup-2-6)
  (sdl:with-init (sdl:sdl-init-video)
    (sdl:window *width* *height* :title-caption "Forces 2.6 (Attraction)")
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
	     (render-2-6)))))
