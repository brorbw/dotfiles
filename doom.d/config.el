;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!

(menu-bar-mode nil)

;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
(setq user-full-name "Bror Winther"
      user-mail-address "bbw@nobad.coffee")

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
    (setq doom-font (font-spec :family "Roboto Mono" :size 14)
          doom-variable-pitch-font (font-spec :family "Roboto Mono" :size 12))
  (setq doom-font (font-spec :family "monospace" :size 12)
        doom-variable-pitch-font (font-spec :family "monospace" :size 10)))

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)

(load! "modules/pci")
(load! "modules/custom-keymappings")
(load! "modules/home-assistant")
(load! "modules/variables")
(load! "modules/hooks")
;; (load! "modules/svg-tag-tags")
(load! "modules/sync-theme-with-system")
(load! "modules/org-settings")
(load! "modules/projectile-settings")

(load! "modules/bnf-mode")
(load! "modules/suez-mode")
(load! "modules/pw-gen")


(load! "modules/packages")

;; (add-hook! 'before-save-hook (setq-local svg-tag-mode nil))
;; (add-hook! 'after-save-hook (setq-local svg-tag-mode t))

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
