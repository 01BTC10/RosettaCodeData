#lang racket

(with-handlers ([exn:fail:contract:divide-by-zero?
                 (Î» (e) (displayln "Divided by zero"))])
  (/ 1 0))
