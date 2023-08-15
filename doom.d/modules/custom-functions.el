(defun me/get-arch ()
    (string-chop-newline (shell-command-to-string "uname -m")))
