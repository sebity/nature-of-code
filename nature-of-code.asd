;;;; nature-of-code.asd

(asdf:defsystem #:nature-of-code
  :description "A loosly based port of Shiffman's The Nature of Code"
  :author "Jan Tatham <jan@sebity.com>"
  :license "MIT"
  :depends-on (#:lispbuilder-sdl)
  :serial t
  :components 
  ((:file "package")
   (:file "maths")
   (:file "primitives")
   (:file "utils")
   (:module "introduction/"
	    :components ((:file "help")
			 (:file "random-walk")))
   (:module "vectors/"
	    :components ((:file "help")
			 (:file "bouncing-ball-no-vectors")))))

