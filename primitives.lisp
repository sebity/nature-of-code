(in-package #:nature-of-code)

;;;;;;;;;;;;;;;;;;;;;;;; PRIMITIVES ;;;;;;;;;;;;;;;;;;;;;;;;

;;;; DRAW-PIXEL function

(defun draw-pixel (x y r g b)
  (sdl:draw-pixel-* x y :color (sdl:color :r r :g g :b b)))


;;;; DRAW-BOX function

(defun draw-box (x y w h r g b)
  (sdl:draw-box (sdl:rectangle-from-midpoint-* x y w h)
		:color (sdl:color :r r :g g :b b)))


;;;; DRAW-BOX-STROKE function

(defun draw-box-stroke (x y w h rgb1 rgb2)
  (sdl:draw-box (sdl:rectangle :x x :y y :w w :h h)
		:color (sdl:color :r (first rgb1) :g (second rgb1) :b (third rgb1))
		:stroke-color (sdl:color :r (first rgb2) :g (second rgb2) :b (third rgb2))))


;;;; DRAW-LINE function

(defun draw-line (x0 y0 x1 y1 r g b)
  (sdl:draw-line-* x0 y0 x1 y1
		   :color (sdl:color :r r :g g :b b)))

;;;; DRAW-CIRCLE function

(defun draw-circle (x y rad r g b)
  (sdl:draw-circle-* x y rad
		     :color (sdl:color :r r :g g :b b)))


;;;; DRAW-CIRCLE-FILLED function

(defun draw-circle-filled (x y rad r g b)
  (sdl:draw-filled-circle-* x y rad
		     :color (sdl:color :r r :g g :b b)))


;;;; DRAW-CIRCLE-FILLED-ALPHA function

(defun draw-circle-filled-alpha (x y rad r g b alpha)
  (sdl:draw-filled-circle-* x y rad
		     :color (sdl:color :r r :g g :b b :a alpha)))


;;;; DRAW-ELLIPSE-FILLED function

(defun draw-ellipse-filled (x y rx ry r g b)
  (sdl:draw-filled-ellipse-* x y rx ry
		     :color (sdl:color :r r :g g :b b)))


;;;; DRAW-POLYGON function

(defun draw-polygon (vertices r g b)
  (sdl:draw-filled-polygon vertices :color (sdl:color :r r :g g :b b)))
