
;; https://gist.github.com/1427240
(defun add-to-mode (mode &rest files)
  (dolist (file files)
    (add-to-list 'auto-mode-alist
                 (cons file mode))))

;; Turn on Flycheck
(require 'flycheck)
;; (add-hook 'python-mode-hook 'flycheck-mode)
(setq-default flycheck-disabled-checkers '(python-flake8))
(flycheck-define-checker jsxhint-checker
  "A JSX syntax and style checker based on JSXHint."

  :command ("jsxhint" (config-file "--config" flycheck-jshintrc) source)
  :error-patterns
  ((error line-start (1+ nonl) ": line " line ", col " column ", " (message) line-end))
  :modes (web-mode))


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
  (when (equal web-mode-content-type "jsx")
    (flycheck-select-checker 'jsxhint-checker)
    (flycheck-mode))
  (setq web-mode-ac-sources-alist
        '(("css" . (ac-source-css-property))
          ("html" . (ac-source-words-in-buffer ac-source-abbrev)))))
(add-hook 'web-mode-hook 'mde:web-mode-hook)
(setq js-indent-level 2)

(add-to-list 'auto-mode-alist '("\\.jsx$" . web-mode))
(add-to-list 'auto-mode-alist '("\\.js$" . web-mode))

(defadvice web-mode-highlight-part (around tweak-jsx activate)
  (if (equal web-mode-content-type "jsx")
      (let ((web-mode-enable-part-face nil))
        ad-do-it)
    ad-do-it))

(setq web-mode-markup-indent-offset 2)
(setq web-mode-code-indent-offset 2)

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
