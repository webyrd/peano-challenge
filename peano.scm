;; from @mrb_bk:
;;
;; Who can show me a relational version of a (peano n) function that
;; returns peano numbers like (peano 3) -> (:s (:s (:s 0)))

(import
 (cKanren tester)
 (cKanren ck)
 (cKanren fd)
 (cKanren tree-unify))

(define maxint 1000) ; or whatever

(define (minusfd n m p) (plusfd p m n))

(define (peanoo n pn)
  (fresh ()
    (infd n (range 0 maxint))
    (conde
      [(=fd n 0) (== 'z pn)]
      [(fresh (n-1 pn-1)
         (infd n-1 (range 0 maxint))
         (minusfd n 1 n-1)
         (== `(s ,pn-1) pn)
         (peanoo n-1 pn-1))])))

(test-check "1"
  (run 10 (q) (fresh (n pn) (peanoo n pn) (== q `(,n ,pn))))
  '((0 z)
    (1 (s z))
    (2 (s (s z)))
    (3 (s (s (s z))))
    (4 (s (s (s (s z)))))
    (5 (s (s (s (s (s z))))))
    (6 (s (s (s (s (s (s z)))))))
    (7 (s (s (s (s (s (s (s z))))))))
    (8 (s (s (s (s (s (s (s (s z)))))))))
    (9 (s (s (s (s (s (s (s (s (s z))))))))))))

(test-check "2"
  (run* (q) (peanoo q '(s (s (s (s (s (s (s z)))))))))
  '(7))

(test-check "3"
  (run* (q) (peanoo 7 q))
  '((s (s (s (s (s (s (s z)))))))))

(test-check "4"
  (run* (q) (peanoo 7 '(s (s z))))
  '())

(test-check "5"
  (run* (q) (peanoo 7 `(s (s (s ,q)))))
  '((s (s (s (s z))))))

(test-check "6"
  (run* (q)
    (fresh (n)
      (infd n (range 0 maxint))
      (<=fd n 7)
      (peanoo n q)))
  '(z
    (s z)
    (s (s z))
    (s (s (s z)))
    (s (s (s (s z))))
    (s (s (s (s (s z)))))
    (s (s (s (s (s (s z))))))
    (s (s (s (s (s (s (s z)))))))))

(test-check "7"
  (run* (q)
    (fresh (n)
      (infd n (range 0 maxint))
      (<=fd 4 n)
      (<=fd n 10)
      (peanoo n q)))
  '((s (s (s (s z))))
    (s (s (s (s (s z)))))
    (s (s (s (s (s (s z))))))
    (s (s (s (s (s (s (s z)))))))
    (s (s (s (s (s (s (s (s z))))))))
    (s (s (s (s (s (s (s (s (s z)))))))))
    (s (s (s (s (s (s (s (s (s (s z))))))))))))
