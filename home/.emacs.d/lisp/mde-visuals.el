;; Turn off menu-bar
(if (fboundp 'menu-bar-mode) (menu-bar-mode -1))

;; Set the theme
(load-theme 'solarized-dark t)


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
( powerline-evil-theme)

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

;; Display visited file's path in the frame title
(setq frame-title-format
      '((:eval (if (buffer-file-name)
                   (abbreviate-file-name (buffer-file-name))
                 "%b"))))

(custom-set-faces
 '(linum ((t (:inherit (shadow default)
                       :background "black"
                       :foreground "brightgreen")))))

(provide 'mde-visuals)
