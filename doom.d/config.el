;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!

(menu-bar-mode 1)

;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
(setq user-full-name "Bror Winther"
      user-mail-address "emacs@nobad.coffee")

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
    (setq doom-font (font-spec :family "Fira Code" :size 14 :weight 'normal)
          doom-variable-pitch-font (font-spec :family "Fira Code" :size 10))
  (setq doom-font (font-spec :family "monospace" :size 14)
        doom-variable-pitch-font (font-spec :family "monospace" :size 10)))

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(if (not (display-graphic-p))
    (setq doom-theme 'doom-nord)
  (setq doom-theme 'doom-moonlight))

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")
(org-projectile-per-project)
(setq org-agenda-files (append org-agenda-files (org-projectile-todo-files)))
;; (setq org-projectile-per-project-filepath (concat (projectile-project-name) ".org"))

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)


(load! "modules/pci")

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

(defun me/eval-and-replace ()
  "Replace the preceding sexp with its value."
  (interactive)
  (up-list)
  (backward-char)
  (let ((value (eval (elisp--preceding-sexp))))
    (backward-up-list)
    (mark-sexp)
    (kill-sexp)
    (insert (format "%S" value))))

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
  (interactive "r")
  (evil-multiedit-ex-match
   (point-min) (point-max)
   t (concat "\\_<" (regexp-quote (thing-at-point 'symbol t)) "\\_>")))

(defun me/current-word-replace-in-buffer ()
  (interactive)
  (evil-multiedit-ex-match
   (point-min) (point-max)
   t (regexp-quote (thing-at-point 'word t))))

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

(add-hook! 'pdf-view-mode-hook #'pdf-view-midnight-minor-mode)


(setq rbenv-executable "/usr/local/opt/rbenv/bin/rbenv")

;; autofill in comments
(auto-fill-mode 1)
(setq comment-auto-fill-only-comments t)

;; Probably git stuff
(setq auth-sources '("~/.authinfo.gpg"))
(setq magit-revision-show-gravatars '("^Author:     " . "^Commit:     "))

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

(setq flycheck-eslintrc "~/.config/eslintrc")

(setq global-subword-mode t)

(setq prettier-js-args '("--use-tabs" "true"
			 "--single-quote" "true"
			 "--trailing-comma" "all" "es6"))
(if (eq system-type 'darwin)
(use-package wakatime-mode
  :hook doom-first-buffer
  :config
  (setq wakatime-cli-path "/usr/local/bin/wakatime-cli")
  (global-wakatime-mode 1)))

(defun me/yabai-get-current-space ()
  (let  ((space (shell-command-to-string "yabai -m query --displays --display | jq -r '.index'")))
    (string-trim-right space)))

(defun me/yabai-move-current-window-to-space (space)
  (shell-command (format "yabai -m window --display %i; yabai -m display --focus %i" space space)))

(defun me/yabai-toggle ()
  (shell-command "yabai -m window --toggle float"))

(defun me/atomic-chrome-move-window-hook-fun ()
  (let ((space (me/yabai-get-current-space)))
    (add-hook! 'atomic-chrome-edit-mode-hook :local
     (me/yabai-move-current-window-to-space space))))



(setq atomic-chrome-buffer-open-style 'frame)
(setq atomic-chrome-default-major-mode 'markdown-mode)
(atomic-chrome-start-server)

(defun my-php-mode-hook ()
  "My PHP mode configuration."
  (setq indent-tabs-mode t
        tab-width 2
        c-basic-offset 2))
(add-hook! 'php-mode-hook 'my-php-mode-hook)
(add-hook! 'php-mode-wordpress-hook 'my-php-mode-hook)

(add-hook! 'ruby-mode-hook (setq-local devdocs-current-docs '("ruby~2.7")))

(setq-default tab-width 2)
(setq-default indent-tabs-mode t)
(add-hook! 'sh-mode-hook (setq-local indent-tabs-mode nil))
(add-hook! 'rjsx-mode-hook (setq-local indent-tabs-mode t))
(setq! treemacs-indentation 1)

(setq! +ligatures-in-modes '(elisp-mode))
;; not formatting on save in c-mode
(setq +format-on-save-enabled-modes
      '(not c-mode
	    ruby-mode))

;; (setq lsp-clients-clangd-args '("-j=3"
;;                                 "--background-index"
;;                                 "--clang-tidy"
;;                                 "--completion-style=detailed"
;;                                 "--header-insertion=never"
;;                                 "--header-insertion-decorators=0"))
;; (after! lsp-clangd (set-lsp-priority! 'clangd 2))

(setq lsp-clients-clangd-args '("-j=3"
				"--all-scopes-completion"
                                "--background-index"
                                "--clang-tidy"
                                "--completion-style=detailed"
                                "--header-insertion=iwyu"
                                "--header-insertion-decorators=0"))
(after! lsp-clangd (set-lsp-priority! 'clangd 2))

;; (after! ccls
;;   (setq ccls-initialization-options '(:index (:comments 2) :completion (:detailedLabel t)))
;;   (set-lsp-priority! 'ccls 2)) ; optional as ccls is the

;; disable magit keys in forge-topic
;; (add-hook! 'forge-topic-mode-hook #'evil-collection-magit-toggle-text-mode)

;; (use-package blamer
;;   :bind (("s-i" . blamer-show-commit-info))
;;   :defer 20
;;   :custom
;;   (blamer-idle-time 0.3)
;;   (blamer-min-offset 70)
;;   :custom-face
;;   (blamer-face ((t :foreground "#7a88cf"
;;                     :background nil
;;                     :height 140
;;                     :italic t)))
;;   :config
;;   (global-blamer-mode 1))

(setq avy-all-windows t)
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
