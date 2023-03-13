;;; $DOOMDIR/modules/custom-keymappings.el -*- lexical-binding: t; -*-

(setq-default evil-escape-key-sequence "fd")

(setq-default doom-localleader-key ",")

(defun me/surround-with-symbol (char)
  (interactive)
  (let ((bounds (bounds-of-thing-at-point 'symbol)))
    (evil-surround-region (car bounds) (cdr bounds) 'inclusive char)))

(defun me/eval-and-replace ()
  "replace the preceding sexp with its value."
  (interactive)
  (up-list)
  (backward-char)
  (let ((value (eval (elisp--preceding-sexp))))
    (backward-up-list)
    (mark-sexp)
    (kill-sexp)
    (insert (format "%s" value))))

(defun me/eval ()
  "replace the preceding sexp with its value."
  (interactive)
  (up-list)
  (backward-char)
  (eval (elisp--preceding-sexp)))

(defun me/eval-and-replace1 ()
  "Replace the preceding sexp with its value."
  (interactive)
  (backward-sexp)
  (seq-let (beg &rest end) (bounds-of-thing-at-point 'sexp)
    (let ((value (eval (read (current-buffer)))))
      (delete-region beg end)
      (prin1 value (current-buffer)))))

(defun me/eval-and-replace3 ()
  "Replace the preceding sexp with its value."
  (interactive)
  (backward-sexp)
  (kill-sexp)
  (insert (eval (read (car kill-ring)))))

(defun me/current-symbol-replace-in-buffer ()
  (interactive)
  (evil-multiedit-ex-match
   (point-min) (point-max)
   t (concat "\\_<" (regexp-quote (thing-at-point 'symbol t)) "\\_>")))

(defun me/current-word-replace-in-buffer ()
  (interactive)
  (evil-multiedit-ex-match
   (point-min) (point-max)
   t (regexp-quote (thing-at-point 'word t))))

(defun me/search-replace-region ()
  (interactive)
  (when (use-region-p)
    (unwind-protect
        (progn (add-hook 'consult--completion-candidate-hook #'embark-export)
               (call-interactively #'+vertico/project-search))
      (remove-hook 'consult--completion-candidate-hook #'embark-export))))

(map!
 :desc "surround with parans"
 :leader
 "{" '(lambda ()
	(interactive)
	(me/surround-with-symbol ?\{))
 "}" '(lambda ()
	(interactive)
	(me/surround-with-symbol ?\}))
 "(" '(lambda ()
	(interactive)
	(me/surround-with-symbol ?\())
 ")" '(lambda ()
	(interactive)
	(me/surround-with-symbol ?\)))
 "[" '(lambda ()
	(interactive)
	(me/surround-with-symbol ?\[))
 "]" '(lambda ()
	(interactive)
	(me/surround-with-symbol ?\])))

(map!
 :desc "Switch to workspace"
 :leader
 "m" #'+workspace/switch-to)

(map!
 :mode emacs-everywhere-mode
 :desc "Finish, copy and maybe paste"
 :localleader
 "," #'emacs-everywhere-finish)

(map!
 :desc "Replace expression with result"
 :leader
 "\\" 'me/eval-and-replace)

(map!
 :mode emacs-lisp-mode
 :desc "eval"
 :localleader
 :prefix "e"
 "e" 'me/eval)

(map!
 :desc "Search and rename word at..."
 :leader
 :prefix "s"
 "w" 'me/current-word-replace-in-buffer)

(map!
 :desc "Search and rename symbol at..."
 :leader
 :prefix "s"
 "e" 'me/current-symbol-replace-in-buffer)

(map!
 :mode grep-mode
 :localleader
 :desc "with editor finish"
 "," #'evil-save-modified-and-close)

(map!
 :mode grep-mode
 :localleader
 :desc "with editor cancel"
 "a" #'evil-quit)

(map!
 :mode (list git-commit-mode
	     git-rebase-mode)
 :localleader
 :desc "with editor finish"
 "," #'with-editor-finish)

(map!
 :mode (list git-commit-mode
	     git-rebase-mode)
 :localleader
 :desc "with editor cancel"
 "a" #'with-editor-cancel)

(map!
 :mode	 org-capture-mode
 :localleader
 :desc "with editor finish"
 "," #'org-capture-finalize)

(map!
 :mode	 org-capture-mode
 :localleader
 :desc "with editor cancel"
 "a" #'org-capture-kill)

(map!
 :mode	 forge-post-mode
 :localleader
 :desc "with editor finish"
 "," #'forge-post-submit)

(map!
 :mode	 forge-post-mode
 :localleader
 :desc "with editor cancel"
 "a" #'forge-post-cancel)

(map!
 :leader
 :prefix "w"
 :desc "Split vertical"
 "/" 'evil-window-vsplit)

(map!
 :leader
 :prefix "w"
 :desc "Split horizontal"
 "-" 'evil-window-split)

(map!
 :leader
 :prefix "l"
 :desc "Comment line"
 "l" 'comment-line)

(map!
 :desc "Focus treemacs windw"
 :leader
 :prefix "o"
 "o" 'treemacs-select-window)

(map!
 :desc "Open buffer in new frame"
 :leader
 :prefix "o"
 "F" 'display-buffer-other-frame)

(map!
 :desc "Jump to window"
 :leader
 "j" 'ace-window)

(map!
 :desc "Previous buffer"
 :leader
 :prefix "b"
 "TAB" #'previous-buffer)

(map!
 :desc "devdocs-lookup"
 :leader
 "k" #'devdocs-lookup)

(map!
 :desc "Insert org todo heading"
 :localleader
 :mode org-mode
 "RET" 'org-insert-todo-heading)

(map!
 :desc "Change org todo heading"
 :localleader
 :mode org-mode
 "t" 'org-todo)

(map!
 :desc "Toggle org checkbox"
 :localleader
 :mode org-mode
 "x" 'org-toggle-checkbox)

(map!
 :desc "Change org todo heading"
 :localleader
 :mode org-mode
 "'" 'org-cycle-agenda-files)

(map!
 :desc "Toggle macos theme"
 :leader
 :prefix "t"
 "t" #'(lambda ()
	 (interactive)
	 (start-process-shell-command "toggle-theme" nil "source ~/.config/zshrc; tt")))

(map!
 :desc "Print wakatime today"
 :leader
 :prefix "e"
 "w" #'me/wakatime-today)

(defun me/wakatime-today ()
  (interactive)
  (message
   (concat
    (propertize "Time code today: " 'face 'bold)
    (replace-regexp-in-string "\n" ""
			      (shell-command-to-string "wakatime-cli --today")))))
(require 'json)

(defun me/get-CPU-data ()
  (interactive)
  (let* ((json-object-type 'hash-table)
	 (json-array-type 'list)
	 (json-key-type 'symbol)
	 (cpu-data-json (json-read-from-string (shell-command-to-string "amd-cpu-data")))
	 (temperature (gethash 'temperature cpu-data-json))
	 (power (gethash 'power cpu-data-json))
	 (cpu-freq-avg (gethash 'mean-frequency cpu-data-json))
	 (cpu-freq-max (gethash 'max-frequency cpu-data-json)))
    (princ (format "Power: %iW - Temperature: %i\u2103 - Freqiency(avg): %iGHz - Freqiency(max): %iGHz"
		   power temperature cpu-freq-avg cpu-freq-max))))

(map!
 :desc "Print CPU data"
 :leader
 :prefix "e"
 "c" #'me/get-CPU-data)
