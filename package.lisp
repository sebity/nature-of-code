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
   #:map-range))


(defpackage #:noise
  (:use #:cl)
  (:export 
   #:noise-1d))


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
   #:vector-normalize))
