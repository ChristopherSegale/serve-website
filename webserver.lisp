(in-package :serve-website)

(defmacro with-webserver (&body body)
  (with-gensyms (h th)
    `(let ((,h (make-instance 'hunchentoot:easy-acceptor :port +port+ :document-root +root+)))
       ,@body
       (hunchentoot:start ,h)
       (handler-case (bt:join-thread (find-if (lambda (,th)
						(search "hunchentoot" (bt:thread-name ,th)))
                                              (bt:all-threads)))
	 ;; Catch a user's C-c
	 (#+sbcl sb-sys:interactive-interrupt
	   #+ccl  ccl:interrupt-signal-condition
	   #+clisp system::simple-interrupt-condition
	   #+ecl ext:interactive-interrupt
	   #+allegro excl:interrupt-signal
	   () (progn
		(format *error-output* "Aborting.~&")
		(uiop:quit)))
	 (error (c) (format t "Woops, an unknown error occured:~&~a~&" c))))))
