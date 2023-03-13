;;; $DOOMDIR/change-color-based-on-project-name.el -*- lexical-binding: t; -*-

(setq-default home-assistant/url "https://ha.nobad.coffee/api/services/light/turn_on")
(setq-default home-assistant/path-to-token "~/.ha-token")
(setq-default home-assistant/entity-id "light.wiz_rgbw_tunable_47bcd8")
(setq-default home-assistant/default-color '(255 0 50))

(defun home-assistant/string-trim-final-newline (string)
  (let ((len (length string)))
    (cond
     ((and (> len 0) (eql (aref string (- len 1)) ?\n))
      (substring string 0 (- len 1)))
     (t string))))

(defun home-assistant/change-color (&optional rgb)
  (interactive)
  (if (called-interactively-p 'any)
      (home-assistant/send-request (read-from-minibuffer (propertize "RED: " 'face '(default)))
				   (read-from-minibuffer (propertize "GREEN: " 'face '(default)))
				   (read-from-minibuffer (propertize "BLUE: " 'face '(default))))
    (home-assistant/send-request (nth 0 rgb) (nth 1 rgb) (nth 2 rgb))))

(defun home-assistant/send-request (r g b)
  (request home-assistant/url
    :type "POST"
    :headers `(("Content-Type" . "application/json")
	       ("Authorization" . ,(concat "Bearer " (home-assistant/string-trim-final-newline (f-read-text home-assistant/path-to-token)))))
    ;; :parser 'json-read
    ;; :encoding 'utf-8
    :error
    (cl-function (lambda (&rest args &key error-thrown &allow-other-keys)
		   (message "Got error: %S" error-thrown)))
    :data (json-encode `(("entity_id" . ,home-assistant/entity-id)
			 ("rgb_color" . (,r ,g ,b))))))

(defun home-assistant/project-hook ()
  (if home-assistant/enabled
      (if (file-exists-p (concat (doom-project-root) ".color"))
	  (home-assistant/change-color
	   (read (f-read-text (concat (doom-project-root) ".color"))))
	(message "No .color found in project root. Using default color")
	(home-assistant/change-color home-assistant/default-color)))

(defun home-assistant/is-enabled ()
  (if home-assistant/enabled "enabled" "disabled"))

(defun home-assistant/toggle (&optional val)
  (interactive)
  (if (boundp 'val)
      (progn
	(setq home-assistant/enabled val)
	(message (concat "Change color is: " (home-assistant/is-enabled))))
    (progn
      (setq home-assistant/enabled (not home-assistant/enabled))
      (message (concat "Change color is: " (home-assistant/is-enabled))))))

(add-hook! 'projectile-after-switch-project-hook #'home-assistant/project-hook)
(add-hook! 'doom-switch-buffer-hook #'home-assistant/project-hook)
