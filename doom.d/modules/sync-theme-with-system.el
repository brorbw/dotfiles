;;; $DOOMDIR/modules/sync-theme-with-system.el -*- lexical-binding: t; -*-

(defcustom me/dark-theme-name
  'doom-moonlight
  "Dark theme value")
(defcustom me/light-theme-name
  'doom-solarized-light
  "Light theme value")

(defun me/apply-theme (appearance)
  "Load theme taking the systems current appearance into consideration."
  (message "theme changed" appearance)
  (mapc #'disable-theme custom-enabled-themes)
  (pcase appearance
    ('light (load-theme me/light-theme-name t))
    ('dark (load-theme me/dark-theme-name t))))

(add-hook 'ns-system-appearance-change-functions #'me/apply-theme)

(defun me/load-theme-when-booted ()
(pcase ns-system-appearance
('light (load-theme me/light-theme-name t))
('dark (load-theme me/dark-theme-name t))))

(me/load-theme-when-booted)
