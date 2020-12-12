(in-package :serve-website)

(defun ni (&rest args)
  (labels ((inner (ar at)
	     (if ar
		 (list (car ar) (inner (cdr ar) at))
		 at)))
    (inner (butlast args) (car (last args)))))

(defun load-expressions (file-name)
  (with-open-file (in file-name)
    (do ((se (read in nil) (read in nil))
	 exp)
	((not se) (nreverse exp))
      (push se exp))))
