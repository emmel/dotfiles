(setq vc-handled-backends ())
;; Turn off menu-bar
(if (fboundp 'menu-bar-mode) (menu-bar-mode -1))

;; Set up el-get
(add-to-list 'load-path "~/.emacs.d/el-get/el-get")
(unless (require 'el-get nil t)
 (url-retrieve
  "https://raw.github.com/dimitri/el-get/master/el-get-install.el"
  (lambda (s)
    (goto-char (point-max))
    (eval-print-last-sexp))))


(setq my:el-get-packages
     '(solarized
       dockerfile-mode
       unic0rn-powerline
       flycheck
       markdown-mode-http
       yaml-mode
;       Emacs-Groovy-Mode
       csv-mode
       dockerfile-mode
       csharp-mode
       direx
       jedi
       web-mode
       yasnippet
       emmet-mode
       powershell-mode
       sql-indent
       ))

;;Turn on ELPA/MELPA (http://stackoverflow.com/questions/23165158)
(require 'package)
(add-to-list 'package-archives
             '("melpa" . "http://melpa.milkbox.net/packages/") t)
 (package-initialize)

(require 'el-get)
(add-to-list 'el-get-recipe-path "~/.emacs.d/recipes")

(require 'el-get-elpa)
;; Build the El-Get copy of the package.el packages if we have not
;; built it before.  Will have to look into updating later ...
(unless (file-directory-p el-get-recipe-path-elpa)
 (el-get-elpa-build-local-recipes))


;; Build the Emacs Wiki recipes
(unless (file-directory-p el-get-recipe-path-emacswiki)
  (el-get-emacswiki-build-local-recipes el-get-recipe-path-emacswiki))

(el-get 'sync my:el-get-packages)

;; Set the theme
(add-to-list 'custom-theme-load-path "~/.emacs.d/el-get/solarized")
(autoload 'color-theme-solarized-dark "color-theme-solarized"
  "color-theme: solarized-dark" t)
(load-theme 'solarized-dark t)
(setq solarized-broken-srgb 'nil)

;; Turn on powerline
(add-to-list 'load-path "~/.emacs.d/el-get/unic0rn-powerline")
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

;; Jedi mode
(add-hook 'python-mode-hook 'jedi:setup)


;; Turn on Flycheck
(require 'flycheck)
;; (add-hook 'python-mode-hook 'flycheck-mode)
(setq-default flycheck-disabled-checkers '(python-flake8))

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



(custom-set-faces
;; custom-set-faces was added by Custom.
;; If you edit it by hand, you could mess it up, so be careful.
;; Your init file should contain only one such instance.
;; If there is more than one, they won't work right.
'(linum ((t (:inherit (shadow default) :background "black" :foreground "brightgreen")))))

;; Autoload markdown mode
(autoload 'markdown-mode "markdown-mode"
 "Major mode for editing Markdown files" t)

;; Flyspell
(defun flyspell-emacs-popup-textual (event poss word)
 "A textual flyspell popup menu."
 (require 'popup)
 (let* ((corrects (if flyspell-sort-corrections
                      (sort (car (cdr (cdr poss))) 'string<)
                    (car (cdr (cdr poss)))))
        (cor-menu (if (consp corrects)
                      (mapcar (lambda (correct)
                                (list correct correct))
                              corrects)
                    '()))
        (affix (car (cdr (cdr (cdr poss)))))
        show-affix-info
        (base-menu  (let ((save (if (and (consp affix) show-affix-info)
                                    (list
                                     (list (concat "Save affix: " (car affix))
                                           'save)
                                     '("Accept (session)" session)
                                     '("Accept (buffer)" buffer))
                                  '(("Save word" save)
                                    ("Accept (session)" session)
                                    ("Accept (buffer)" buffer)))))
                      (if (consp cor-menu)
                          (append cor-menu (cons "" save))
                        save)))
        (menu (mapcar
               (lambda (arg) (if (consp arg) (car arg) arg))
               base-menu)))
   (cadr (assoc (popup-menu* menu :scroll-bar t) base-menu))))

(eval-after-load "flyspell"
 '(progn
    (fset 'flyspell-emacs-popup 'flyspell-emacs-popup-textual)))

(dolist (hook '(markdown-mode-hook))
 (add-hook hook (lambda () (flyspell-mode 1))))

(defun flyspell-mode-keys ()
 "Custom keybindings for flyspell-mode."
 (define-key flyspell-mode-map (kbd "C-c c") (lambda () (interactive) (flyspell-correct-word))))

(add-hook 'flyspell-mode-hook 'flyspell-mode-keys)
(put 'downcase-region 'disabled nil)

;; https://gist.github.com/1427240
(defun add-to-mode (mode &rest files)
 (dolist (file files)
   (add-to-list 'auto-mode-alist
                (cons file mode))))

;; Gradle-Mode
(autoload 'groovy-mode "groovy-mode" "Major mode for editing Groovy code." t)
(add-to-mode 'groovy-mode "\\.groovy$" "\\.gradle$")


(put 'upcase-region 'disabled nil)


;; Enable copying on Cygwin
(defun cyg-copy (start end)
 "Writes a region to Cygwin's clipboard"
 (interactive "r")
 (write-region start end "/dev/clipboard"))

;; csv-mode
(autoload 'csv-mode "csv-mode" "Major mode for editing CSV files." t)
(add-to-mode 'csv-mode "\\.csv$")

;; ruby-mode
(add-to-mode 'ruby-mode "Vagrantfile")

;; dockerfile-mode
(autoload 'dockerfile-mode "dockerfile-mode" "Major mode for editing Dockerfiles." t)
(add-to-mode 'dockerfile-mode "Dockerfile")

;; Automatically delete trailing whitespace
(add-hook 'before-save-hook 'delete-trailing-whitespace)

(ido-mode 1)
(setq ido-enable-flex-matching t)
(setq ido-everywhere t)
(setq ido-use-filename-at-point 'guess)

;; web-mode
(defun mde:web-mode-hook ()
  "Hooks for web-mode."
  (setq web-mode-enable-auto-pairing t)
  (custom-set-faces
   '(web-mode-block-control-face ((t (:inherit web-mode-preprocessor-face))))
   '(web-mode-block-delimiter-face ((t (:inherit web-mode-block-control-face))))
   '(web-mode-css-selector-face ((t (:inherit font-lock-function-name-face))))
   '(web-mode-html-attr-name-face ((t (:inherit font-lock-variable-name-face))))
   '(web-mode-html-tag-face ((t (:inherit font-lock-function-name-face))))
   ;; '(web-mode-keyword-face ((t (:inherit web-mode-preprocessor-face))))
   '(web-mode-preprocessor-face ((t (:inherit web-mode-keyword-face))))
   ;; '(web-mode-preprocessor-face ((t (:foreground "dodger blue"))))
   '(web-mode-variable-name-face ((t (:inherit font-lock-reference-face)))))
  (setq web-mode-ac-sources-alist
        '(("css" . (ac-source-css-property))
          ("html" . (ac-source-words-in-buffer ac-source-abbrev)))))

(add-hook 'web-mode-hook 'mde:web-mode-hook)
(setq js-indent-level 2)

;; powershell-mode
(autoload 'powershell-mode "powershell-mode"
  "Major mode for editing Powershell scripts." t)
(add-to-mode 'powershell-mode "\\.ps1$")
(setq powershell-indent 4)
(setq powershell-continuation-indent 2)

;; sql-mode
;; (autoload 'sql-indent "sql-indent" "Indentation for SQL Mode." t)
(eval-after-load "sql"
  '(load-library "sql-indent"))
