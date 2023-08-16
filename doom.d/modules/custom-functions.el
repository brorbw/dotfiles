(defun me/is-arm ()
  (string-equal (string-chop-newline (shell-command-to-string "uname -m")) "arm64"))
