(defpackage :serve-website
  (:use :cl)
  (:export :main))

(in-package :serve-website)

(defconstant +port+ 8080)
(defconstant +root+ #P"web-resources/")

(defvar *collapse-menu* "var coll = document.getElementsByClassName(\"collapsible\"); var i; for (i = 0; i < coll.length; i++) { coll[i].addEventListener(\"click\", function() { this.classList.toggle(\"block\"); var content = this.nextElementSibling; if (content.style.display === \"block\") { content.style.display = \"none\"; } else { content.style.display = \"block\"; } }); }")
