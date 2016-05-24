;;;; upload-file.asd

(asdf:defsystem #:upload-file
  :description "Describe upload-file here"
  :author "Knut Olav Bøhmer"
  :license "Public Domain"
  :depends-on (#:ningle
               #:woo
               #:clack
               #:cl-who)
  :serial t
  :components ((:file "package")
               (:file "upload-file")))

