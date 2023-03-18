;;; $DOOMDIR/modules/org.el -*- lexical-binding: t; -*-

;; (require 'org-protocol)

;; setting org directory - it should be backuped somehow (for now iCloud)
(setq org-directory "~/Library/Mobile Documents/iCloud~com~appsonthemove~beorg/Documents/org")
;; (org-projectile-per-project)
;; (setq org-agenda-files (append org-agenda-files (org-projectile-todo-files)))

;; Something to add in the future maybe?
;; (add-to-list 'org-modules 'org-mac-iCal)
;; (setq org-agenda-include-diary t)

;; Something something captures

(setq org-default-notes-file
      (expand-file-name +org-capture-notes-file org-directory)
      +org-capture-journal-file
      (expand-file-name +org-capture-journal-file org-directory)
      org-capture-templates
      '(("t" "Personal todo" entry
	 (file+headline +org-capture-todo-file "Inbox")
	 "* [ ] %?\n%i\n%a" :prepend t)
	("n" "Personal notes" entry
	 (file+headline +org-capture-notes-file "Inbox")
	 "* %u %?\n%i\n%a" :prepend t)
	("j" "Journal" entry
	 (file+olp+datetree +org-capture-journal-file)
	 "* %U %?\n%i\n%a" :prepend t)

	;; Will use {project-root}/{todo,notes,changelog}.org, unless a
	;; {todo,notes,changelog}.org file is found in a parent directory.
	;; Uses the basename from `+org-capture-todo-file',
	;; `+org-capture-changelog-file' and `+org-capture-notes-file'.
	("p" "Templates for projects")
	("pt" "Project-local todo" entry  ; {project-root}/todo.org
	 (file+headline +org-capture-project-todo-file "Inbox")
	 "* TODO %?\n%i\n%a" :prepend t)
	("pn" "Project-local notes" entry  ; {project-root}/notes.org
	 (file+headline +org-capture-project-notes-file "Inbox")
	 "* %U %?\n%i\n%a" :prepend t)
	("pc" "Project-local changelog" entry  ; {project-root}/changelog.org
	 (file+headline +org-capture-project-changelog-file "Unreleased")
	 "* %U %?\n%i\n%a" :prepend t)

	;; Will use {org-directory}/{+org-capture-projects-file} and store
	;; these under {ProjectName}/{Tasks,Notes,Changelog} headings. They
	;; support `:parents' to specify what headings to put them under, e.g.
	;; :parents ("Projects")
	("o" "Centralized templates for projects")
	("ot" "Project todo" entry
	 (function +org-capture-central-project-todo-file)
	 "* TODO %?\n %i\n %a"
	 :heading "Tasks"
	 :prepend nil)
	("on" "Project notes" entry
	 (function +org-capture-central-project-notes-file)
	 "* %U %?\n %i\n %a"
	 :heading "Notes"
	 :prepend t)
	("oc" "Project changelog" entry
	 (function +org-capture-central-project-changelog-file)
	 "* %U %?\n %i\n %a"
	 :heading "Changelog"
	 :prepend t)))
