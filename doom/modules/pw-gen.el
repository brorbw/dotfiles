;;; pw-gen.el -*- lexical-binding: t; -*-
(defun random-alnum ()
  (let* ((alnum "abcdefghijklmnopqrstuvwxyz0123456789")
	 (i (% (abs (random)) (length alnum))))
    (substring alnum i (1+ i))))

(defun me/random-pw (length)
  (if (= length 0)
      (random-alnum)
    (concat (random-alnum) (me/random-pw (- length 1)))))

(defun me/pw ()
  (interactive)
  (let ((pw (me/random-pw (string-to-number
			   (read-from-minibuffer
			    (propertize "PW length: " 'face '(default)))))))
    (when (called-interactively-p 'any)
      (insert pw))
    pw))
