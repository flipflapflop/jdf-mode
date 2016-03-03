(require 'cc-mode)

(provide 'jdf-mode)

;; ;;;###autoload
;; (add-to-list 'auto-mode-alist '("\\.cu$" . jdf-mode))

;; define several category of keywords
(setq jdf-types nil)

;; including JDF constants 
(setq jdf-const nil)

(setq jdf-keywords '("BODY" "END"))

;; (setq jdf-builtins nil)
(setq jdf-builtins '("inline_c"))

;; (setq jdf-func '("\\<\\(\\sw+\\) ?(" "\\<\\(\\sw+\\)<<<"))
(setq jdf-func nil)

;; generate regex string for each category of keywords
(setq jdf-types-regexp (regexp-opt jdf-types 'words))
(setq jdf-const-regexp (regexp-opt jdf-const 'words))
(setq jdf-keywords-regexp (regexp-opt jdf-keywords 'words))
(setq jdf-builtins-regexp (regexp-opt jdf-builtins 'words))
(setq jdf-func-regexp (regexp-opt jdf-func 'words))

;; create the list for font-lock.
;; each category of keyword is given a particular face
(setq jdf-font-lock-keywords
      `((,jdf-types-regexp . font-lock-type-face)
        (,jdf-const-regexp . font-lock-constant-face)
        (,jdf-keywords-regexp . font-lock-keyword-face)
        (,jdf-builtins-regexp . font-lock-builtin-face)
        (,jdf-func-regexp . font-lock-function-name-face)
        ))

(define-derived-mode jdf-mode c-mode "JDF"
  "Major mode for editing JDF files"
  ;; code for syntax highlighting
  (font-lock-add-keywords nil jdf-font-lock-keywords))

;; clear everything
(setq jdf-types nil)
(setq jdf-const nil)
(setq jdf-keywords nil)
(setq jdf-builtins nil)
(setq jdf-functions nil)

(setq jdf-types-regexp nil)
(setq jdf-const-regexp nil)
(setq jdf-keywords-regexp nil)
(setq jdf-builtins-regexp nil)
(setq jdf-func-regexp nil)
;;; jdf.el ends here
