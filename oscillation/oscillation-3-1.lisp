(in-package #:noc-oscillation)

;;;; update-3-1
(defun update-3-1 (m)
  (add (velocity m) (acceleration m))
  (add (location m) (velocity m))

  (setf (a-velocity m) (+ (a-velocity m) (a-acceleration m)))
  (setf (angle m) (+ (angle m) (a-velocity m)))

  (mult (acceleration m) 0))


;;;; display-3-1
(defun display-3-1 (m)
  (let* ((loc-x (get-x (location m)))
	 (loc-y (get-y (location m)))
	 (pt1 (maths:rotate -50 0 loc-x loc-y (angle m)))
	 (pt2 (maths:rotate 50 0 loc-x loc-y (angle m))))
    (draw-line (first pt1) (second pt1) (first pt2) (second pt2) 0 0 0)
    (draw-circle-filled (first pt1) (second pt1) 8 0 0 0)
    (draw-circle-filled (first pt2) (second pt2) 8 0 0 0)))


;;;; render-3-1
(defun render-3-1 ()
  (update-swank)
  (sdl:clear-display sdl:*white*)
  (update-3-1 *movers*)
  (display-3-1 *movers*)
  (sdl:update-display))


;;;; setup-3-1
(defun setup-3-1 ()
  (setf *width* 600)
  (setf *height* 400)
  (setf *movers* (make-instance 'mover
				:location (make-instance 'pvector 
							 :x (/ *width* 2) :y (/ *height* 2))
				:velocity (make-instance 'pvector
							 :x 0 :y 0)
				:acceleration (make-instance 'pvector
							     :x 0 :y 0)
				:topspeed 5
				:mass 1
				:angle 0
				:a-velocity 0
				:a-acceleration 0.01)))


;;;; oscillation-3-1
(defun oscillation-3-1 ()
  (setup-3-1)
  (sdl:with-init (sdl:sdl-init-video)
    (sdl:window *width* *height* :title-caption "Oscillation 3.1")
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
	     (render-3-1)))))
