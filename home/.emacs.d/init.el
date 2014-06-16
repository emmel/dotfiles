

;; Turn off menu-bar
(if (fboundp 'menu-bar-mode) (menu-bar-mode -1))

;; Set up el-get
(add-to-list 'load-path "~/.emacs.d/el-get/el-get")

(unless (require 'el-get nil t)
  (url-retrieve
   "https://raw.github.com/dimitri/el-get/master/el-get-install.el"
   (lambda (s)
     (end-of-buffer)
     (eval-print-last-sexp))))

(setq my:el-get-packages
      '(color-theme-solarized
        dockerfile-mode
        unic0rn-powerline
        flycheck))

(require 'el-get)
(add-to-list 'el-get-recipe-path "~/.emacs.d/recipes")

(el-get 'sync my:el-get-packages)

;; Set the theme
(load-theme 'solarized-dark t)
(setq solarized-broken-srgb 'nil)

;; Turn on powerline
(require 'powerline)
(setq powerline-color1 "#073642")
(setq powerline-color2 "#002B36")
(set-face-attribute 'mode-line nil
                      :foreground "#fdf6e3"
                      :background "#073642"
                      :box nil
                      :inverse-video nil)
(set-face-attribute 'mode-line-inactive nil
                      :foreground "#93a1a1"
                      :background "#586e75"
                      :box nil)
(powerline-default-theme)
 
;; no splash screen
(setq inhibit-splash-screen t)

;; no bell
(setq visible-bell t)

;; Line numbers
(global-linum-mode t)
(setq linum-format "%d ")

;; Add closing bracket
(electric-pair-mode 1)

;; and highlight them
(show-paren-mode 1)

;; Fix tabs
(setq c-basic-indent 2)
(setq tab-width 4)
(setq-default indent-tabs-mode nil)

;; Allow y or n instead of having to type yes or no
(fset 'yes-or-no-p 'y-or-n-p)

;; Place all backup files in one directory.
(setq backup-directory-alist `((".*" . "~/.emacs.d/backups")))
(setq auto-save-file-name-transforms `((".*" "~/.saves" t)))
(setq backup-by-copying t)
(setq delete-old-versions t
      kept-new-versions 10
      kept-old-versions 2
      version-control t)
(setq make-backup-files t)


;; Turn on Flycheck
(require 'flycheck)
(add-hook 'after-init-hook #'global-flycheck-mode)

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

;; Display visited file's path in the frame title
(setq frame-title-format
      '((:eval (if (buffer-file-name)
                   (abbreviate-file-name (buffer-file-name))
                 "%b"))))


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
 '(linum ((t (:inherit (shadow default) :background "black" :foreground "brightgreen")))))
