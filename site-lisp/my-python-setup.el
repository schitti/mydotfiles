(load-library "flymake-cursor")
(add-to-list 'auto-mode-alist '("\\.py\\'" . python-mode))
(add-to-list 'interpreter-mode-alist '("python" . python-mode))
(require 'python-mode)

;(add-hook 'python-mode-hook
;#'(lambda () (autopair-mode)))

;; pymacs

(setq pymacs-load-path '("/usr/local/lib/python2.6/dist-packages/"
			 "/usr/local/lib/python2.7/dist-packages/"
			 "/home/subu/opt/ropemacs/ropemacs"
			 "/home/subu/opt/ropemacs"))

(autoload 'pymacs-apply "pymacs")
(autoload 'pymacs-call "pymacs")
(autoload 'pymacs-eval "pymacs" nil t)
(autoload 'pymacs-exec "pymacs" nil t)
(autoload 'pymacs-load "pymacs" nil t)
;(eval-after-load "pymacs"
;  '(add-to-list 'pymacs-load-path YOUR-PYMACS-DIRECTORY"))
(pymacs-load "ropemacs" "rope-")
(setq ropemacs-enable-autoimport t)

(setq ropemacs-enable-shortcuts nil)
(setq ropemacs-local-prefix "C-c C-p")

(add-hook 'python-mode-hook
      (lambda ()
	(set-variable 'py-indent-offset 2)
	;(set-variable 'py-smart-indentation nil)
	(set-variable 'indent-tabs-mode nil)
	(define-key py-mode-map (kbd "RET") 'newline-and-indent)
	;(define-key py-mode-map [tab] 'yas/expand)
	;(setq yas/after-exit-snippet-hook 'indent-according-to-mode)
	;(smart-operator-mode-on)
	))

(add-hook 'python-mode-hook
          #'(lambda ()
              (push '(?' . ?')
                    (getf autopair-extra-pairs :code))
              (setq autopair-handle-action-fns
                    (list #'autopair-default-handle-action
                          #'autopair-python-triple-quote-action))))

(require 'python-pep8)
(require 'python-pylint)
(add-hook 'python-mode-hook (lambda () (interactive) (column-marker-1 80)))

(require 'yasnippet-bundle)
(yas/initialize)
(yas/load-directory "~/.emacs.d/my-snippets/")

(require 'auto-complete)
(global-auto-complete-mode t)

(require 'auto-complete-config)
(add-to-list 'ac-dictionary-directories "~/.emacs.d/ac-dict")
(ac-config-default)

(require 'ipython)

(require 'comint)
(define-key comint-mode-map (kbd "M-") 'comint-next-input)
(define-key comint-mode-map (kbd "M-") 'comint-previous-input)
(define-key comint-mode-map [down] 'comint-next-matching-input-from-input)
(define-key comint-mode-map [up] 'comint-previous-matching-input-from-input)

;; add pylookup to your loadpath, ex) "~/.lisp/addons/pylookup"
;(setq pylookup-dir "/home/subu/opt/pylookup")
;(add-to-list 'load-path pylookup-dir)
;; load pylookup when compile time
;(eval-when-compile (require 'pylookup))

;; set executable file and db file
;(setq pylookup-program (concat pylookup-dir "/pylookup.py"))
;(setq pylookup-db-file (concat pylookup-dir "/pylookup.db"))

;; to speedup, just load it on demand
;(autoload 'pylookup-lookup "pylookup"
;  "Lookup SEARCH-TERM in the Python HTML indexes." t)
;(autoload 'pylookup-update "pylookup"
;  "Run pylookup-update and create the database at `pylookup-db-file'." t)
;(global-set-key "\C-ch" 'pylookup-lookup)

; make up and down arrows work in the interpreter buffer
(add-hook 'py-shell-hook
          (lambda ()
            (local-set-key (kbd "<up>") 'comint-previous-matching-input-from-input)
            (local-set-key (kbd "<down>") 'comint-next-matching-input-from-input)))