;;; cyberpunk-2077-theme.el --- inspired by VS code's Moonlight -*- lexical-binding: t; no-byte-compile: t; -*-
;;
;; Added: August 12, 2019 (741defec2c08)
;; Author: Brettm12345 <https://github.com/Brettm12345>
;; Maintainer:
;; Source: https://github.com/atomiks/moonlight-vscode-theme
;;
;;; Commentary:
;;; Code:

(require 'doom-themes)

;;
(defgroup cyberpunk-2077-theme nil
  "Options for the `cyberpunk-2077' theme."
  :group 'doom-themes)

(defcustom cyberpunk-2077-padded-modeline doom-themes-padded-modeline
  "If non-nil, adds a 4px padding to the mode-line.
Can be an integer to determine the exact padding."
  :group 'cyberpunk-2077-theme
  :type '(choice integer boolean))

;;
(def-doom-theme cyberpunk-2077
  "A dark theme inspired by Cyberpunk 2077"

  ;; name        default   256       16
  ((bg         '("#1e080a" "#1e080a" "black"))
   (bg-alt     '("#260b0d" "#260b0d" "black"))
   (base0      '("#4b1213" "#4b1213" "black"))
   (base1      '("#191a2a" "#191a2a" "brightblack"))
   (base2      '("#411316" "#411316" "brightblack")) ;; modeline background
   (base3      '("#222436" "#222436" "brightblack"))
   (base4      '("#330b0f" "#330b0f" "brightblack"))
   (base5      '("#444a73" "#444a73" "brightblack"))
   (base6      '("#828bb8" "#828bb8" "brightblack"))
   (base7      '("#a9b8e8" "#a9b8e8" "brightblack")) ;; modeline-buffer file
   (base8      '("#0d272a" "#0d272a" "white"))
   (indigo     '("#19423f" "#19423f" "brightblack"))
   (region     '("#722c25" "#722c25" "brightblack"))
   (fg         '("#47b7aa" "#47b7aa" "brightwhite"))
   (fg-alt     '("#b4c2f0" "#b4c2f0" "white"))

   (grey base5)

   (bright-cyan   '("#5df5fd" "#5df5fd" "brightcyan"))
   (dark-cyan     '("#2b5f5c" "#2b5f5c" "cyan"))
   (cyan          '("#00a8c6" "#00a8c6" "cyan"))
   (dark-red      '("#250b0d" "#f700f7" "red"))
   (light-red     '("#fc5d57" "#fc5d57" "brightred"))
   (red           '("#f9222f" "#250b0d" "red"))
   (bright-red    '("#ff5e58" "#f9222f" "brightred"))
   (green         '("#34e887" "#34e887" "green"))
   (bright-green  '("#d6ef6b" "#d6ef6b" "green"))
   (dark-green    '("#08311b" "#08311b" "green"))
   (yellow        '("#fff904" "#fff904" "yellow"))
   (dark-yellow   '("#fdc63a" "#fdc63a" "yellow"))
   (orange        '("#fc9031" "#fc9031" "brightred"))
   (purple        '("#9d2bf9" "#9d2bf9" "purple"))
   (pink          '("#f92bad" "#9d2bf9" "pink"))
   (light-pink    '("#f553b9" "#f92bad" "pink"))
   (light-magenta '("#f22bf9" "#f553b9" "pink"))
   (magenta       '("#f700f7" "#f22bf9" "magenta"))
   (blue          '("#2571d7" "#2571d7" "brightred"))
   (light-blue    '("#408df5" "#408df5" "brightred"))
   (dark-blue     '("#0c4796" "#0c4796" "brightred"))
   (light-teal    '("#42d9eb" "#ff5e58" "brightgreen"))
   (teal          '("#298791" "#42d9eb" "brightgreen"))
   (dark-teal     '("#0d272a" "#298791" "brightgreen"))
   (violet        yellow)

   (keys           bright-cyan)
   ;; face categories -- required for all themes
   (highlight      bright-red)
   (vertical-bar   base0)
   (line-highlight base4)
   (selection      region)
   (builtin        bright-cyan)
   (comments       dark-cyan)
   (doc-comments   (doom-lighten comments 0.1))
   (constants      dark-yellow)
   (functions      teal)
   (keywords       bright-cyan)
   (methods        blue)
   (operators      cyan)
   (type           yellow)
   (strings        orange)
   (variables      bright-red)
   (numbers        orange)
   (region         region)
   (error          red)
   (warning        orange)
   (success        green)
   (vc-modified    bright-cyan)
   (vc-added       green)
   (vc-deleted     red)

   ;; custom categories
   (modeline-bg     (doom-darken base2 0.1))
   (modeline-bg-alt (doom-darken bg 0.1))
   (modeline-fg     base8)
   (modeline-fg-alt comments)

   (-modeline-pad
    (when cyberpunk-2077-padded-modeline
      (if (integerp cyberpunk-2077-padded-modeline) cyberpunk-2077-padded-modeline 4))))

  ;;;; Base theme face overrides
  ((font-lock-keyword-face :foreground keywords)
   (font-lock-comment-face :foreground comments)
   (font-lock-doc-face :foreground doc-comments)
   (hl-line :background line-highlight)
   (lazy-highlight :background base4 :foreground fg)
   ((line-number &override) :foreground base5 :background (doom-darken bg 0.06))
   ((line-number-current-line &override) :foreground fg :background line-highlight)
   (mode-line
    :background modeline-bg :foreground modeline-fg :inherit 'bold
    :box (if -modeline-pad `(:line-width ,-modeline-pad :color ,modeline-bg)))
   (mode-line-inactive
    :background modeline-bg-alt :foreground modeline-fg-alt
    :box (if -modeline-pad `(:line-width ,-modeline-pad :color ,modeline-bg-alt)))
   (tooltip :background base0 :foreground fg)

   ;;;; all-the-icons
   (all-the-icons-cyan       :foreground dark-cyan)
   (all-the-icons-cyan-alt   :foreground dark-cyan)
   (all-the-icons-dblue      :foreground (doom-darken blue 0.1))
   (all-the-icons-dgreen     :foreground keys)
   (all-the-icons-dmaroon    :foreground magenta)
   (all-the-icons-dorange    :foreground orange)
   (all-the-icons-dpink      :foreground pink)
   (all-the-icons-dpurple    :foreground magenta)
   (all-the-icons-dred       :foreground dark-red)
   (all-the-icons-dsilver    :foreground grey)
   (all-the-icons-dyellow    :foreground orange)
   (all-the-icons-green      :foreground teal)
   (all-the-icons-lcyan      :foreground (doom-lighten dark-cyan 0.3))
   (all-the-icons-lgreen     :foreground green)
   (all-the-icons-lmaroon    :foreground light-magenta)
   (all-the-icons-lorange    :foreground orange)
   (all-the-icons-lpink      :foreground light-pink)
   (all-the-icons-lpurple    :foreground light-magenta)
   (all-the-icons-lred       :foreground light-red)
   (all-the-icons-lsilver    :foreground (doom-lighten grey 0.4))
   (all-the-icons-lyellow    :foreground (doom-lighten yellow 0.3))
   (all-the-icons-orange     :foreground orange)
   (all-the-icons-pink       :foreground pink)
   (all-the-icons-purple     :foreground magenta)
   (all-the-icons-purple-alt :foreground magenta)
   (all-the-icons-red-alt    :foreground red)
   (all-the-icons-silver     :foreground (doom-lighten grey 0.2))
   ;;;; all-the-icons-dired
   (all-the-icons-dired-dir-face :foreground indigo)
   ;;;; company
   (company-tooltip :inherit 'tooltip)
   (company-tooltip-common :foreground highlight)
   ;;;; company-box
   (company-box-annotation :foreground base7)
   ;;;; css-mode <built-in> / scss-mode
   (css-proprietary-property :foreground orange)
   (css-property             :foreground green)
   (css-selector             :foreground blue)
   ;;;; doom-emacs
   (doom-dashboard-menu-desc :foreground dark-cyan)
   (doom-dashboard-menu-tile :foreground keys)
   ;;;; diredfl
   (diredfl-date-time    :foreground blue)
   (diredfl-file-name    :foreground base7)
   (diredfl-file-suffix  :foreground base6)
   (diredfl-symlink      :foreground dark-cyan)
   ;;;; dired+
   (diredp-number :foreground orange)
   ;;;; dired-k
   (dired-k-commited :foreground base4)
   (dired-k-modified :foreground vc-modified)
   (dired-k-ignored  :foreground cyan)
   (dired-k-added    :foreground vc-added)
   ;;;; doom-emacs
   (+workspace-tab-selected-face :background region :foreground blue)
   ;;;; doom-modeline
   (doom-modeline-buffer-file       :foreground cyan)
   (doom-modeline-icon-inactive     :foreground teal)
   (doom-modeline-evil-normal-state :foreground cyan)
   (doom-modeline-evil-insert-state :foreground bright-cyan)
   (doom-modeline-project-dir       :foreground light-teal)
   (doom-modeline-buffer-path       :foreground bright-cyan)
   (doom-modeline-buffer-modified :inherit 'bold :foreground yellow)
   (doom-modeline-buffer-major-mode :inherit 'doom-modeline-buffer-path)
   ;;;; ivy-posframe
   (ivy-posframe :background base0)
   (ivy-posframe-border :background base0)
   ;;;; js2-mode
   (js2-jsdoc-tag              :foreground magenta)
   (js2-object-property        :foreground keys)
   (js2-object-property-access :foreground fg-alt)
   (js2-function-param         :foreground pink)
   (js2-jsdoc-type             :foreground base8)
   (js2-jsdoc-value            :foreground cyan)
   ;;;; linum
   ((linum &inherit line-number))
   ;;;; lsp-mode
   (lsp-face-highlight-read :background region)
   (lsp-face-highlight-textual :background region)
   (lsp-face-highlight-write :background region)
   (lsp-face-semhl-type-primative :foreground orange)
   (lsp-face-semhl-method :foreground magenta)
   ;;;; magit
   (magit-filename :foreground yellow)
   (magit-section-heading :foreground red :inherit 'bold)
   ;;;; man <built-in>
   (Man-overstrike :inherit 'bold :foreground magenta)
   (Man-underline :inherit 'underline :foreground blue)
   ;;;; markdown-mode
   (markdown-header-face           :inherit 'bold :foreground yellow)
   (markdown-header-delimiter-face :inherit 'markdown-header-face)
   (markdown-metadata-key-face     :foreground magenta :inherit 'italic)
   (markdown-list-face             :foreground red)
   (markdown-url-face              :inherit 'underline :foreground orange)
   (markdown-gfm-checkbox-face     :foreground blue)
   (markdown-blockquote-face       :inherit 'italic :foreground fg)
   (mmm-default-submode-face       :background base1)
   ;;;; message <built-in>
   (message-header-name       :foreground green)
   (message-header-subject    :foreground highlight :weight 'bold)
   (message-header-to         :foreground highlight :weight 'bold)
   (message-header-cc         :inherit 'message-header-to :foreground (doom-darken highlight 0.15))
   (message-header-other      :foreground purple)
   (message-header-newsgroups :foreground yellow)
   (message-header-xheader    :foreground doc-comments)
   (message-separator         :foreground comments)
   (message-mml               :foreground comments :slant 'italic)
   (message-cited-text        :foreground magenta)
   ;;;; nav-flash
   (nav-flash-face :background region)
   ;;;; nix-mode
   (nix-attribute-face :foreground blue)
   (nix-builtin-face :foreground keys)
   ;;;; org <built-in>
   ((outline-1 &override) :foreground light-blue)
   ((outline-2 &override) :foreground dark-cyan)
   ((outline-3 &override) :foreground light-red)
   ((outline-4 &override) :foreground blue)
   ((outline-5 &override) :foreground magenta)
   ((outline-6 &override) :foreground red)
   ((outline-7 &override) :foreground purple)
   ((org-block &override) :background base2)
   ((org-block-background &override) :background base2)
   ((org-block-begin-line &override) :background base2)
   ;;;; popup
   (popup-face :inherit 'tooltip)
   (popup-selection-face :inherit 'tooltip)
   ;;;; pos-tip
   (popup-tip-face :inherit 'tooltip)
   ;;;; rainbow-delimiters
   (rainbow-delimiters-depth-1-face :foreground magenta)
   (rainbow-delimiters-depth-2-face :foreground orange)
   (rainbow-delimiters-depth-3-face :foreground light-red)
   (rainbow-delimiters-depth-4-face :foreground cyan)
   (rainbow-delimiters-depth-5-face :foreground purple)
   (rainbow-delimiters-depth-6-face :foreground yellow)
   (rainbow-delimiters-depth-7-face :foreground blue)
   (rainbow-delimiters-depth-8-face :foreground teal)
   (rainbow-delimiters-depth-9-face :foreground dark-cyan)
   ;;;; rjsx-mode
   (rjsx-tag :foreground purple)
   (rjsx-attr :foreground yellow :slant 'italic :weight 'medium)
   ;;;; treemacs
   (treemacs-directory-face :foreground highlight)
   (treemacs-git-modified-face :foreground highlight)
   ;;;; which-key
   (which-key-command-description-face :foreground fg)
   (which-key-group-description-face :foreground magenta)
   (which-key-local-map-description-face :foreground cyan)))

;;; cyberpunk-2077-theme.el ends here
