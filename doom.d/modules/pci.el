;;; pci.el -*- lexical-binding: t; -*-

;;
;; Create keybindings for the PCI app
;;

(define-minor-mode pci-mode
  "Get your foos in the right places."
  :lighter " foo"
  :keymap (make-sparse-keymap))

(evil-define-key 'normal 'pci-mode (kbd "q") #'+popup/quit-window)

(defun pci/local-stack-up (&optional service)
  (interactive)
  (pci/call-command "local-stack" "up" service "&&" "echo" "done!"))
(defun pci/local-stack-restart (&optional service)
  (interactive)
  (pci/call-command "local-stack" "restart" service "&&" "echo" "done!"))
(defun pci/local-stack-status (&optional service)
  (interactive)
  (pci/call-command "local-stack" "status" service))
(defun pci/local-stack-down ()
  (interactive)
  (pci/call-command "local-stack" "down" "&&" "echo" "done!"))
(defun pci/local-stack-build (&optional service)
  (interactive)
  (pci/call-command "local-stack" "build" service "&&" "echo" "done!"))
(defun pci/local-stack-logs (&optional service)
  (interactive)
  (pci/call-command "local-stack" "logs"))
(defun pci/local-stack-exec (&optional service)
  (interactive)
  (pci/call-command "local-stack" "down" "&&" "echo" "done!"))

(defun pci/prompt-service-name ()
  (read-from-minibuffer (propertize "Service name: " 'face '(default))))

(defun pci/call-command (command &rest arg)
  (with-output-to-temp-buffer "*pci*"
    (pop-to-buffer "*pci*")
    (setq-local process-connection-type nil)
    (async-shell-command (concat "pci" " " command " " (string-join arg " ") ) "*pci*")
    (evil-escape)
    (setq-local buffer-read-only t)
    (read-only-mode 1)
    (pci-mode)))

(defun pci/set-key-map ()
  (map!
   :desc "Restart all services"
   :leader
   :prefix "r"
   "R" #'pci/local-stack-restart)
  (map!
   :desc "Restart service"
   :leader
   :prefix "r"
   "r" '(lambda ()
	  (interactive)
	   (pci/local-stack-restart (pci/prompt-service-name))))
  (map!
   :desc "Start all service"
   :leader
   :prefix "r"
   "u" '(lambda ()
	  (interactive)
	   (pci/local-stack-up (pci/prompt-service-name))))
  (map!
   :desc "Start service"
   :leader
   :prefix "r"
   "U" 'pci/local-stack-up)
  (map!
   :desc "Stop all service"
   :leader
   :prefix "r"
   "d" 'pci/local-stack-down)
  (map!
   :desc "Show status"
   :leader
   :prefix "r"
   "S" 'pci/local-stack-status)
  (map!
   :desc "Show service status"
   :leader
   :prefix "r"
   "s" '(lambda ()
	  (interactive)
	   (pci/local-stack-status (pci/prompt-service-name))))
  (map!
   :desc "Build images"
   :leader
   :prefix "r"
   "B" 'pci/local-stack-build)
  (map!
   :desc "Build image"
   :leader
   :prefix "r"
   "b" '(lambda ()
	  (interactive)
	   (pci/local-stack-build (pci/prompt-service-name)))))

(pci/set-key-map)
