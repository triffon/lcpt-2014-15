(define (1+ x) (+ x 1))

(define (repeat n f x)
  (if ( = n 0) x
;      (f (repeat (- n 1) f x))))
      (repeat (- n 1) f (f x))))

(define (c n)
  (lambda (f)
    (lambda (x)
      (repeat n f x))))

(define (print c)
  ((c 1+) 0))

(define c2 (c 2))
(define c5 (c 5))

(print c2)

(define c*
  (lambda (a)
    (lambda (b)
      (lambda (f)
	(lambda (x)
	  ((a (b f)) x))))))

(print ((c* c2) c5))

(define c+
  (lambda (a)
    (lambda (b)
      (lambda (f)
	(lambda (x)
	  ((a f) ((b f) x)))))))

(print ((c+ c2) c5))

;; Типовете не съвпадат!
;; (define c?
;;   (lambda (a)
;;     (lambda (b)
;;       (lambda (f)
;; 	((a f) (b f))))))

(define c^
  (lambda (m)
    (lambda (n)
      ((n
	(lambda (p)
	  (lambda (f)
	    (m (p f)))))
       (lambda (f) f)))))

(print ((c^ (c 2)) (c 8)))

(define c^^
  (lambda (m)
    (lambda (n)
      (n m))))

(print ((c^^ (c 2)) (c 8)))

(define true
  (lambda (x)
    (lambda (y)
      x)))

(define false
  (lambda (x)
    (lambda (y)
      y)))

(define cif
  (lambda (p)
    p))

(define (printbool p)
  ((p #t) #f))

(define czero
  (lambda (n)
    ((n
      (lambda (p) false))
     true)))

(printbool (czero (c 0)))
(printbool (czero (c 10)))

(define cnzero
  (lambda (n)
    ((n
      (lambda (p) true))
      false)))

(printbool (cnzero (c 0)))
(printbool (cnzero (c 10)))

(define c!
  (lambda (p)
    ((p false) true)))

(printbool (c! true))
(printbool (c! false))

(define c&
  (lambda (p)
    (lambda (q)
      ((p q) false))))

(define c_
  (lambda (p)
    (lambda (q)
      ((p true) q))))

(printbool ((c& true) false))
(printbool ((c_ true) false))

