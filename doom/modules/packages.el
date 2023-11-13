;; -*- no-byte-compile: t; -*-
;;; packages.el


(use-package! nasm-mode
  :mode "\\.[n]*\\(asm\\|s\\)\\'")

;; Get Haxor VM from https://github.com/krzysztof-magosa/haxor
(use-package! haxor-mode
  :mode "\\.hax\\'")

(use-package! mips-mode
  :mode "\\.mips\\'")

(use-package! riscv-mode
  :mode "\\.riscv\\'")

(use-package! x86-lookup
  :commands (x86-lookup)
  :config
  (when (modulep! :tools pdf)
    (setq x86-lookup-browse-pdf-function 'x86-lookup-browse-pdf-pdf-tools))
  ;; Get manual from https://www.intel.com/content/www/us/en/developer/articles/technical/intel-sdm.html
  (setq x86-lookup-pdf (expand-file-name "x86-lookup/325383-sdm-vol-2abcd.pdf" doom-data-dir)))

(use-package! disaster
  :commands (disaster)
  :init
  (setq disaster-assembly-mode 'nasm-mode)

  (map! :localleader
        :map (c++-mode-map c-mode-map fortran-mode)
        :desc "Disaster" "d" #'disaster))
