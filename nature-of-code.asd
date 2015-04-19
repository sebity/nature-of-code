;;;; nature-of-code.asd

(asdf:defsystem #:nature-of-code
  :description "A loosly based port of Shiffman's The Nature of Code"
  :author "Jan Tatham <jan@sebity.com>"
  :license "Apache 2.0"
  :depends-on (#:lispbuilder-sdl)
  :serial t
  :components 
  ((:file "package")
   (:file "maths")
   (:file "noise")
   (:file "primitives")
   (:file "pvector")
   (:file "utils")
   (:module "introduction/"
	    :components ((:file "main")
			 (:file "random-walk")
			 (:file "random-distribution")
			 (:file "random-walk-right-bias")
			 (:file "gaussian")
			 (:file "noise-walk")))
   (:module "vectors/"
	    :components ((:file "main")
			 (:file "bouncing-ball-no-vectors")
			 (:file "bouncing-ball")
			 (:file "vector-subtraction")
			 (:file "vector-multiplication")
			 (:file "vector-division")
			 (:file "vector-magnitude")
			 (:file "vector-normalize")
			 (:file "motion-101")
			 (:file "motion-101-acceleration")
			 (:file "motion-101-random-acceleration")
			 (:file "motion-101-acceleration-towards-mouse")
			 (:file "motion-101-array-movers-towards-mouse")))
   (:module "forces/"
	    :components ((:file "main")
			 (:file "forces-2-1")
			 (:file "forces-2-2")))))

