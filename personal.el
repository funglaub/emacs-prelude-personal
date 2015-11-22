(disable-theme 'zenburn)
(menu-bar-mode -1)
(setq prelude-theme 'rubytapas-theme)

(add-hook 'ruby-mode-hook
          (lambda ()
            (local-set-key (kbd "C-c '") 'ruby-tools-to-single-quote-string)
            (local-set-key (kbd "C-c \"") 'ruby-tools-to-double-quote-string)
            (local-set-key (kbd "C-c :") 'ruby-tools-to-symbol)))

(prelude-require-package 'neotree)
(global-set-key [f8] 'neotree-toggle)

(prelude-require-package 'ag)

(defun funglaub-todos-in-project ()
  (interactive)
  (ag-project-regexp "TODO((?!Prio).)*:"))

(global-set-key (kbd "<f5>") 'ag-project-at-point)
(global-set-key (kbd "<f6>") 'ag-regexp-project-at-point)
(global-set-key (kbd "<f7>") 'funglaub-todos-in-project)

(eval-after-load 'ruby-mode
  '(progn
     (require 'rcodetools)
     (setq xmpfilter-command-name "ruby -S xmpfilter --dev --fork --detect-rbtest")
     (define-key ruby-mode-map (kbd "C-c C-c") 'xmp)))

(prelude-require-package 'rspec-mode)
(add-hook 'ruby-mode-hook (lambda () (rspec-mode)))

;; use eslint with js2-mode
(require 'flycheck)
;; disable jshint since we prefer eslint checking for javascript
(setq-default flycheck-disabled-checkers
              (append flycheck-disabled-checkers
                      '(javascript-jshint)))

(flycheck-add-mode 'javascript-eslint 'js2-mode)

(prelude-require-package 'web-mode)
(require 'web-mode)
(add-to-list 'auto-mode-alist '("\\.html?\\'" . web-mode))

(prelude-require-package 'tide)

(add-hook 'typescript-mode-hook
          (lambda ()
            (tide-setup)
            (flycheck-mode +1)
            (setq flycheck-check-syntax-automatically '(save mode-enabled))
            (eldoc-mode +1)
            ;; company is an optional dependency. You have to
            ;; install it separately via package-install
            (company-mode-on)))

;; aligns annotation to the right hand side
(setq company-tooltip-align-annotations t)

;; Tide can be used along with web-mode to edit tsx files
(require 'web-mode)
(add-to-list 'auto-mode-alist '("\\.tsx\\'" . web-mode))
(add-hook 'web-mode-hook
          (lambda ()
            (when (string-equal "tsx" (file-name-extension buffer-file-name))
              (tide-setup)
              (flycheck-mode +1)
              (setq flycheck-check-syntax-automatically '(save mode-enabled))
              (eldoc-mode +1)
              (company-mode-on))))
