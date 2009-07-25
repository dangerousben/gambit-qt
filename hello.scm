(let ((app (make q-application))
      (button (make q-push-button "Hello!")))
  (q-resize button 100 30)
  (q-connect button "clicked" app "quit")
  (q-show button)
  (q-exec app))

