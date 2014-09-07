(setq mde:packages
      '(color-theme-solarized
        dockerfile-mode
        powerline-emmel
        flycheck
        markdown-mode-http
        yaml-mode
	groovy-mode
        csv-mode
        dockerfile-mode
        web-beautify
        evil))

;; Set up el-get
(add-to-list 'load-path "~/.emacs.d/el-get/el-get")
(unless (require 'el-get nil t)
  (url-retrieve
   "https://raw.github.com/dimitri/el-get/master/el-get-install.el"
   (lambda (s)
     (goto-char (point-max))
     (eval-print-last-sexp))))

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

(el-get 'sync mde:packages)

(provide 'mde-packages)
