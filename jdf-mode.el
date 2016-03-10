(require 'cc-mode)

(provide 'jdf-mode)

;; regexp-opt: compte a regexp from a list of strings 
;; (eg. (regexp-opt '("str1" "str2") t) ). 
;; If a second argument is provided then  

;; ;;;###autoload
;; (add-to-list 'auto-mode-alist '("\\.cu$" . jdf-mode))

;; define several category of keywords
(setq jdf-types nil)

;; including JDF constants
(setq jdf-const nil)

(setq jdf-keywords '("BODY" "END"
                     "NEW"
                     "type"
                     "RW" "READ" "WRITE"))

(setq jdf-builtins nil)
;; (setq jdf-builtins '("inline_c"))
;; (defconst jdf-builtins '("inline_c"))

;; (setq jdf-func '("\\<\\(\\sw+\\) ?(" "\\<\\(\\sw+\\)<<<"))
(setq jdf-func nil)

;; (defconst jdf-inline-re "\\<\\(inline_c\\)[ \t]*%{")

;; generate regex string for each category of keywords
(setq jdf-types-regexp (regexp-opt jdf-types 'words))
(setq jdf-const-regexp (regexp-opt jdf-const 'words))
(setq jdf-keywords-regexp (regexp-opt jdf-keywords 'words))
(setq jdf-builtins-regexp (regexp-opt jdf-builtins 'words))
;; (setq jdf-builtins-regexp jdf-inline-re)
;; (setq jdf-builtins-regexp "\\<\\(inline_c\\)[ \t]*%{" 1)
;; (setq jdf-builtins-regexp (regexp-opt '("->" "<-")))
;; (setq jdf-builtins-regexp (regexp-opt '("inline_c" "test")))
(setq jdf-func-regexp (regexp-opt jdf-func 'words))

;; create the list for font-lock.
;; each category of keyword is given a particular face
(setq jdf-font-lock-keywords
      `((,jdf-types-regexp . font-lock-type-face)
        (,jdf-const-regexp . font-lock-constant-face)
        (,jdf-keywords-regexp . font-lock-keyword-face)
        (,jdf-builtins-regexp . font-lock-builtin-face)
        ("\\(->\\|<-\\)" . font-lock-keyword-face)
        ("\\<\\(inline_c\\)[ \t]*%{" (1 font-lock-builtin-face))
        ("\\<\\(\\sw+\\)[ \t]*\\(\\[\\)" (1 font-lock-variable-name-face))
        (,jdf-func-regexp . font-lock-function-name-face)
        ))

;; (defun jdf-indent-line ()
;;   "Indent current line for `jdf-mode'."
;;   (interactive)
;;   (let ((indent-col 0))
;;     (save-excursion
;;       (beginning-of-line)
;;       (condition-case nil
;;           (while t
;;             (backward-up-list 1)
;;             (when (looking-at "[[{]")
;;               (setq indent-col (+ indent-col foo-indent-offset))))
;;         (error nil)))
;;     (save-excursion
;;       (back-to-indentation)
;;       (when (and (looking-at "[]}]") (>= indent-col foo-indent-offset))
;;         (setq indent-col (- indent-col foo-indent-offset))))
;;     (indent-line-to indent-col)))

  ;; (if (clojure-in-docstring-p)
  ;;     (save-excursion
  ;;       (beginning-of-line)
  ;;       (when (and (looking-at "^\\s-*")
  ;;                  (<= (string-width (match-string-no-properties 0))
  ;;                      (string-width (clojure-docstring-fill-prefix))))
  ;;         (replace-match (clojure-docstring-fill-prefix))))
  ;;   (c-indent-line))

(defun jdf-indent-line ()
  "Indent current line as jdf code."
  (interactive)
  (c-indent-line))

(define-derived-mode jdf-mode c-mode "JDF"
  "Major mode for editing JDF files"
  ;; code for syntax highlighting
  (font-lock-add-keywords nil jdf-font-lock-keywords)
  (set (make-local-variable 'indent-line-function) 'jdf-indent-line)
  )

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
