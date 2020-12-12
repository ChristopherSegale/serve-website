(in-package :serve-website)

(defun print-website (nav-list meta-title title content)
  `(cl-who:with-html-output-to-string (*standard-output* nil :prologue t)
     (:html
      (:head
       (:link :rel "stylesheet" :href "style.css")
       (:title ,meta-title)
       (:meta :charset "utf-8")
       (:meta :name "viewport" :content "width=device-width, initial-scale=1"))
      (:body
       (:h1 :class "center"
	    ,title)
       ,(print-navbar nav-list)
       (:main
	,@(print-content content)))
      (:script
       ,*collapse-menu*))))

(defun new-print-navbar (nav-bar)
  `(:div :class "center"
	 (:button :type "button" :class "collapsible" "Navigation Menu")
	 (:nav
	  (:ul
	   ,@(mapcar #'(lambda (page)
			 `(:a :href ,(car page) (:li ,(cdr page))))
		     nav-bar)))))

(defun print-navbar (nav-bar)
  `(:div :class "center"
    (:button :type "button" :class "collapsible" "Navigation Menu")
    (:nav
     (:ul
      ,@(list-items (mapcar #'(lambda (page)
				`(:a :href ,(car page) ,(cdr page)))
			    nav-bar))))))

(defun print-content (content)
  (mapcar #'(lambda (c)
	      (if (consp c)
		  (nest-case (car c)
		    (:ordered print-ordered-items (cdr c))
		    (:project print-project (cdr c))
		    (:contact print-contact (cdr c))
		    (t print-unordered-items c))
		  (print-paragraph c)))
	  content))

(defun print-paragraph (paragraph)
  `(:p ,paragraph))

(defun print-ordered-items (oi)
  `(:ol ,@(list-items oi)))

(defun print-unordered-items (ui)
  `(:ul ,@(list-items ui)))

(defun print-project (prj)
  `(:p
    (:a :href ,(third prj)
	(:b ,(first prj)))
    (:br)
    ,(concatenate 'string "Written in: " (second prj))
    (:br)
    ,(concatenate 'string "Summery: " (fifth prj))
    ,@(if (> (length prj) 5)
	  (list
	   `(:br)
	   (concatenate 'string "Portion Worked on: " (sixth prj))))
    ,@(when (consp (fourth prj))
		  (print-image (fourth prj) (concatenate 'string (first prj) " image")))))

(defun print-image (images alt-text)
  (list
   `(:img :class "desktop" :src ,(car images) :alt ,alt-text)
   `(:img :class "mobile" :src ,(cadr images) :alt ,alt-text)))

(defun print-contact (contact)
  (case (car contact)
    (:phone `(:p
	      (:a :class "mobile" :href ,(concatenate 'string "tel:1-" (cadr contact)) "Click here to call me.")
	      (:div :class "desktop"
		      "Phone Number:"
		      (:br)
		      ,(cadr contact))))
    (:email `(:p "Email Address:"
		 (:br)
		 (:a :href ,(concatenate 'string "mailto:" (cadr contact)) ,(cadr contact))))
    (t (error "First argument must either be :phone or :email"))))

(defun list-items (li)
  (mapcar #'(lambda (i) `(:li ,i)) li))

(defun create-webpages (file-name)
  (let ((webpages (load-expressions file-name)) nav-bar)
    (list
     (mapcar #'(lambda (wp)
		 (push (cons (fourth (car wp)) (sixth (car wp))) nav-bar)
		 `,wp)
	     webpages)
     (progn
	 (setf (cdr (elt nav-bar (1- (length nav-bar)))) "Home")
	 (nreverse nav-bar)))))
