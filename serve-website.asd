(asdf:defsystem "serve-website"
  :author "Christopher Segale"
  :license "MIT"
  :depends-on (:bordeaux-threads
               :hunchentoot
               :cl-who)
  :components ((:file "package")
	       (:file "util-fun")
	       (:file "util-mac")
	       (:file "expander-functions")
	       (:file "webserver")
	       (:file "handler")
	       (:file "main"))
  :build-operation "program-op"
  :build-pathname "serve-website"
  :entry-point "serve-website:main")
