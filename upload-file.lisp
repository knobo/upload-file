;;;; upload-file.lisp

(in-package #:upload-file)

(setf (html-mode) :html5)

(defun page (&optional arg &rest args)
  (declare (ignore arg args))
  (with-html-output-to-string (s nil :indent t :prologue t)
    (:html :ng-app "upl"
     (:head
      (:title "upload-test")
      (:meta :charset "UTF-8")
      (:meta :http-equiv "cache-control" :content "no-cache")
      (:script :src "https://ajax.googleapis.com/ajax/libs/angularjs/1.4.5/angular.min.js")
      (:script :src "https://cdnjs.cloudflare.com/ajax/libs/danialfarid-angular-file-upload/12.0.4/ng-file-upload-all.min.js")
      (:script :src "https://cdnjs.cloudflare.com/ajax/libs/danialfarid-angular-file-upload/12.0.4/FileAPI.js")
      (:script :src "/controller.js"))
      (:body :ng-controller "myCtrl"
	     "Uploading.. Wating for server to crash"
	     (:br)(:label "Step 10 more bytes")
	     (:input :type "number" :ng-click "run()" :ng-model "size" :step "10")
	     (:br)(:label "Step 100 more bytes")	     

	     (:input :type "number" :ng-click "run()" :ng-model "size" :step "100")
	     (:br)(:label "Step 1000 more bytes")

	     (:input :type "number" :ng-click "run()" :ng-model "size" :step "1000")
	     (:br)(:div (:div "Status: " "{{result}}")
			(:div "Uploaded: " "{{prcnt}}%"))))))
  

(defvar *app* (make-instance '<app>))

(setf (route *app* "/")
      (lambda (&rest args)(declare (ignore args)) (page)))

(setf (route *app* "/controller.js")
      (merge-pathnames #p"controller.js" (asdf:system-source-directory :upload-file)))

(defparameter *knobo* nil)
(setf (route *app* "/upload" :method :post)
      #'(lambda (&rest args)
	  (declare (ignore args))
	  (setf (getf (response-headers *response*) :content-type) "application/json")
	  (setf (getf (response-headers *response*) :status) 200)
	  "{\"status\":\"OK\"}"))


(defvar *handler* nil)

(when *handler*
  (stop *handler*))

(defun start () 
  (setf *handler*
	(clackup 
	 *app*
	 :server :woo
	 :use-thread nil
	 :use-default-middlewares nil)))
