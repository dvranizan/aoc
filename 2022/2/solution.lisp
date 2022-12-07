(reduce #'+
(mapcar (lambda (move)
          ;; translate from (lhs,rhs) to value
          ;; with RHS we can just give points for the pick
          ;; with LHS we need to calc win/loss
          (let ((rhs (cond ((string= (second move) "X") 1)
                           ((string= (second move) "Y") 2)
                           ((string= (second move) "Z") 3)))
                (lhs (cond ((string= (first move) "A") 1)
                           ((string= (first move) "B") 2)
                           ((string= (first move) "C") 3))))
            (+ (cond ((= rhs lhs) 3)  ;;draw
                     ((= rhs 1) ;; rock
                      (cond ((= lhs 2) 0)   ;; loss
                            ((= lhs 3) 6))) ;; win
                     ((= rhs 2) ;; paper
                      (cond ((= lhs 1) 6)   ;; win
                            ((= lhs 3) 0))) ;; loss
                     ((= rhs 3) ;; scissors
                      (cond ((= lhs 1) 0)    ;; loss
                            ((= lhs 2) 6))));; win
               rhs)))
        (mapcar (lambda (move)
                  (with-input-from-string (in move)
                    ;; format move into two chars
                    (loop for m = (read in nil)
                          while m
                          collect m)))
                (with-open-file (stream "input.txt")
                  ;;collect from file
                  (loop for line = (read-line stream nil)
                        while line
                        collect line))
                )
        )
)
