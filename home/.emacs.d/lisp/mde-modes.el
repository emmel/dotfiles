
;; https://gist.github.com/1427240
(defun add-to-mode (mode &rest files)
  (dolist (file files)
    (add-to-list 'auto-mode-alist
                 (cons file mode))))

;; Turn on Flycheck
(require 'flycheck)
;; (add-hook 'python-mode-hook 'flycheck-mode)
(setq-default flycheck-disabled-checkers '(python-flake8))


;; markdown-mode
(autoload 'markdown-mode "markdown-mode"
  "Major mode for editing Markdown files" t)

;; gradle-mode
(autoload 'groovy-mode "groovy-mode" "Major mode for editing Groovy code." t)
(add-to-mode 'groovy-mode "\\.groovy$" "\\.gradle$")

;; csv-mode
(autoload 'csv-mode "csv-mode" "Major mode for editing CSV files." t)
(add-to-mode 'csv-mode "\\.csv$")

;; ruby-mode
(add-to-mode 'ruby-mode "Vagrantfile")

;; dockerfile-mode
(autoload 'dockerfile-mode "dockerfile-mode" "Major mode for editing Dockerfiles." t)
(add-to-mode 'dockerfile-mode "Dockerfile")

;; ido-mode
(ido-mode 1)
(setq ido-enable-flex-matching t)
(setq ido-everywhere t)
(setq ido-use-filename-at-point 'guess)

;; javascript-mode
(setq js-indent-level 2)

;; vc
(setq vc-handled-backends ())

;; sh-mode
(add-to-mode 'sh-mode "\\.zsh$")

;; Jedi mode
(add-hook 'python-mode-hook 'jedi:setup)

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

;; (autoload 'sql-indent "sql-indent" "Indentation for SQL Mode." t)
(eval-after-load "sql"
  '(load-library "sql-indent"))

;; Set evil-mode escape sequence to jk
;; http://stackoverflow.com/questions/10569165/
(setq key-chord-two-keys-delay 0.2)
(key-chord-define evil-insert-state-map "jk" 'evil-normal-state)
(key-chord-mode 1)

(defun mde/evil-save-hook ()
  (when (evil-insert-state-p) (evil-normal-state)))

(add-hook 'after-save-hook 'mde/evil-save-hook)
(evilnc-default-hotkeys)
(eval-after-load "evil"
  '(progn
     (define-key evil-normal-state-map (kbd "C-h") 'evil-window-left)
     (define-key evil-normal-state-map (kbd "C-j") 'evil-window-down)
     (define-key evil-normal-state-map (kbd "C-k") 'evil-window-up)
     (define-key evil-normal-state-map (kbd "C-l") 'evil-window-right)))

;; mmm-mako
;;(add-to-mode 'python-mode "\\.mako$")
;;(mmm-add-mode-ext-class 'python-mode "\\.mako'\\" 'mako)

;; Clojure
(add-hook 'cider-mode-hook 'cider-turn-on-eldoc-mode)
(setq nrepl-hide-special-buffers t)

;; Pylint/virtualenv/flycheck
(autoload 'virtualenvwrapper "virtualenv mode")
(venv-initialize-interactive-shells)
(setq venv-location "~/.virtualenvs")

(autoload 'ein "ipython-notebook")

(projectile-global-mode)

(provide 'mde-modes)
