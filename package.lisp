;;;; package.lisp

(defpackage #:nature-of-code
  (:use #:cl)
  (:nicknames #:noc)
  (:export
   #:update-swank
   #:draw-pixel))


(defpackage #:noc-intro
  (:use #:cl #:nature-of-code)
  (:export
   #:help
   #:random-walker))


(defpackage #:noc-vectors
  (:use #:cl #:nature-of-code)
  (:export
   #:help
   #:bouncing-ball-no-vectors))
