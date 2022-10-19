;;; $DOOMDIR/modules/pci.el -*- lexical-binding: t; -*-

;;
;; Create keybindings for the PCI app
;;

(define-minor-mode pci-mode
  "Get your foos in the right places."
  :lighter " PCI"
  :keymap (make-sparse-keymap))

(evil-define-key 'normal 'pci-mode (kbd "q") #'kill-current-buffer)

(defun pci/transaction-auth ()
  (interactive)
  (pci/call-command-json "transaction" "auth" (pci/prompt-env-name)))

(defun pci/transaction-void ()
  (interactive)
  (pci/call-command-json "transaction" "void" (pci/prompt-env-name)))

(defun pci/transaction-capture ()
  (interactive)
  (pci/call-command-json "transaction" "capture" (pci/prompt-env-name)))

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
  (pci/call-command "local-stack" "down" "&&" "echo" "done!"))

(defun pci/local-stack-stop (&optional service)
  (pci/call-command "local-stack" "stop" service "&&" "echo" "done!"))

(defun pci/local-stack-build (&optional service)
  (interactive)
  (pci/call-command "local-stack" "build" service "&&" "echo" "done!"))

(defun pci/local-stack-logs (&optional service)
  (interactive)
  (pci/call-command-with-tty "local-stack" "logs" service))

(defun pci/local-stack-exec (service)
  (pci/call-command "local-stack" "exec" service
		    (read-from-minibuffer
		     (propertize "Executable: " 'face '(default)))))

(defun pci/local-stack-shell (service)
  (pci/call-command-with-tty "local-stack" "shell" service))

(defun pci/prompt-env-name ()
  (completing-read (propertize "Env:" 'face '(default))
		   '("local" "test" "stag" "prod")))

(defun pci/prompt-service-name ()
  (completing-read
   (propertize "Service: " 'face '(default))
   (read
    (concat
     "("
     (shell-command-to-string "pci local-stack list")
     ")"))))

(defun pci/call-command-with-tty (command &rest arg)
  (with-output-to-temp-buffer "*pci-term*"
    (pop-to-buffer "*pci-term*")
    (setq-local process-connection-type 'pty)
    (async-shell-command (concat "pci" " " command " " (string-join arg " ") ) "*pci-term*")
    (evil-escape)
    (pci-mode)))

(defun pci/call-command (command &rest arg)
  (with-output-to-temp-buffer "*pci*"
    (pop-to-buffer "*pci*")
    (setq-local process-connection-type nil)
    (async-shell-command (concat "pci" " " command " " (string-join arg " ") ) "*pci*")
    (evil-escape)
    (setq-local buffer-read-only t)
    (read-only-mode 1)
    (pci-mode)))

(defun pci/call-command-json (command &rest arg)
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
   :desc "auth"
   :leader
   :prefix "r t"
   "a" #'pci/transaction-auth)

  (map!
   :desc "void"
   :leader
   :prefix "r t"
   "v" #'pci/transaction-void)

  (map!
   :desc "capture"
   :leader
   :prefix "r t"
   "c" #'pci/transaction-capture)

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
   :desc "Start a service"
   :leader
   :prefix "r"
   "u" '(lambda ()
	  (interactive)
	   (pci/local-stack-up (pci/prompt-service-name))))

  (map!
   :desc "Start all services"
   :leader
   :prefix "r"
   "U" 'pci/local-stack-up)

  (map!
   :desc "Stop a service"
   :leader
   :prefix "r"
   "d" '(lambda ()
	  (interactive)
	   (pci/local-stack- (pci/prompt-service-name))))

  (map!
   :desc "Down all services"
   :leader
   :prefix "r"
   "D" 'pci/local-stack-down)

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
	   (pci/local-stack-build (pci/prompt-service-name))))
  (map!
   :desc "Exec"
   :leader
   :prefix "r"
   "E" '(lambda ()
	  (interactive)
	   (pci/local-stack-exec (pci/prompt-service-name))))
  (map!
   :desc "Shell"
   :leader
   :prefix "r"
   "e" '(lambda ()
	  (interactive)
	   (pci/local-stack-shell (pci/prompt-service-name))))
  (map!
   :desc "Logs for all"
   :leader
   :prefix "r"
   "L" 'pci/local-stack-logs)
  (map!
   :desc "Logs for container"
   :leader
   :prefix "r"
   "l" '(lambda ()
	  (interactive)
	  (pci/local-stack-logs (pci/prompt-service-name)))))

(pci/set-key-map)
