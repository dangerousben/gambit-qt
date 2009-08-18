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

(define q-exec (make-generic))
(define q-load (make-generic))
(define q-resize (make-generic))
(define q-show (make-generic))

(define q-object
  (make-class '() '(cobj)))

(define (q-cobj obj)
  (slot-ref obj 'cobj))

(define q-application
  (make-class (list q-object) '()))

(define make-q-application
  (c-lambda () qapplication "make_q_application"))

(add-method initialize
  (make-method (list q-application)
    (lambda (cnm obj args)
      (slot-set! obj 'cobj (make-q-application)))))

(define q-application-exec
  (c-lambda (qapplication) void "q_application_exec"))

(add-method q-exec
  (make-method (list q-application)
    (lambda (cnm app)
      (q-application-exec (q-cobj app)))))

(define q-widget
  (make-class (list q-object) '()))

(define q-widget-resize
  (c-lambda (qwidget int int) void "q_widget_resize"))

(add-method q-resize
  (make-method (list q-widget)
    (lambda (cnm widget w h)
      (q-widget-resize (q-cobj widget) w h))))

(define q-widget-show
  (c-lambda (qwidget) void "q_widget_show"))

(add-method q-show
  (make-method (list q-widget)
    (lambda (cnm widget)
      (q-widget-show (q-cobj widget)))))

(define q-push-button
  (make-class (list q-widget) '()))

(define make-q-push-button
  (c-lambda (UTF-8-string) qpushbutton "make_q_push_button"))

(add-method initialize
  (make-method (list q-push-button)
    (lambda (cnm obj args)
      (slot-set! obj 'cobj
                 (make-q-push-button (car args))))))

(define q-web-view
  (make-class (list q-widget) '()))

(define make-q-web-view
  (c-lambda () qwebview "make_q_web_view"))

(add-method initialize
  (make-method (list q-web-view)
    (lambda (cnm obj args)
      (slot-set! obj 'cobj (make-q-web-view)))))

(define q-web-view-load
  (c-lambda (qwebview UTF-8-string) void "q_web_view_load"))

(add-method q-load
  (make-method (list q-web-view)
    (lambda (cnm wv url)
      (q-web-view-load (q-cobj wv) url))))
