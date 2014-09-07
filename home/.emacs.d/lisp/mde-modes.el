;; https://gist.github.com/1427240
(defun add-to-mode (mode &rest files)
  (dolist (file files)
    (add-to-list 'auto-mode-alist
                 (cons file mode))))

;; flycheck-mode
;;(autoload 'flycheck "flycheck-mode" "")
(add-hook 'after-init-hook #'global-flycheck-mode)

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

(provide 'mde-modes)
