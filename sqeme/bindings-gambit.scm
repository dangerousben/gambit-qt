(c-define-type qobject (pointer void))
(c-define-type qapplication (pointer void))
(c-define-type qwidget (pointer void))
(c-define-type qpushbutton (pointer void))
(c-define-type qwebview (pointer void))

; This is the 'correct' version but it causes a compile error
;(c-define-type qobject (pointer (type "QObject")))
;(c-define-type qapplication (pointer (type "QApplication")))
;(c-define-type qwidget (pointer (type "QWidget")))
;(c-define-type qpushbutton (pointer (type "QPushButton")))
;(c-define-type qwebview (pointer (type "QWebView")))


(define (q-connect source signal dest slot)
  ((c-lambda (qobject UTF-8-string qobject UTF-8-string) bool "q_connect")
   (q-cobj source) signal (q-cobj dest) slot))

(define q-init (make-generic))
(define q-exec (make-generic))
(define q-load (make-generic))
(define q-resize (make-generic))
(define q-show (make-generic))

(define q-object
  (make-class '() '(cobj)))

(define (q-cobj obj)
  (slot-ref obj 'cobj))

(add-method initialize
  (make-method (list q-object)
    (lambda (cnm obj args)
      (slot-set! obj 'cobj (apply q-init obj args)))))

(define q-application
  (make-class (list q-object) '()))

(add-method q-init
  (make-method (list q-application)
    (lambda (cnm obj)
      ((c-lambda () qapplication "make_q_application")))))

(add-method q-exec
  (make-method (list q-application)
    (lambda (cnm app)
      ((c-lambda (qapplication) void "q_application_exec") (q-cobj app)))))

(define q-widget
  (make-class (list q-object) '()))

(add-method q-resize
  (make-method (list q-widget)
    (lambda (cnm widget w h)
      ((c-lambda (qwidget int int) void "q_widget_resize") (q-cobj widget) w h))))

(add-method q-show
  (make-method (list q-widget)
    (lambda (cnm widget)
      ((c-lambda (qwidget) void "q_widget_show") (q-cobj widget)))))

(define q-push-button
  (make-class (list q-widget) '()))

(add-method q-init
  (make-method (list q-push-button)
    (lambda (cnm obj text)
      ((c-lambda (UTF-8-string) qpushbutton "make_q_push_button") text))))

(define q-web-view
  (make-class (list q-widget) '()))

(add-method q-init
  (make-method (list q-web-view)
    (lambda (cnm obj)
      ((c-lambda () qwebview "make_q_web_view")))))

(add-method q-load
  (make-method (list q-web-view)
    (lambda (cnm wv url)
      ((c-lambda (qwebview UTF-8-string) void "q_web_view_load") (q-cobj wv) url))))
