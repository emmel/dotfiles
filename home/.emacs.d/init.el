;;; init.el --- Emacs config entrypoint.

;; Turn off built-in vcs right away
(setq vc-handled-backends ())

;; Load other files
(add-to-list 'load-path "~/.emacs.d/lisp")

(require 'mde-packages)

(require 'evil)
(evil-mode 1)

(require 'mde-modes)
(require 'mde-spelling)

(require 'mde-visuals)

;; Place all backup files in one directory.
(setq backup-directory-alist `((".*" . "~/.emacs.d/backups")))
(setq auto-save-file-name-transforms `((".*" "~/.saves" t)))
(setq backup-by-copying t)
(setq delete-old-versions t
      kept-new-versions 10
      kept-old-versions 2
      version-control t)
(setq make-backup-files t)

;; Purge backup files more than a week old.
(message "Deleting old backup files...")
(let ((week (* 60 60 24 7))
      (current (float-time (current-time))))
  (dolist (file (directory-files temporary-file-directory t))
    (when (and (backup-file-name-p file)
               (> (- current (float-time (fifth (file-attributes file))))
                  week))
      (message file)
      (delete-file file))))

;; Random settings
(put 'downcase-region 'disabled nil)

;; Automatically delete trailing whitespace
(add-hook 'before-save-hook 'delete-trailing-whitespace)
(setq delete-trailing-lines nil)

;; Enable copying on Cygwin
(defun cyg-copy (start end)
  "Writes a region to Cygwin's clipboard"
  (interactive "r")
  (write-region start end "/dev/clipboard"))

;; Automatically delete trailing whitespace
(add-hook 'before-save-hook 'delete-trailing-whitespace)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(font-lock-function-name-face ((((class color)) (:foreground "magenta"))))
 '(linum ((t (:inherit (shadow default) :background "black" :foreground "brightgreen"))))
 '(web-mode-block-control-face ((t (:inherit web-mode-preprocessor-face))))
 '(web-mode-block-delimiter-face ((t (:inherit web-mode-block-control-face))))
 '(web-mode-css-selector-face ((t (:inherit font-lock-function-name-face))))
 '(web-mode-html-attr-name-face ((t (:foreground "blue"))))
 '(web-mode-html-tag-bracket-face ((t (:foreground "brightred"))))
 '(web-mode-html-tag-face ((t (:foreground "brightred"))))
 '(web-mode-preprocessor-face ((t (:inherit web-mode-keyword-face))))
 '(web-mode-variable-name-face ((t (:inherit font-lock-reference-face)))))
