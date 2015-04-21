(in-package #:noc-forces)

;;;; apply-forces-2-4
(defun apply-forces-2-4 (m wind gravity friction)
  (set-x wind 0.01)
  (set-y wind 0)

  (set-x gravity 0)
  (set-y gravity (* 0.1 (mass m)))

  (let ((c 0.05))
    (equal-to friction (velocity m))
    (mult friction -1)
    (normalize friction)
    (mult friction c)

    (apply-force m friction)
    (apply-force m wind)
    (apply-force m gravity)))


;;;; update-2-4
(defun update-2-4 (m)
  (let ((location (location m))
	(velocity (velocity m))
	(acceleration (acceleration m)))
    (add velocity acceleration)
    (add location velocity)
    (mult acceleration 0)))


;;;; display-2-4
(defun display-2-4 (m)
  (let ((location (location m)))
    (draw-circle 
     (floor (get-x location)) (floor (get-y location)) 
     (floor (* 8 (mass m))) 50 50 50)

    (draw-circle-filled-alpha 
     (floor (get-x location)) (floor (get-y location)) 
     (floor (* 8 (mass m))) 50 50 50 100)))


;;;; check-edges-2-4
(defun check-edges-2-4 (m)
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


;;;; render-2-4
(defun render-2-4 ()
  (update-swank)
  (sdl:clear-display sdl:*white*)
  (dotimes (i (length *movers*))
    (progn (apply-forces-2-4 (aref *movers* i) *wind* *gravity* *friction*)
	   (update-2-4 (aref *movers* i))
	   (display-2-4 (aref *movers* i))
	   (check-edges-2-4 (aref *movers* i))))
  (sdl:update-display))


;;;; setup-2-4
(defun setup-2-4 ()
  (setf *width* 600)
  (setf *height* 400)
  (setf *movers* (make-array 5))

  (dotimes (i (length *movers*))
    (setf (aref *movers* i)
	  (make-instance 'mover
			 :location (make-instance 'pvector 
						  :x (random *width*) :y 0)
			 :velocity (make-instance 'pvector
						  :x 0 :y 0)
			 :acceleration (make-instance 'pvector
						      :x 0 :y 0)
			 :topspeed 5
			 :mass (+ (random 4.0) 0.5))))

  (setf *wind* (make-instance 'pvector :x 0 :y 0))
  (setf *gravity* (make-instance 'pvector :x 0 :y 0))
  (setf *friction* (make-instance 'pvector :x 0 :y 0)))


;;;; forces-2-4
(defun forces-2-4 ()
  (setup-2-4)
  (sdl:with-init (sdl:sdl-init-video)
    (sdl:window *width* *height* :title-caption "Forces 2.4 (Friction)")
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
	     (render-2-4)))))
