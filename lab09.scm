(define (over-or-under num1 num2)
  (if (< num1 num2)
      -1
      (if (> num1 num2)
          1
          0)))

(define (make-adder num)
  (define (adder inc)
    (+ num inc))
  adder)


(define (composed f g)
  (define (composed-function x)
    (f (g x)))
  composed-function)

(define (repeat f n)
  (if (= n 1)
      f
      (lambda (x) (f ((repeat f (- n 1)) x)))))


(define (max a b)
  (if (> a b)
      a
      b))

(define (min a b)
  (if (> a b)
      b
      a))

(define (gcd a b)
  (if (zero? b)
      a
      (gcd b (modulo a b))))
