;;; $DOOMDIR/modules/sync-theme-with-system.el -*- lexical-binding: t; -*-
(defcustom me/dark-theme
  'doom-moonlight
  "Dark theme value")
(defcustom me/light-theme
  'doom-nord-light
  "Light theme value")

(defcustom me/tty-theme
  'doom-one
  "Dark theme for tty")

;; set theme for tty sessions
(unless (display-graphic-p)
  (setq doom-theme me/tty-theme))

;; set theme for macos
(when (eq system-type 'darwin)
  (defun me/apply-theme (appearance)
    "Load theme taking the systems current appearance into consideration."
    (message "theme changed" appearance)
    (mapc #'disable-theme custom-enabled-themes)
    (pcase appearance
      ('light (load-theme me/light-theme t))
      ('dark (load-theme me/dark-theme t))))

  (add-hook 'ns-system-appearance-change-functions #'me/apply-theme)

  (defun me/load-theme-when-booted ()
    (pcase ns-system-appearance
      ('light (load-theme me/light-theme t))
      ('dark (load-theme me/dark-theme t))))

  (me/load-theme-when-booted))
