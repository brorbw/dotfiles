;;; $DOOMDIR/modules/variables.el -*- lexical-binding: t; -*-

;; autofill in comments
(auto-fill-mode 1)
(setq comment-auto-fill-only-comments t)
(global-subword-mode)
(global-whitespace-mode)
(setq whitespace-line-column 150)

;; Probably git stuff
(setq auth-sources '("~/.authinfo.gpg"))
(setq magit-revision-show-gravatars '("^Author:     " . "^Commit:     "))

(setq flycheck-eslintrc "~/.config/eslintrc")


(setq atomic-chrome-buffer-open-style 'frame)
(setq atomic-chrome-default-major-mode 'markdown-mode)
(atomic-chrome-start-server)

(if (eq system-type 'darwin)
    (use-package! wakatime-mode
      :hook doom-first-buffer
      :config
      (setq wakatime-cli-path "/usr/local/bin/wakatime-cli")
      (global-wakatime-mode 1)))

(setq rbenv-executable "/usr/local/opt/rbenv/bin/rbenv")

(setq prettier-js-args '("--use-tabs" "true"
			 "--single-quote" "true"
			 "--trailing-comma" "all" "es6"))

(setq-default indent-tabs-mode t)
(setq-default tab-width 2)
(setq-default rust-indent-offset 4) ;; fucking rust
(setq! treemacs-indentation 1)

(add-hook! 'sh-mode-hook (setq-local indent-tabs-mode t))

(setq avy-all-windows t)
(after! ace-window
  (setq aw-keys '(?a ?s ?d ?f ?g ?h ?j ?k ?l)))


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
;;   (set-lsp-priority! 'ccls 2))

(setq! +ligatures-in-modes '(elisp-mode))

;; (setq! pdf-view-midnight-colors `(
;; 				  ,(car (cdr (doom-themes--colors-p 'fg))) .
;; 				  ,(car (cdr (doom-themes--colors-p 'bg)))))

(setq magit-repository-directories
      `(("~/clearhaus" . 1)
	("~/Projects" . 1)))

;; nginx mode
(add-to-list 'auto-mode-alist '("/nginx/sites-\\(?:available\\|enabled\\)/" . nginx-mode))

;; make code review use forge api key
(setq code-review-auth-login-marker 'forge)

(add-hook 'code-review-mode-hook
	  (lambda ()
	    ;; include *Code-Review* buffer into current workspace
	    (persp-add-buffer (current-buffer))))

(setq home-assistant/enabled t)
