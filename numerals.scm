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

(define ccar
  (lambda (z)
    (z true)))

(define ccdr
  (lambda (z)
    (z false)))

(define ccons
  (lambda (x)
    (lambda (y)
      (lambda (z)
	((z x) y)))))

(define (printnpair z)
  (cons (print (ccar z))
	(print (ccdr z))))

(define z23 ((ccons (c 2)) (c 3)))
(print (ccar z23))
(print (ccdr z23))
(printnpair z23)

(define c+1
  (lambda (n)
    (lambda (f)
      (lambda (x)
	((n f) (f x))))))

(print (c+1 (c 5)))

(define cfact
  (lambda (n)
    (ccar
     ((n
       (lambda (z)
	 ((lambda (k)
	    ((ccons
	      ((c*
		(ccar z)) ; (k-1)!
	       k))
	     k))
	  (c+1 (ccdr z)))));  стъпка
      ((ccons (c 1)) (c 0)))))) ; база
  
(print (cfact (c 10)))

(define c-1
  (lambda (n)
    (ccar
     ((n
       (lambda (z)
	 ((ccons
	   (ccdr z))
	  (c+1
	   (ccdr z))))) ; стъпка
       ((ccons (c 0)) (c 0))))))

(print (c-1 (c 100)))
(print (c-1 (c 0)))

(define Y
  (lambda (f)
    ((lambda (x)
       (f (x x)))
     (lambda (x)
       (f (x x))))))

;; (define T
;;   (lambda (f)
;;     ((lambda (x)
;;        (lambda (y)
;; 	 ((f (x x)) y)))
;;      (lambda (x)
;;        (lambda (y)
;; 	 ((f (x x)) y))))))
;; не работи! η-експанзията трябва да е по-навътре...

(define T
  (lambda (f)
    ((lambda (x)
       (f
	(lambda (y)
	  ((x x) y))))
     (lambda (x)
       (f
	(lambda (y)
	  ((x x) y)))))))

; проблем с cif!
; заради стриктното оценяване в Scheme, се оценяват и двата аргумента,
; което води до безкрайна рекурсия, ако единият аргумент е рекурсивно извикване
; (print (((cif true) (c 1)) (Y (lambda (x) x))))

; как се решава проблема в Scheme?
(define (f x) (f x))
; (f 1) -> забива

; прави се η-експанзия
(define (g x) (lambda (y) ((g x) y)))
; (g 1) -> не забива

; решение: прави се η-експанзия на аргументите на if, които биха довели до безкрайна рекурсия
(print (((cif true)
	 (c 1))
	(lambda (y)
	  ((Y (lambda(x) x)) y))))

(print (((cif false)
	 (lambda (y)
	   ((Y (lambda(x) x)) y)))
	(c 2)))

; така вече можем да дефинираме факториел рекурсивно
(define factop
  (lambda (f)
    (lambda (n)
      (((cif
	 (czero n))
	(c 1))
       (lambda (z)
	 (((c*
	    n)
	   (f (c-1 n)))
	  z))))))

(define fact (T factop))
(print (fact (c 7)))
