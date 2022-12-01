
(reduce #'max
        (loop with elves
              for elf in (loop with megalist
                               for item in (with-open-file (stream "input.txt")
                                             ;; collect into meglist from file
                                             (loop for line = (read-line stream nil)
                                                   while line
                                                   collect (parse-integer line :junk-allowed t)))
                               ;; split on the NILs
                               if (equal item NIL)
                                 ;; backup and collect into little list
                                 collect (nreverse megalist) and do (setf megalist nil)
                               else
                                 ;; keep going
                                 do (push item megalist))
              ;; sum elf cals
              while elf
              collect (reduce '+ elf)))
(reduce #'+
        (subseq 
         (sort
          (loop with elves
                for elf in (loop with megalist
                                 for item in (with-open-file (stream "input.txt")
                                               ;; collect into meglist from file
                                               (loop for line = (read-line stream nil)
                                                     while line
                                                     collect (parse-integer line :junk-allowed t)))
                                 ;; split on the NILs
                                 if (equal item NIL)
                                   ;; backup and collect into little list
                                   collect (nreverse megalist) and do (setf megalist nil)
                                 else
                                   ;; keep going
                                   do (push item megalist))
                ;; sum elf cals
                while elf
                collect (reduce '+ elf))
          #'>) 0 3))
