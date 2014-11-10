;;; init.el --- Emacs config entrypoint.

;; Turn off built-in vcs right away
(setq vc-handled-backends ())

;; Load other files
(add-to-list 'load-path "~/.emacs.d/lisp")

(require 'mde-packages)
(require 'mde-modes)
(require 'mde-spelling)

(require 'evil)
(evil-mode 1)

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
