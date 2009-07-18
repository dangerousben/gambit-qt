(let ((app (make-qapplication))
      (button (make-qpushbutton "Hello!")))
  (qwidget-resize button 100 30)
  (qt-connect button "clicked" app "quit")
  (qwidget-show button)
  (qapplication-exec app))

