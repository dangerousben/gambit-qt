(c-define-type qobject (pointer void))
(c-define-type qapplication (pointer void))
(c-define-type qwidget (pointer void))
(c-define-type qpushbutton (pointer void))

; This is the 'correct' version but it causes a compile error
;(c-define-type qapplication (pointer (type "QObject")))
;(c-define-type qapplication (pointer (type "QApplication")))
;(c-define-type qpushbutton (pointer (type "QWidget")))
;(c-define-type qpushbutton (pointer (type "QPushButton")))

(define qt-connect
  (c-lambda (qobject UTF-8-string qobject UTF-8-string) bool "qt_connect"))

(define make-qapplication
  (c-lambda () qapplication "make_qapplication"))

(define qapplication-exec
  (c-lambda (qapplication) void "qapplication_exec"))

(define make-qpushbutton
  (c-lambda (UTF-8-string) qpushbutton "make_qpushbutton"))

(define qwidget-resize
  (c-lambda (qwidget int int) void "qwidget_resize"))

(define qwidget-show
  (c-lambda (qwidget) void "qwidget_show"))
