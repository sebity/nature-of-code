;;;; package.lisp

(defpackage #:nature-of-code
  (:use #:cl)
  (:nicknames #:noc)
  (:export
   #:update-swank
   #:draw-pixel
   #:draw-line
   #:draw-box
   #:draw-box-stroke
   #:draw-circle
   #:draw-circle-filled
   #:draw-circle-filled-alpha
   #:draw-ellipse-filled))


(defpackage #:maths
  (:use #:cl)
  (:export 
   #:square
   #:random-gaussian
   #:map-range
   #:constrain))


(defpackage #:noise
  (:use #:cl)
  (:export 
   #:noise-1d))


(defpackage #:pvector
  (:use #:cl)
  (:export
   #:pvector
   #:add
   #:dist
   #:div
   #:equal-to
   #:get-x
   #:get-y
   #:get-z
   #:limit
   #:mag
   #:mult
   #:normalize
   #:random-2d
   #:random-3d
   #:set-x
   #:set-y
   #:set-z
   #:setmag
   #:sub))

(defpackage #:noc-intro
  (:use #:cl #:nature-of-code #:noise)
  (:export
   #:help
   #:random-walk
   #:random-distribution
   #:random-walk-right-bias
   #:gaussian
   #:noise-walk))


(defpackage #:noc-vectors
  (:use #:cl #:nature-of-code)
  (:export
   #:help
   #:bouncing-ball-no-vectors
   #:bouncing-ball
   #:vector-subtraction
   #:vector-multiplication
   #:vector-division
   #:vector-magnitude
   #:vector-normalize
   #:motion-101
   #:motion-101-acceleration
   #:motion-101-random-acceleration
   #:motion-101-acceleration-towards-mouse
   #:motion-101-array-movers-towards-mouse))


(defpackage #:noc-forces
  (:use #:cl #:nature-of-code #:pvector)
  (:export
   #:help
   #:forces-2-1
   #:forces-2-2
   #:forces-2-3
   #:forces-2-4
   #:forces-2-5
   #:forces-2-6
   #:forces-2-7))
