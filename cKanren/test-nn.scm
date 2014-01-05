(library (cKanren test-nn)
  (export test-all)
  (import
    (rnrs)
    (only (chezscheme) time)
    (cKanren tester)
    (cKanren ck)
    (cKanren fd)
    (cKanren tree-unify)
    (cKanren matche)
    (cKanren neural))

(define test-all
  (lambda ()

    (test-check "sum-of-productso forward"
      (run* (q) (sum-of-productso '(1 0 1) '(3 4 5)  q))
      '(8))

    ;; (test-check "sum-of-productso backward"
    ;;   (run 9 (q) (fresh (x y z) (== `(,x ,y ,z) q) (sum-of-productso (map build-num '(1 0 1)) q (build-num 8))))
    ;;   '((() _.0 (0 0 0 1))
    ;;     ((0 0 0 1) _.0 ())
    ;;     ((1 1 1) _.0 (1))
    ;;     ((1) _.0 (1 1 1))
    ;;     ((0 1 1) _.0 (0 1))
    ;;     ((0 0 1) _.0 (0 0 1))
    ;;     ((0 1) _.0 (0 1 1))
    ;;     ((1 0 1) _.0 (1 1))
    ;;     ((1 1) _.0 (1 0 1))))

    ;; (test-check "sum-of-productso backward2"
    ;;   (run 2 (q) (fresh (x y z) (== `(,x ,y ,z) q) (sum-of-productso q (map build-num '(3 4 5)) (build-num 8))))
    ;;   '((() (0 1) ())
    ;;     ((1) () (1))))

    ;; (test-check "sum-of-productso fresh"
    ;;   (run 50 (q) (fresh (xv yv zv xw yw zw v w)
    ;;                 (== `(,xv ,yv ,zv) v)
    ;;                 (== `(,xw ,yw ,zw) w)
    ;;                 (== `(,v ,w) q)
    ;;                 (sum-of-productso v w (build-num 4))))
    ;;   '(((() () (1)) (_.0 _.1 (0 0 1)))
    ;;     ((() () (0 0 1)) (_.0 _.1 (1)))
    ;;     ((() () (0 1)) (_.0 _.1 (0 1)))
    ;;     ((() (_.0 . _.1) (1)) (_.2 () (0 0 1)))
    ;;     (((_.0 . _.1) () (1)) (() _.2 (0 0 1)))
    ;;     ((() (_.0 . _.1) (0 0 1)) (_.2 () (1)))
    ;;     (((_.0 . _.1) () (0 0 1)) (() _.2 (1)))
    ;;     ((() (1) ()) (_.0 (0 0 1) _.1))
    ;;     (((1) () ()) ((0 0 1) _.0 _.1))
    ;;     ((() (1) (_.0 . _.1)) (_.2 (0 0 1) ()))
    ;;     ((() (_.0 . _.1) (0 1)) (_.2 () (0 1)))
    ;;     (((_.0 . _.1) () (0 1)) (() _.2 (0 1)))
    ;;     (((_.0 . _.1) (_.2 . _.3) (1)) (() () (0 0 1)))
    ;;     (((1) () (_.0 . _.1)) ((0 0 1) _.2 ()))
    ;;     (((_.0 . _.1) (_.2 . _.3) (0 0 1)) (() () (1)))
    ;;     ((() (0 0 1) ()) (_.0 (1) _.1))
    ;;     (((_.0 . _.1) (1) ()) (() (0 0 1) _.2))
    ;;     (((1) (_.0 . _.1) ()) ((0 0 1) () _.2))
    ;;     (((0 0 1) () ()) ((1) _.0 _.1))
    ;;     ((() (0 0 1) (_.0 . _.1)) (_.2 (1) ()))
    ;;     (((_.0 . _.1) (1) (_.2 . _.3)) (() (0 0 1) ()))
    ;;     (((_.0 . _.1) (_.2 . _.3) (0 1)) (() () (0 1)))
    ;;     (((0 0 1) () (_.0 . _.1)) ((1) _.2 ()))
    ;;     (((1) (_.0 . _.1) (_.2 . _.3)) ((0 0 1) () ()))
    ;;     (((_.0 . _.1) (0 0 1) ()) (() (1) _.2))
    ;;     (((0 0 1) (_.0 . _.1) ()) ((1) () _.2))
    ;;     (((0 1) () ()) ((0 1) _.0 _.1))
    ;;     ((() (0 1) ()) (_.0 (0 1) _.1))
    ;;     ((() (1) (1)) (_.0 (1 1) (1)))
    ;;     (((1) () (1)) ((1 1) _.0 (1)))
    ;;     (((_.0 . _.1) (0 0 1) (_.2 . _.3)) (() (1) ()))
    ;;     (((0 0 1) (_.0 . _.1) (_.2 . _.3)) ((1) () ()))
    ;;     (((0 1) () (_.0 . _.1)) ((0 1) _.2 ()))
    ;;     ((() (0 1) (_.0 . _.1)) (_.2 (0 1) ()))
    ;;     ((() (1) (0 1)) (_.0 (0 1) (1)))
    ;;     (((1) () (0 1)) ((0 1) _.0 (1)))
    ;;     ((() (1) (1)) (_.0 (0 1) (0 1)))
    ;;     (((1) () (1)) ((0 1) _.0 (0 1)))
    ;;     ((() (0 1) (1)) (_.0 (1) (0 1)))
    ;;     (((0 1) () (1)) ((1) _.0 (0 1)))
    ;;     (((0 1) (_.0 . _.1) ()) ((0 1) () _.2))
    ;;     ((() (0 1) (0 1)) (_.0 (1) (1)))
    ;;     (((0 1) () (0 1)) ((1) _.0 (1)))
    ;;     ((() (1 1) (1)) (_.0 (1) (1)))
    ;;     (((_.0 . _.1) (0 1) ()) (() (0 1) _.2))
    ;;     (((1 1) () (1)) ((1) _.0 (1)))
    ;;     (((_.0 . _.1) (1) (1)) (() (1 1) (1)))
    ;;     ((() (1) (1 1)) (_.0 (1) (1)))
    ;;     (((1) () (1 1)) ((1) _.0 (1)))
    ;;     (((1) (_.0 . _.1) (1)) ((1 1) () (1)))))

    ;; (test-check "sum-of-productso fresh2"
    ;;   (length (run 40 (q) (fresh (xv yv zv xw yw zw v w)
    ;;                         (== `(,xv ,yv ,zv) v)
    ;;                         (== `(,xw ,yw ,zw) w)
    ;;                         (== `(,v ,w) q)
    ;;                         (sum-of-productso v w (build-num 8)))))
    ;;   40)

    ;; (test-check "get-new-valueso 1"
    ;;   (run* (q)
    ;;     (get-new-valueso
    ;;      `((,(build-num 1)
    ;;         (,(build-num 0) ,(build-num 1) ,(build-num 0)))
    ;;        (,(build-num 2)
    ;;         (,(build-num 0) ,(build-num 1) ,(build-num 1))))
    ;;      `(,(build-num 0) ,(build-num 1) ,(build-num 1)) '() q))
    ;;   '(((1) (1))))

    ;; (test-check "get-new-valueso 1b"
    ;;   (run* (q)
    ;;     (get-new-valueso
    ;;      (build-num-sexp '((1 (0 1 0)) (2 (0 1 1))))
    ;;      (build-num-sexp '(0 1 1)) '() q))
    ;;   '(((1) (1))))

    ;; (test-check "run-nno 0"
    ;;   (run 1 (q) (run-nno (build-num-sexp test-nn) (build-num-sexp '(0 0 0)) q))
    ;;   (build-num-sexp '((0))))

    ;; (test-check "run-nno 0b"
    ;;   (run* (q) (run-nno (build-num-sexp test-nn) (build-num-sexp '(0 0 0)) q))
    ;;   (build-num-sexp '((0))))

    ;; (test-check "run-nno 3"
    ;;   (run 1 (q) (run-nno (build-num-sexp test-nn) (build-num-sexp '(0 1 1)) q))
    ;;   (build-num-sexp '((1))))

    ;; (test-check "run-nno 3b"
    ;;   (run* (q) (run-nno (build-num-sexp test-nn) (build-num-sexp '(0 1 1)) q))
    ;;   (build-num-sexp '((1))))

    ;; (test-check "run-nno 3 fully ground"
    ;;   (run* (q) (run-nno (build-num-sexp test-nn)
    ;;                      (build-num-sexp '(0 1 1))
    ;;                      (build-num-sexp '(1))))
    ;;   '(_.0))

    (test-check "run-nno 3 finding input"
      (run 4 (q) (run-nno test-nn
                          q
                          '(1)))
      '((0 1 1) (0 1 2) (0 2 0) (0 1 3)))

    (test-check "run-nno 3 finding nn"
      (run 10 (q) (run-nno q
                           '(0 1 1)
                           '(1)))
      '((((0 (0 0 0))))
        (((0 (0 0 1))))
        (((0 (0 1 0))))
        (((0 (1 0 0))))
        (((0 (0 0 2))))
        (() ((0 ())))
        (((0 (0 0 3))))
        (((1 (0 0 1))))
        (((0 (0 1 1))))
        (((0 (1 0 1))))))

    (test-check "run-nno 3 finding nn b"
      (run 10 (q) (run-nno q
                           '(0 1 1)
                           '(1 0)))
      '((((0 (0 0 0)) (1 (0 0 0))))
        (((0 (0 0 0)) (1 (1 0 0))))
        (((0 (0 0 0)) (1 (2 0 0))))
        (((0 (0 0 0)) (1 (3 0 0))))
        (((0 (0 0 0)) (1 (4 0 0))))
        (((0 (0 0 1)) (1 (0 0 0))))
        (((0 (0 0 0)) (1 (5 0 0))))
        (((0 (0 0 0)) (1 (6 0 0))))
        (((0 (0 0 0)) (2 (0 0 0))))
        (((0 (0 0 1)) (1 (1 0 0))))))

    (test-check "run-nno 3 finding nn b"
      (run 10 (q)
        (fresh (x y z)
          (== q `(,x ,y ,z))
          (run-nno x y z)))
      '((() _.0 _.0)
        ((()) _.0 ())
        ((() ()) _.0 ())
        ((((0 ()))) () (1))
        ((() () ()) _.0 ())
        ((((0 ())) ()) () ())
        ((() ((0 ()))) _.0 (1))
        ((() () () ()) _.0 ())
        ((((1 ()))) () (0))
        ((((2 ()))) () (0))))
    
    ;; (test-check "run-nno 3.2 fully ground"
    ;;   (run* (q) (run-nno '(() ((() ())))
    ;;                      (build-num-sexp '(0 1 1))
    ;;                      (build-num-sexp '(1))))
    ;;   '(_.0))

    ;; (test-check "run-nno 3.2b fully ground"
    ;;   (run* (q) (run-nno (build-num-sexp '(0 ((0 0))))
    ;;                      (build-num-sexp '(0 1 1))
    ;;                      (build-num-sexp '(1))))
    ;;   '(_.0))
    )
  )  
)