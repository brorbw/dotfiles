;;; variables.el -*- lexical-binding: t; -*-

;; autofill in comments
(auto-fill-mode 1)
(setq comment-auto-fill-only-comments t)

;; Probably git stuff
(setq auth-sources '("~/.authinfo.gpg"))
(setq magit-revision-show-gravatars '("^Author:     " . "^Commit:     "))
(setq flycheck-eslintrc "~/.config/eslintrc")

(global-subword-mode)

(setq atomic-chrome-buffer-open-style 'frame)
(setq atomic-chrome-default-major-mode 'markdown-mode)
(atomic-chrome-start-server)

(if (eq system-type 'darwin)
(use-package wakatime-mode
  :hook doom-first-buffer
  :config
  (setq wakatime-cli-path "/usr/local/bin/wakatime-cli")
  (global-wakatime-mode 1)))

(setq rbenv-executable "/usr/local/opt/rbenv/bin/rbenv")

(setq prettier-js-args '("--use-tabs" "true"
			 "--single-quote" "true"
			 "--trailing-comma" "all" "es6"))

(setq-default tab-width 2)
(setq-default indent-tabs-mode t)
(setq! treemacs-indentation 1)

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
;;   (set-lsp-priority! 'ccls 2)) ; optional as ccls is the

(setq! +ligatures-in-modes '(elisp-mode))
