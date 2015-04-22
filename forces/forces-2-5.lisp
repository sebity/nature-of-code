(in-package #:noc-forces)

;;;; apply-forces-2-5
(defun apply-forces-2-5 (m gravity d l)
  (set-x gravity 0)
  (set-y gravity (* 0.1 (mass m)))

  (when (check-liquid-2-5 m l)
    (drag m d l)
    (apply-force m d))

  (apply-force m gravity))


;;;; update-2-5
(defun update-2-5 (m)
  (let ((location (location m))
	(velocity (velocity m))
	(acceleration (acceleration m)))
    (add velocity acceleration)
    (add location velocity)
    (mult acceleration 0)))


;;;; display-liquid-2-5
(defun display-liquid-2-5 (l)
  (draw-box-stroke (x l) (y l) (w l) (h l) '(100 100 100) '(100 100 100)))


;;;; display-balls-2-5
(defun display-balls-2-5 (m)
  (let ((location (location m)))
    (draw-circle 
     (floor (get-x location)) (floor (get-y location)) 
     (floor (* 8 (mass m))) 50 50 50)

    (draw-circle-filled-alpha 
     (floor (get-x location)) (floor (get-y location)) 
     (floor (* 8 (mass m))) 50 50 50 100)))


;;;; check-liquids-2-5
(defun check-liquid-2-5 (m l)
  (let ((ball (location m)))
    (if (and (> (get-x ball) (x l))
	     (< (get-x ball) (w l))
	     (> (get-y ball) (y l))
	     (< (get-y ball) (+ (y l) (h l))))
	t
	nil)))
  

;;;; check-edges-2-5
(defun check-edges-2-5 (m)
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


;;;; render-2-5
(defun render-2-5 ()
  (update-swank)
  (sdl:clear-display sdl:*white*)
  (display-liquid-2-5 *liquids*)
  (dotimes (i (length *movers*))
    (progn (apply-forces-2-5 (aref *movers* i) *gravity* *drag* *liquids*)
	   (update-2-5 (aref *movers* i))
	   (display-balls-2-5 (aref *movers* i))
	   (check-edges-2-5 (aref *movers* i))))
  (sdl:update-display))


;;;; setup-2-5
(defun setup-2-5 ()
  (setf *width* 800)
  (setf *height* 600)
  (setf *movers* (make-array 11))

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

  (setf *liquids* (make-instance 'liquid 
				 :x 0 :y (/ *height* 2)
				 :w *width* :h (/ *height* 2)
				 :c 0.1))

  (setf *gravity* (make-instance 'pvector :x 0 :y 0))
  (setf *drag* (make-instance 'pvector :x 0 :y 0)))


;;;; forces-2-5
(defun forces-2-5 ()
  (setup-2-5)
  (sdl:with-init (sdl:sdl-init-video)
    (sdl:window *width* *height* :title-caption "Forces 2.5 (Drag Force)")
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
	     (render-2-5)))))
