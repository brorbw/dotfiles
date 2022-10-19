;;; $DOOMDIR/modules/projectile.el -*- lexical-binding: t; -*-

(setq projectile-project-search-path '("~/Projects" "~/clearhaus"))

;; Only use this if we want the default action to be dired could be somethin
;; (setq projectile-switch-project-action #'projectile-dired)
(setq projectile-switch-project-action #'magit-status)
