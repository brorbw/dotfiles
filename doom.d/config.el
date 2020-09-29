;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
(setq user-full-name "John Doe"
      user-mail-address "john@doe.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom. Here
;; are the three important ones:
;;
;; + `doom-font'
;; + `doom-variable-pitch-font'
;; + `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;;
;; They all accept either a font-spec, font string ("Input Mono-12"), or xlfd
;; font string. You generally only need these two:
(if (eq system-type 'darwin)
  (setq doom-font (font-spec :family "Fira Code" :size 16 :weight 'semi-light)
	  doom-variable-pitch-font (font-spec :size 16))
  (setq doom-font (font-spec :family "monospace" :size 16)
	doom-variable-pitch-font (font-spec :family "monospace" :size 16))
  )

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-laserwave)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)

(defun me/surround-with-symbol (char)
  (interactive)
  (let ((bounds (bounds-of-thing-at-point 'symbol)))
    (evil-surround-region (car bounds) (cdr bounds) 'inclusive char)))

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

(setq-default evil-escape-key-sequence "fd")

(setq-default doom-localleader-key ",")

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
 :leader
 :prefix "w"
 :desc "Split vertical"
 "/" 'evil-window-vsplit)

(map!
 :leader
 :prefix "w"
 :desc "Split vertical"
 "-" 'evil-window-split)

(map!
 :leader
 :prefix "l"
 :desc "Comment line"
 "l" 'comment-line)

(map!
 :desc "Drag stuff down"
 "M-J" 'drag-stuff-down)

(map!
 :desc "Drag stuff up"
 "M-K" 'drag-stuff-up)

(map!
 :desc "Focus treemacs window"
 :leader
 :prefix "o"
 "o" 'treemacs-select-window)

(define-generic-mode 'bnf-mode
  () ;; comment char: inapplicable because # must be at start of line
  nil ;; keywords
  '(
    ("^#.*" . 'font-lock-comment-face) ;; comments at start of line
    ("^<.*?>" . 'font-lock-function-name-face) ;; LHS nonterminals
    ("<.*?>" . 'font-lock-builtin-face) ;; other nonterminals
    ("::=" . 'font-lock-const-face) ;; "goes-to" symbol
    ("\|" . 'font-lock-warning-face) ;; "OR" symbol
    ("\{:\\|:\}" . 'font-lock-keyword-face) ;; special pybnf delimiters
    )
  '("\\.bnf\\'" "\\.pybnf\\'") ;; filename suffixes
  nil ;; extra function hooks
  "Major mode for BNF highlighting.")

(setq flycheck-eslintrc "~/.eslintrc")

(setq prettier-js-args '("--use-tabs"
			 "--single-quote"
			 "--trailing-comma" "es6"))

(use-package wakatime-mode
  :hook doom-first-buffer
  :config
  (cond ((eq system-type 'darwin)
	 (setq wakatime-cli-path "/usr/local/bin/wakatime"))
	((eq system-type 'gnu/linux)
	 (setq wakatime-cli-path "/usr/bin/wakatime")))
  (global-wakatime-mode 1))

(elcord-mode)
(setq-default elcord-display-buffer-details 'nil)

(setq-default indent-tabs-mode t)
(setq treemacs-indentation 1)

(defun my-custom-indent-width (n m)
  "Setting the appropriate tab width and number"
  (setq-default tab-width m)
  (setq-default go-tab-width n)
  (setq-default standard-indent n)
  (setq-default coffee-tab-width n) ; coffeescript
  (setq-default javascript-indent-level n) ; javascript-mode
  (setq-default js-indent-level n) ; js-mode
  (setq-default js2-basic-offset n) ; js2-mode, in latest js2-mode, it's alias of js-indent-level
  (setq-default web-mode-markup-indent-offset n) ; web-mode, html tag in html file
  (setq-default web-mode-css-indent-offset n) ; web-mode, css in html file
  (setq-default web-mode-code-indent-offset n) ; web-mode, js code in html file
  (setq-default react-indent-level n)
  (setq-default web-mode-indent-style n)
  (setq-default css-indent-offset n)) ; css-mode
(my-custom-indent-width 2 2)

(after! ace-window
  (setq aw-keys '(?a ?s ?d ?f ?g ?h ?j ?k ?l)))

;; Here are some additional functions/macros that could help you configure Doom:
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   '("e074be1c799b509f52870ee596a5977b519f6d269455b84ed998666cf6fc802a" default)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
