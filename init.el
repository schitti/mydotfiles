;; Uncomment next line to make emacs produce a stack trace for errors.
;; (setq debug-on-error t)

;; Turn off mouse interface early in startup to avoid momentary display
(if (fboundp 'menu-bar-mode) (menu-bar-mode -1))
(if (fboundp 'tool-bar-mode) (tool-bar-mode -1))
(if (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))

;; yes or no questions replaced by y-n
(fset 'yes-or-no-p 'y-or-n-p)

;; separate file for customizations. Since the menu is removed,
;; how do I access customizations?
;; (setq custom-file "~/.emacs.d/my-customizations.el")
;; (load custom-file)

;; Keep all backup files in a separate directory.
(setq backup-directory-alist `(("." . "~/.emacs-backups")))
(setq delete-old-versions t
      kept-new-versions 5
      kept-old-versions 2
      version-control t)

;; Remember the place (line,column) in each file visited even if
;; we close the files.
(setq save-place-file "~/.emacs.d/saveplace") ;; keep my ~/ clean
(setq-default save-place t)                   ;; activate it for all buffers
(require 'saveplace)                          ;; get the package

(add-to-list 'load-path "~/.emacs.d/site-lisp")
(add-to-list 'load-path "~/.emacs.d/auto-complete-1.3")
(add-to-list 'load-path "/usr/share/emacs23/site-lisp")
(add-to-list 'load-path "/usr/share/emacs23/site-lisp/emacs-goodies-el")

(require 'cl)
(require 'ffap)
(require 'uniquify)
(setq uniquify-buffer-name-style 'forward)
(require 'ansi-color)
(require 'recentf)

;; bold keywords and italics comments
;; (set-face-bold-p 'font-lock-keyword-face t)
;; (set-face-italic-p 'font-lock-comment-face t)

(setq inhibit-startup-message t
      inhibit-startup-echo-area-message t)

(set-register ?e '(file . "~/.emacs.d/init.el"))

(set-background-color "gray84")

(show-paren-mode 1)
(setq show-paren-delay 0)

(setq whitespace-style '(trailing lines space-before-tab indentation
				  space-after-tab) whitespace-line-column 80)

(autoload 'ansi-color-for-comint-mode-on "ansi-color" nil t)
(add-hook 'shell-mode-hook 'ansi-color-for-comint-mode-on)

(add-to-list 'load-path "/path/to/color-theme.el/file")
(require 'color-theme)
(eval-after-load "color-theme"
  '(progn
     (color-theme-initialize)
     ))
(setq color-theme-is-global nil)

(set-frame-font "Monaco-11")
(setq x-select-enable-clipboard t)

;(autoload 'autopair-global-mode "autopair" nil t)
;(autopair-global-mode)

(add-hook 'lisp-mode-hook
          #'(lambda () (setq autopair-dont-activate t)))

(add-hook 'clojure-mode-hook
          #'(lambda () (setq autopair-dont-activate t)))

(add-hook 'slime-repl-mode-hook
          #'(lambda () (setq autopair-dont-activate t)))

(autoload 'paredit-mode "paredit"
  "Minor mode for pseudo-structurally editing Lisp code." t)

(add-hook 'emacs-lisp-mode-hook       (lambda () (paredit-mode +1)))
(add-hook 'lisp-mode-hook             (lambda () (paredit-mode +1)))
(add-hook 'lisp-interaction-mode-hook (lambda () (paredit-mode +1)))
(add-hook 'clojure-mode-hook          (lambda () (paredit-mode +1)))
(add-hook 'slime-repl-mode-hook       (lambda () (paredit-mode +1)))

(defvar electrify-return-match
  "[\]}\)\"]"
  "If this regexp matches the text after the cursor, do an \"electric\"
  return.")

(defun electrify-return-if-match (arg)
  "If the text after the cursor matches `electrify-return-match' then
  open and indent an empty line between the cursor and the text.  Move the
  cursor to the new line."
  (interactive "P")
  (let ((case-fold-search nil))
    (if (looking-at electrify-return-match)
	(save-excursion (newline-and-indent)))
    (newline arg)
    (indent-according-to-mode)))

(loop for hook in
      (list 'clojure-mode-hook 'emacs-lisp-mode-hook
	    'slime-repl-mode-hook)
      do
      (add-hook hook
		(function (lambda ()
			    (local-set-key (kbd "RET")
					   'electrify-return-if-match)))))

;; pyflakes,

(when (load "flymake" t)
  (defun flymake-pyflakes-init ()
    (let* ((temp-file (flymake-init-create-temp-buffer-copy
                       'flymake-create-temp-inplace))
           (local-file (file-relative-name
                        temp-file
                        (file-name-directory buffer-file-name))))
      (list "pyflakes" (list local-file))))
  (add-to-list 'flymake-allowed-file-name-masks
               '("\\.py\\'" flymake-pyflakes-init)))
(add-hook 'python-mode-hook 'flymake-mode)
(add-hook 'find-file-hook 'flymake-find-file-hook)

;; '(flymake-errline ((((class color))
;;  (:background "LightRed" :foreground "black"))))

;;  '(flymake-warnline ((((class color))
;;   (:background "LightBlue2" :foreground "black"))))

;(autoload 'python-mode "python-mode" "Python Mode." t)
(autoload 'python-mode "my-python-setup" "Python Mode." t)

;(require 'xcscope)

(require 'linum)
(global-linum-mode 1)

(column-number-mode 1)
(require 'column-marker)

(add-hook 'before-save-hook 'delete-trailing-whitespace)

;(require 'tabbar)
;(tabbar-mode 1)

;(server-start)

;;; This was installed by package-install.el.
;;; This provides support for the package system and
;;; interfacing with ELPA, the package archive.
;;; Move this code earlier if you want to reference
;;; packages in your .emacs.
(when
    (load
     (expand-file-name "~/.emacs.d/elpa/package.el"))
  (package-initialize))

(custom-set-variables
  ;; custom-set-variables was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(inhibit-startup-screen t))

(custom-set-faces
  ;; custom-set-faces was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
)

(add-to-list 'package-archives
             '("technomancy" . "http://repo.technomancy.us/emacs/") t)

(add-hook 'slime-repl-mode-hook 'clojure-mode-font-lock-setup)
