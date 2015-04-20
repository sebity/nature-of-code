(in-package #:noc-forces)

;;;; forces
(defun forces (m wind gravity)
  (set-x wind 0.01)
  (set-y wind 0)

  (set-x gravity 0)
  (set-y gravity 0.1)

  (apply-force m wind)
  (apply-force m gravity))


;;;; update-2-1
(defun update-2-1 (m)
  (let ((location (location m))
	(velocity (velocity m))
	(acceleration (acceleration m)))
    (add velocity acceleration)
    (add location velocity)
    (mult acceleration 0)))


;;;; display-2-1
(defun display-2-1 (m)
  (let ((location (location m)))
    (draw-circle 
     (floor (get-x location)) (floor (get-y location)) 
     16 50 50 50)

    (draw-circle-filled-alpha 
     (floor (get-x location)) (floor (get-y location)) 
     16 50 50 50 100)))


;;;; check-edges-2-1
(defun check-edges-2-1 (m)
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


;;;; render-2-1
(defun render-2-1 ()
  (update-swank)
  (sdl:clear-display sdl:*white*)
  (forces *movers* *wind* *gravity*)
  (update-2-1 *movers*)
  (display-2-1 *movers*)
  (check-edges-2-1 *movers*)
  (sdl:update-display))


;;;; setup-2-1
(defun setup-2-1 ()
  (setf *width* 600)
  (setf *height* 400)
  (setf *movers* (make-instance 'mover
				:location (make-instance 'pvector 
							 :x 30 :y 30)
				:velocity (make-instance 'pvector
							 :x 0 :y 0)
				:acceleration (make-instance 'pvector
							     :x 0 :y 0)
				:topspeed 5
				:mass 1))
  (setf *wind* (make-instance 'pvector :x 0.01 :y 0))
  (setf *gravity* (make-instance 'pvector :x 0 :y 0.1)))


;;;; forces-2-1
(defun forces-2-1 ()
  (setup-2-1)
  (sdl:with-init (sdl:sdl-init-video)
    (sdl:window *width* *height* :title-caption "Forces 2.1")
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
	     (render-2-1)))))
