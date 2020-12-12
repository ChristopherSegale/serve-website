(in-package :serve-website)

(defmacro with-gensyms (syms &body body)
  `(let ,(mapcar #'(lambda (s) `(,s (gensym))) syms)
     ,@body))

(defmacro nest-case (keyform &body cases)
  `(case ,keyform
     ,@(mapcar #'(lambda (c)
		   (apply #'ni c))
	       cases)))
