peano-challenge
===============

A simple relational Scheme integer to peano translator, demonstrating finite domain constraints.

Inspired by a Twitter challenge from @mrb_bk:

Who can show me a relational version of a (peano n) function that
returns peano numbers like (peano 3) -> (:s (:s (:s 0)))

The code peano.scm contains the solution and a few test cases.  The cKanren contains a Scheme version of cKanren.  This peano code should run with little or no modfication under Racket's cKanren, and under Clojure's core.logic.

This version of cKanren only runs under Chez Scheme or Petite Chez Scheme.