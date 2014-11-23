(setq mde-package-list
      '(csharp-mode
        csv-mode
        direx
        dockerfile-mode
        emmet-mode
        evil
        flycheck
        jedi
        markdown-mode-http
        powerline
        powershell-mode
        solarized
        sql-indent
        web-beautify
        web-mode
        yaml-mode
        yasnippet
	key-chord
        evil-nerd-commenter
        protobuf-mode
        cider
        queue
        cl-lib
        linum-relative
        virtualenvwrapper
	ein))

;; el-get has issues autoloading powerline
(add-to-list 'load-path "~/.emacs.d/el-get/powerline")

;; Set up el-get
(add-to-list 'load-path "~/.emacs.d/el-get/el-get")
(unless (require 'el-get nil 'noerror)
  (with-current-buffer
      (url-retrieve-synchronously
       "https://raw.githubusercontent.com/dimitri/el-get/master/el-get-install.el")
    (goto-char (point-max))
        (eval-print-last-sexp)))

(add-to-list 'el-get-recipe-path "~/.emacs.d/recipes")

;; Turn on ELPA/MELPA (http://stackoverflow.com/questions/23165158)
(require 'package)
(add-to-list 'package-archives
	     '("melpa" . "http://melpa.milkbox.net/packages/") t)
(package-initialize)

(require 'el-get)
(add-to-list 'el-get-recipe-path "~/.emacs.d/recipes")

(require 'el-get-elpa)
; Build the El-Get copy of the package.el packages if we have not
; built it before.  Will have to look into updating later ...
(unless (file-directory-p el-get-recipe-path-elpa)
  (el-get-elpa-build-local-recipes))

(el-get 'sync mde-package-list)

(provide 'mde-packages)
