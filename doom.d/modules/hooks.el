;;; $DOOMDIR/modules/hooks.el -*- lexical-binding: t; -*-

(defun my-php-mode-hook ()
  "My PHP mode configuration."
  (setq indent-tabs-mode t
        tab-width 2
        c-basic-offset 2))
(add-hook! 'php-mode-hook 'my-php-mode-hook)
(add-hook! 'php-mode-wordpress-hook 'my-php-mode-hook)
(add-hook! 'ruby-mode-hook (setq-local devdocs-current-docs '("ruby~2.7")))
;; (add-hook! 'sh-mode-hook (setq-local indent-tabs-mode nil))
(add-hook! 'rjsx-mode-hook (setq-local indent-tabs-mode t))
;; (add-hook! 'pdf-view-mode-hook #'pdf-view-midnight-minor-mode)
