;; -*- mode: emacs-lisp; lexical-binding: t -*-
;; This file is loaded by Spacemacs at startup.
;; It must be stored in your home directory.

(defun dotspacemacs/layers ()
  "Configuration Layers declaration.
You should not put any user code in this function besides modifying the variable
values."
  (setq-default
   ;; Base distribution to use. This is a layer contained in the directory
   ;; `+distribution'. For now available distributions are `spacemacs-base'
   ;; or `spacemacs'. (default 'spacemacs)
   dotspacemacs-distribution 'spacemacs
   ;; Lazy installation of layers (i.e. layers are installed only when a file
   ;; with a supported type is opened). Possible values are `all', `unused'
   ;; and `nil'. `unused' will lazy install only unused layers (i.e. layers
   ;; not listed in variable `dotspacemacs-configuration-layers'), `all' will
   ;; lazy install any layer that support lazy installation even the layers
   ;; listed in `dotspacemacs-configuration-layers'. `nil' disable the lazy
   ;; installation feature and you have to explicitly list a layer in the
   ;; variable `dotspacemacs-configuration-layers' to install it.
   ;; (default 'unused)
   dotspacemacs-enable-lazy-installation 'unused
   ;; If non-nil then Spacemacs will ask for confirmation before installing
   ;; a layer lazily. (default t)
   dotspacemacs-ask-for-lazy-installation t
   ;; If non-nil layers with lazy install support are lazy installed.
   ;; List of additional paths where to look for configuration layers.
   ;; Paths must have a trailing slash (i.e. `~/.mycontribs/')
   dotspacemacs-configuration-layer-path '()
   ;; List of configuration layers to load.
   dotspacemacs-configuration-layers
   '(
     yaml
     ansible
     nginx
		 common-lisp
		 ruby
     csv
		 scheme

		 docker
     nginx
     ansible

		 ;; Web dev
     (javascript :variables
		 						 javascript-import-tool 'import-js
		 						 javascript-fmt-tool 'prettier
		 						 javascript-fmt-on-save t
		 						 node-add-modules-path t
		 						 js2-include-node-externs t
								 javascript-disable-tern-port-files nil
								 tern-comand '("node", "/Users/brorwinther/.node_modules/bin/tern"))
								 javascript-backend 'lsp
     ;; yaml
     octave
     html
		 react

     python
		 emacs-lisp

		 (go :variables
				 go-format-before-save t
				 ;; go-backend 'go-mod
				 godoc-at-point-function 'godoc-gogetdoc)

     (scala :variables scala-backend 'scala-metals)
     ;; ----------------------------------------------------------------
     ;; Example of useful layers you may want to use right away.
     ;; Uncommon some layer names and press <SPC f e R> (Vim style) or
     ;; <M-m f e R> (Emacs style) to install them.
     ;; ----------------------------------------------------------------

     latex
		 shell-scripts

		 ivy

		 git
     markdown

		 ;; c-c++ dev
		 (c-c++ :variables
						c-c++-adopt-subprojects t
						c-c++-backend 'lsp-ccls
						c-c++-lsp-enable-semantic-highlight 'rainbow)
     cscope
		 gtags

     ;; plantuml

		 emoji

     (shell :variables
            shell-default-shell 'shell
            shell-default-height 30
            shell-default-position 'top)

		 ;; Autocomplete spellcheck syntax
		 (auto-completion :variables
		 									auto-completion-enable-sort-by-usage t
		 									auto-completion-enable-snippets-in-popup t
		 									auto-completion-enable-help-tooltip t
											auto-completion-complete-with-key-sequence "jk"
											auto-completion-tab-key-behavior 'cycle
											auto-completion-return-key-behavior 'complete)
     (spell-checking :variables
                     spell-checking-enable-by-default nil)
     semantic
		 syntax-checking
     xkcd
		 ;; org
     ;; org

     ;; Themes
     themes-megapack
		 ;; Wekatime
     (wakatime :variables
            wakatime-api-key  "03771d24-8c20-4b1a-a4a1-8ab46b33f333"
               ;; use the actual wakatime path
            wakatime-cli-path "/usr/bin/wakatime")
     ;; version-control
     )
   ;; List of additional packages that will be installed without being
   ;; wrapped in a layer. If you need some configuration for these
   ;; packages, then consider creating a layer. You can also put the
   ;; configuration in `dotspacemacs/user-config'.
   dotspacemacs-additional-packages
   '(
		 ;; nodejs-repl
		 prettier-js
		 tern-auto-complete
		 )
   ;; A list of packages that cannot be updated.
   dotspacemacs-frozen-packages '()
   ;; A list of packages that will not be installed and loaded.
   dotspacemacs-excluded-packages '(
																		org-projectile
																		)
   ;; Defines the behaviour of Spacemacs when installing packages.
   ;; Possible values are `used-only', `used-but-keep-unused' and `all'.
   ;; `used-only' installs only explicitly used packages and uninstall any
   ;; unused packages as well as their unused dependencies.
   ;; `used-but-keep-unused' installs only the used packages but won't uninstall
   ;; them if they become unused. `all' installs *all* packages supported by
   ;; Spacemacs and never uninstall them. (default is `used-only')
   dotspacemacs-install-packages 'used-only))

(defun dotspacemacs/init ()
  "Initialization function.
This function is called at the very startup of Spacemacs initialization
before layers configuration.
You should not put any user code in there besides modifying the variable
values."
  ;; This setq-default sexp is an exhaustive list of all the supported
  ;; spacemacs settings.
  (setq-default
   ;; If non nil ELPA repositories are contacted via HTTPS whenever it's
   ;; possible. Set it to nil if you have no way to use HTTPS in your
   ;; environment, otherwise it is strongly recommended to let it set to t.
   ;; This variable has no effect if Emacs is launched with the parameter
   ;; `--insecure' which forces the value of this variable to nil.
   ;; (default t)
   dotspacemacs-elpa-https t
   ;; Maximum allowed time in seconds to contact an ELPA repository.
   dotspacemacs-elpa-timeout 300
   ;; If non nil then spacemacs will check for updates at startup
   ;; when the current branch is not `develop'. Note that checking for
   ;; new versions works via git commands, thus it calls GitHub services
   ;; whenever you start Emacs. (default nil)
   dotspacemacs-check-for-update nil
   ;; If non-nil, a form that evaluates to a package directory. For example, to
   ;; use different package directories for different Emacs versions, set this
   ;; to `emacs-version'.
   dotspacemacs-elpa-subdirectory nil
   ;; One of `vim', `emacs' or `hybrid'.
   ;; `hybrid' is like `vim' except that `insert state' is replaced by the
   ;; `hybrid state' with `emacs' key bindings. The value can also be a list
   ;; with `:variables' keyword (similar to layers). Check the editing styles
   ;; section of the documentation for details on available variables.
   ;; (default 'vim)
   dotspacemacs-editing-style 'vim
   ;; If non nil output loading progress in `*Messages*' buffer. (default nil)
   dotspacemacs-verbose-loading nil
   ;; Specify the startup banner. Default value is `official', it displays
   ;; the official spacemacs logo. An integer value is the index of text
   ;; banner, `random' chooses a random text banner in `core/banners'
   ;; directory. A string value must be a path to an image format supported
   ;; by your Emacs build.
   ;; If the value is nil then no banner is displayed. (default 'official)
   dotspacemacs-startup-banner 'official
   ;; List of items to show in startup buffer or an association list of
   ;; the form `(list-type . list-size)`. If nil then it is disabled.
   ;; Possible values for list-type are:
   ;; `recents' `bookmarks' `projects' `agenda' `todos'."
   ;; List sizes may be nil, in which case
   ;; `spacemacs-buffer-startup-lists-length' takes effect.
   dotspacemacs-startup-lists '((recents . 5)
                                (projects . 7)
                                (todos . 5)
                                (agenda . 5))
   ;; True if the home buffer should respond to resize events.
   dotspacemacs-startup-buffer-responsive t
   ;; Default major mode of the scratch buffer (default `text-mode')
   dotspacemacs-scratch-mode 'text-mode
   ;; List of themes, the first of the list is loaded when spacemacs starts.
   ;; Press <SPC> T n to cycle to the next theme in the list (works great
   ;; with 2 themes variants, one dark and one light)
   dotspacemacs-themes '(wombat
												 dichromacy
												 monokai
												 espresso
												 flatland)
                         )
   ;; Set the theme for the Spaceline. Supported themes are `spacemacs',
   ;; `all-the-icons', `custom', `vim-powerline' and `vanilla'. The first three
   ;; are spaceline themes. `vanilla' is default Emacs mode-line. `custom' is a
   ;; user defined themes, refer to the DOCUMENTATION.org for more info on how
   ;; to create your own spaceline theme. Value can be a symbol or list with\
   ;; additional properties.
   ;; (default '(spacemacs :separator wave :separator-scale 1.5))
   dotspacemacs-mode-line-theme '(spacemacs :separator wave :separator-scale 1)
   ;; If non nil the cursor color matches the state color in GUI Emacs.
   dotspacemacs-colorize-cursor-according-to-state t
   ;; Default font, or prioritized list of fonts. `powerline-scale' allows to
   ;; quickly tweak the mode-line size to make separators look not too crappy.
   dotspacemacs-default-font '("Fira Code"
                               :size 18
                               :weight regular
                               :width normal
                               :powerline-scale 1)
   ;; The leader key
   dotspacemacs-leader-key "SPC"
   ;; The key used for Emacs commands (M-x) (after pressing on the leader key).
   ;; (default "SPC")
   dotspacemacs-emacs-command-key "SPC"
   ;; The key used for Vim Ex commands (default ":")
   dotspacemacs-ex-command-key ":"
   ;; The leader key accessible in `emacs state' and `insert state'
   ;; (default "M-m")
   dotspacemacs-emacs-leader-key "M-m"
   ;; Major mode leader key is a shortcut key which is the equivalent of
   ;; pressing `<leader> m`. Set it to `nil` to disable it. (default ",")
   dotspacemacs-major-mode-leader-key ","
   ;; Major mode leader key accessible in `emacs state' and `insert state'.
   ;; (default "C-M-m")
   dotspacemacs-major-mode-emacs-leader-key "C-M-m"
   ;; These variables control whether separate commands are bound in the GUI to
   ;; the key pairs C-i, TAB and C-m, RET.
   ;; Setting it to a non-nil value, allows for separate commands under <C-i>
   ;; and TAB or <C-m> and RET.
   ;; In the terminal, these pairs are generally indistinguishable, so this only
   ;; works in the GUI. (default nil)
   dotspacemacs-distinguish-gui-tab nil
   ;; If non nil `Y' is remapped to `y$' in Evil states. (default nil)
   dotspacemacs-remap-Y-to-y$ nil
   ;; If non-nil, the shift mappings `<' and `>' retain visual state if used
   ;; there. (default t)
   dotspacemacs-retain-visual-state-on-shift t
   ;; If non-nil, J and K move lines up and down when in visual mode.
   ;; (default nil)
   dotspacemacs-visual-line-move-text nil
   ;; If non nil, inverse the meaning of `g' in `:substitute' Evil ex-command.
   ;; (default nil)
   dotspacemacs-ex-substitute-global nil
   ;; Name of the default layout (default "Default")
   dotspacemacs-default-layout-name "Default"
   ;; If non nil the default layout name is displayed in the mode-line.
   ;; (default nil)
   dotspacemacs-display-default-layout nil
   ;; If non nil then the last auto saved layouts are resume automatically upon
   ;; start. (default nil)
   dotspacemacs-auto-resume-layouts nil
   ;; Size (in MB) above which spacemacs will prompt to open the large file
   ;; literally to avoid performance issues. Opening a file literally means that
   ;; no major mode or minor modes are active. (default is 1)
   dotspacemacs-large-file-size 1
   ;; Location where to auto-save files. Possible values are `original' to
   ;; auto-save the file in-place, `cache' to auto-save the file to another
   ;; file stored in the cache directory and `nil' to disable auto-saving.
   ;; (default 'cache)
   dotspacemacs-auto-save-file-location 'cache
   ;; Maximum number of rollback slots to keep in the cache. (default 5)
   dotspacemacs-max-rollback-slots 5
   ;; If non nil, `helm' will try to minimize the space it uses. (default nil)
   dotspacemacs-helm-resize nil
   ;; if non nil, the helm header is hidden when there is only one source.
   ;; (default nil)
   dotspacemacs-helm-no-header nil
   ;; define the position to display `helm', options are `bottom', `top',
   ;; `left', or `right'. (default 'bottom)
   dotspacemacs-helm-position 'bottom
   ;; Controls fuzzy matching in helm. If set to `always', force fuzzy matching
   ;; in all non-asynchronous sources. If set to `source', preserve individual
   ;; source settings. Else, disable fuzzy matching in all sources.
   ;; (default 'always)
   dotspacemacs-helm-use-fuzzy 'always
   ;; If non nil the paste micro-state is enabled. When enabled pressing `p`
   ;; several times cycle between the kill ring content. (default nil)
   dotspacemacs-enable-paste-transient-state nil
   ;; Which-key delay in seconds. The which-key buffer is the popup listing
   ;; the commands bound to the current keystroke sequence. (default 0.4)
   dotspacemacs-which-key-delay 0.2
   ;; Which-key frame position. Possible values are `right', `bottom' and
   ;; `right-then-bottom'. right-then-bottom tries to display the frame to the
   ;; right; if there is insufficient space it displays it at the bottom.
   ;; (default 'bottom)
   dotspacemacs-which-key-position 'bottom
   ;; If non nil a progress bar is displayed when spacemacs is loading. This
   ;; may increase the boot time on some systems and emacs builds, set it to
   ;; nil to boost the loading time. (default t)
   dotspacemacs-loading-progress-bar t
   ;; If non nil the frame is fullscreen when Emacs starts up. (default nil)
   ;; (Emacs 24.4+ only)
   dotspacemacs-fullscreen-at-startup nil
   ;; If non nil `spacemacs/toggle-fullscreen' will not use native fullscreen.
   ;; Use to disable fullscreen animations in OSX. (default nil)
   dotspacemacs-fullscreen-use-non-native nil
   ;; If non nil the frame is maximized when Emacs starts up.
   ;; Takes effect only if `dotspacemacs-fullscreen-at-startup' is nil.
   ;; (default nil) (Emacs 24.4+ only)
   dotspacemacs-maximized-at-startup nil
   ;; A value from the range (0..100), in increasing opacity, which describes
   ;; the transparency level of a frame when it's active or selected.
   ;; Transparency can be toggled through `toggle-transparency'. (default 90)
   dotspacemacs-active-transparency 90
   ;; A value from the range (0..100), in increasing opacity, which describes
   ;; the transparency level of a frame when it's inactive or deselected.
   ;; Transparency can be toggled through `toggle-transparency'. (default 90)
   dotspacemacs-inactive-transparency 90
   ;; If non nil show the titles of transient states. (default t)
   dotspacemacs-show-transient-state-title t
   ;; If non nil show the color guide hint for transient state keys. (default t)
   dotspacemacs-show-transient-state-color-guide t
   ;; If non nil unicode symbols are displayed in the mode line. (default t)
   dotspacemacs-mode-line-unicode-symbols t
   ;; If non nil smooth scrolling (native-scrolling) is enabled. Smooth
   ;; scrolling overrides the default behavior of Emacs which recenters point
   ;; when it reaches the top or bottom of the screen. (default t)
   dotspacemacs-smooth-scrolling t
   ;; Control line numbers activation.
   ;; If set to `t' or `relative' line numbers are turned on in all `prog-mode' and
   ;; `text-mode' derivatives. If set to `relative', line numbers are relative.
   ;; This variable can also be set to a property list for finer control:
   ;; '(:relative nil
   ;;   :disabled-for-modes dired-mode
   ;;                       doc-view-mode
   ;;                       markdown-mode
   ;;                       org-mode
   ;;                       pdf-view-mode
   ;;                       text-mode
   ;;   :size-limit-kb 1000)
   ;; (default nil)
   dotspacemacs-line-numbers t
   ;; Code folding method. Possible values are `evil' and `origami'.
   ;; (default 'evil)
   dotspacemacs-folding-method 'evil
   ;; If non-nil smartparens-strict-mode will be enabled in programming modes.
   ;; (default nil)
   dotspacemacs-smartparens-strict-mode nil
   ;; If non-nil pressing the closing parenthesis `)' key in insert mode passes
   ;; over any automatically added closing parenthesis, bracket, quote, etc…
   ;; This can be temporary disabled by pressing `C-q' before `)'. (default nil)
   dotspacemacs-smart-closing-parenthesis nil
   ;; Select a scope to highlight delimiters. Possible values are `any',
   ;; `current', `all' or `nil'. Default is `all' (highlight any scope and
   ;; emphasis the current one). (default 'all)
   dotspacemacs-highlight-delimiters 'all
   ;; If non nil, advise quit functions to keep server open when quitting.
   ;; (default nil)
   dotspacemacs-persistent-server nil
   ;; List of search tool executable names. Spacemacs uses the first installed
   ;; tool of the list. Supported tools are `ag', `pt', `ack' and `grep'.
   ;; (default '("ag" "pt" "ack" "grep"))
   dotspacemacs-search-tools '("ag" "pt" "ack" "grep")
   ;; The default package repository used if no explicit repository has been
   ;; specified with an installed package.
   ;; Not used for now. (default nil)
   dotspacemacs-default-package-repository nil
   ;; Delete whitespace while saving buffer. Possible values are `all'
   ;; to aggressively delete empty line and long sequences of whitespace,
   ;; `trailing' to delete only the whitespace at end of lines, `changed'to
   ;; delete only whitespace for changed lines or `nil' to disable cleanup.
   ;; (default nil)
   dotspacemacs-whitespace-cleanup 'trailing
   ))

(defun dotspacemacs/user-init ()
(setq ispell-program-name "/usr/local/bin/aspell")
  "Initialization function for user code.
It is called immediately after `dotspacemacs/init', before layer configuration
executes.
 This function is mostly useful for variables that need to be set
before packages are loaded. If you are unsure, you should try in setting them in
`dotspacemacs/user-confi' first."
)
 (defun dotspacemacs/user-config ()
  "Configuration function for user code.
This function is called at the very end of Spacemacs initialization after
layers configuration.
This is the place where most of your configurations should be done. Unless it is
explicitly specified that a variable should be set before a package is loaded,
you should place your code here."
	(global-set-key (kbd "M-m o") 'treemacs-select-window)
	(spacemacs/toggle-evil-safe-lisp-structural-editing-on-register-hook-scheme-mode)
  ;; custom indent function for setting the indent in different modes
	;; nodejs-repl
  (spacemacs/set-leader-keys-for-major-mode 'js2-mode "one" 'nodejs-repl-send-last-expression)
  (spacemacs/set-leader-keys-for-major-mode 'js2-mode "onj" 'nodejs-repl-send-line)
  (spacemacs/set-leader-keys-for-major-mode 'js2-mode "onr" 'nodejs-repl-send-region)
  (spacemacs/set-leader-keys-for-major-mode 'js2-mode "onl" 'nodejs-repl-load-file)
  (spacemacs/set-leader-keys-for-major-mode 'js2-mode "on'" 'nodejs-repl-switch-to-repl)
  (spacemacs/set-leader-keys-for-major-mode 'js2-mode "ons" 'nodejs-repl-switch-to-repl)
	(setq frame-resize-pixelwise t)
	(require 'fill-column-indicator)
	(setq-default set-fill-column 80)
	(setq-default indent-tabs-mode t)
  (defun my-custom-indent-width (n t)
		(setq-default tab-width t)
		(setq-default go-tab-width n)
		(setq-default standard-indent n)
    (setq-default c-basic-offset n)
    (setq-default coffee-tab-width n) ; coffeescript
    (setq-default javascript-indent-level n) ; javascript-mode
    (setq-default js-indent-level n) ; js-mode
    (setq-default js2-basic-offset n) ; js2-mode, in latest js2-mode, it's alias of js-indent-level
    (setq-default web-mode-markup-indent-offset n) ; web-mode, html tag in html file
    (setq-default web-mode-css-indent-offset n) ; web-mode, css in html file
    (setq-default web-mode-code-indent-offset n) ; web-mode, js code in html file
		(setq-default react-indent-level n)
		(setq-default web-mode-indent-style n)
    (setq-default css-indent-offset n) ; css-mode
  )
  (my-custom-indent-width 2 2)
	(add-hook 'prog-mode-hook fci-mode 1)

	(global-company-mode)

	;; C# configs
	(setq-default omnisharp--curl-executable-path "/usr/bin/curl")
	(setq flycheck-eslintrc "~/.dotfiles/eslintrc")
	(setq prettier-js-args '(
													 "--use-tabs"
													 "--single-quote"
													 "--trailing-comma" "es5"
													 ))

	(add-to-list 'exec-path "/Users/brorwinther/.node_modules/bin/")

	;; Setting some go values
	;; (let (
	;; 			(paths
	;; 			 '(
	;; 				 "/Users/brorwinther/.go/bin"
	;; 				 "/usr/local/opt/go/libexec/bin")))
	;; 	(setenv "PATH" (mapconcat 'identity paths path-separator))
	;; 	(mapc (lambda (path)
	;; 					(add-to-list 'exec-path path))
	;; 				paths))
	(setenv "GOROOT" "/usr/local/opt/go/libexec")

  ;; save the current buffer when spacemacs looses focus.
  (add-hook 'focus-out-hook 'evil-normal-state)
  (add-hook 'focus-out-hook
            (defun save-current-buffer-if-needed ()
              (interactive)
              (when (and (buffer-file-name) (buffer-modified-p))
                (save-buffer))))

	;; disable highlight line
  (global-hl-line-mode -1)

	;; org mode options
  ;; (setq org-re-reveal-root "file:///Users/noname/Projects/reveal.js/")
  ;; (defun org-line-wrap ()
  ;;   (spacemacs/toggle-visual-line-navigation-on)
  ;;   (setq-local word-wrap t))
  ;; (add-hook 'org-mode-hook 'org-line-wrap)

	;; bnf mode
	(define-generic-mode 'bnf-mode
		() ;; comment char: inapplicable because # must be at start of line
		nil ;; keywords
		'(
			("^#.*" . 'font-lock-comment-face) ;; comments at start of line
			("^<.*?>" . 'font-lock-function-name-face) ;; LHS nonterminals
			("<.*?>" . 'font-lock-builtin-face) ;; other nonterminals
			("::=" . 'font-lock-const-face) ;; "goes-to" symbol
			("\|" . 'font-lock-warning-face) ;; "OR" symbol
			("\{:\\|:\}" . 'font-lock-keyword-face) ;; special pybnf delimiters
			)
		'("\\.bnf\\'" "\\.pybnf\\'") ;; filename suffixes
		nil ;; extra function hooks
		"Major mode for BNF highlighting.")
  )

(defun dotspacemacs/emacs-custom-settings ()
  "Emacs custom settings.
This is an auto-generated function, do not modify its content directly, use
Emacs customize menu instead.
This function is called at the very end of Spacemacs initialization."
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (xcscope zenburn-theme zen-and-art-theme yapfify yaml-mode xterm-color xkcd ws-butler winum white-sand-theme which-key wgrep web-mode web-beautify wakatime-mode volatile-highlights vi-tilde-fringe uuidgen use-package underwater-theme ujelly-theme twilight-theme twilight-bright-theme twilight-anti-bright-theme toxi-theme toml-mode toc-org tern tao-theme tangotango-theme tango-plus-theme tango-2-theme tagedit swift-mode sunny-day-theme sublime-themes subatomic256-theme subatomic-theme stickyfunc-enhance srefactor spaceline powerline spacegray-theme soothe-theme solarized-theme soft-stone-theme soft-morning-theme soft-charcoal-theme smyx-theme smex smeargle slim-mode slack emojify circe oauth2 websocket ht shell-pop seti-theme scss-mode scala-mode sbt-mode sass-mode rvm ruby-tools ruby-test-mode rubocop rspec-mode robe reverse-theme restart-emacs request rebecca-theme rbenv rake rainbow-delimiters railscasts-theme racer pyvenv pytest pyenv-mode py-isort purple-haze-theme pug-mode professional-theme prettier-js popwin planet-theme pip-requirements phpunit phpcbf php-extras php-auto-yasnippets phoenix-dark-pink-theme phoenix-dark-mono-theme persp-mode pcre2el paradox spinner ox-reveal orgit organic-green-theme org-present org-pomodoro org-plus-contrib org-mime org-download org-bullets open-junk-file omtose-phellack-theme omnisharp oldlace-theme occidental-theme obsidian-theme noflet noctilux-theme nginx-mode neotree naquadah-theme mustang-theme multi-term move-text monochrome-theme molokai-theme moe-theme mmm-mode minitest minimal-theme material-theme markdown-toc majapahit-theme magit-gitflow magit-popup madhat2r-theme macrostep lush-theme lorem-ipsum livid-mode skewer-mode simple-httpd live-py-mode linum-relative link-hint light-soap-theme json-mode json-snatcher json-reformat js2-refactor multiple-cursors js2-mode js-doc jinja2-mode jbeans-theme jazz-theme ivy-hydra ir-black-theme insert-shebang inkpot-theme indent-guide hydra lv hy-mode dash-functional hungry-delete htmlize hl-todo highlight-parentheses highlight-numbers parent-mode highlight-indentation heroku-theme hemisu-theme helm-make hc-zenburn-theme haml-mode gruvbox-theme gruber-darker-theme grandshell-theme gotham-theme google-translate golden-ratio go-guru go-eldoc gnuplot gitignore-mode gitconfig-mode gitattributes-mode git-timemachine git-messenger git-link gh-md gandalf-theme fuzzy flyspell-popup flyspell-correct-ivy flyspell-correct flycheck-rust flycheck-pos-tip flycheck flx-ido flx flatui-theme flatland-theme fish-mode fill-column-indicator farmhouse-theme fancy-battery eyebrowse expand-region exotica-theme exec-path-from-shell evil-visualstar evil-visual-mark-mode evil-unimpaired evil-tutor evil-surround evil-search-highlight-persist highlight evil-numbers evil-nerd-commenter evil-mc evil-matchit evil-magit magit git-commit with-editor transient evil-lisp-state smartparens evil-indent-plus evil-iedit-state iedit evil-exchange evil-escape evil-ediff evil-args evil-anzu anzu evil goto-chg undo-tree eval-sexp-fu espresso-theme eshell-z eshell-prompt-extras esh-help emoji-cheat-sheet-plus helm helm-core emmet-mode elisp-slime-nav dumb-jump drupal-mode php-mode dracula-theme django-theme diminish define-word darktooth-theme autothemer darkokai-theme darkmine-theme darkburn-theme dakrone-theme cython-mode cyberpunk-theme csv-mode csharp-mode counsel-projectile projectile pkg-info epl counsel swiper ivy company-web web-completion-data company-statistics company-shell company-quickhelp pos-tip company-go go-mode company-emoji company-auctex company-ansible company-anaconda company column-enforce-mode color-theme-sanityinc-tomorrow color-theme-sanityinc-solarized coffee-mode clues-theme clean-aindent-mode chruby cherry-blossom-theme cargo markdown-mode rust-mode busybee-theme bundler inf-ruby bubbleberry-theme birds-of-paradise-plus-theme bind-map bind-key badwolf-theme auto-yasnippet yasnippet auto-highlight-symbol auto-dictionary auto-compile packed auctex-latexmk auctex async apropospriate-theme anti-zenburn-theme ansible-doc ansible anaconda-mode pythonic f dash s ample-zen-theme ample-theme alert log4e gntp alect-themes aggressive-indent afternoon-theme adaptive-wrap ace-window ace-link avy ac-ispell auto-complete popup monokai-theme)))
 '(python-shell-interpreter "python3" t))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
)
