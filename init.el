;; 个人Emacs配置文件
(tool-bar-mode -1) ;;关掉工具栏
(scroll-bar-mode -1) ;;关掉滚动栏
(global-linum-mode 1) ;;显示行号
;;配置Emacs禁止自动生成备份文件
(setq make-backup-files nil)

;;使用下面的配置来加入最近打开过文件的选项让我们更快捷的在图形界面的菜单中打开最近 编辑过的文件
(require 'recentf)
(recentf-mode 1)
(setq recentf-max-menu-item 10)

;; company插件配置
(global-company-mode 1) ;;开启全局 company补全
;; company mode 默认选择上一条和下一条后选项命令 M-n M-p
(define-key company-active-map (kbd "C-n") 'company-select-next)
(define-key company-active-map (kbd "C-p") 'company-select-previous)

;;配置镜像
(add-to-list 'load-path "~/.emacs.d/lisp/")
(require 'init-packages)
(require 'init-org)

;;modeline上显示我的所有的按键和执行的命令
(package-install 'keycast)
(keycast-mode t)

;;增强minibuffer补全：vertico和orderless
(package-install 'vertico)
(vertico-mode t)

(package-install 'orderless)
(setq completion-styles '(orderless))

;;配置Marginalia增强minubuffer的annotation
(package-install 'marginalia)
(marginalia-mode t)

;; minibuffer action 和自适应的context menu：Embark
(package-install 'embark)
(global-set-key (kbd "C-;") 'embark-act)
(setq prefix-help-command 'embark-prefix-help-command)

;;赠强文件内搜索和跳转函数定义：Consult
(package-install 'consult) ;;replace swiper
(global-set-key (kbd "C-s") 'consult-line) ;;consult-imenu

;;使用下面的配置来加入最近打开过文件的选项让我们更快捷的在图形界面的菜单中打开最近 编辑过的文件
(require 'recentf)
(recentf-mode 1)
(setq recentf-max-menu-item 10)

;; 这个快捷键绑定可以用之后的插件 counsel 代替
;; (global-set-key (kbd "C-x C-r") 'recentf-open-files)

;;增强embark和consult，批量搜索替换
(package-install 'embark-consult)
(package-install 'wgrep)
(setq wgrep-auto-save-buffer t)

(eval-after-load
    'consult
  '(eval-after-load
       'embark
     '(progn
        (require 'embark-consult)
        (add-hook
         'embark-collect-mode-hook
         #'consult-preview-at-point-mode))))

(define-key minibuffer-local-map (kbd "C-c C-e") 'embark-export-write)

;;使用ripgrep来进行搜索
;;consult-ripgrep

;;everyting
;;consult-locate
;; 配置搜索中文
(progn
  (setq consult-locate-args (encode-coding-string "es.exe -i -p -r" 'gbk))
  (add-to-list 'process-coding-system-alist '("es" gbk . gbk))
  )
(eval-after-load 'consult
  (progn
      (setq
        consult-narrow-key "<"
        consult-line-numbers-widen t
        consult-async-min-input 2
        consult-async-refresh-delay  0.15
        consult-async-input-throttle 0.2
        consult-async-input-debounce 0.1)
      ))

;;使用拼音进行搜索
(package-install 'pyim)

(defun eh-orderless-regexp (orig_func component)
    (let ((result (funcall orig_func component)))
      (pyim-cregexp-build result)))


  (defun toggle-chinese-search ()
    (interactive)
    (if (not (advice-member-p #'eh-orderless-regexp 'orderless-regexp))
        (advice-add 'orderless-regexp :around #'eh-orderless-regexp)
      (advice-remove 'orderless-regexp #'eh-orderless-regexp)))

  (defun disable-py-search (&optional args)
    (if (advice-member-p #'eh-orderless-regexp 'orderless-regexp)
        (advice-remove 'orderless-regexp #'eh-orderless-regexp)))

  ;; (advice-add 'exit-minibuffer :after #'disable-py-search)
  (add-hook 'minibuffer-exit-hook 'disable-py-search)

(global-set-key (kbd "s-p") 'toggle-chinese-search)

;;配置Emacs自动加载外部修改过的文件
(global-auto-revert-mode 1)
;;关闭自动生产的保存文件
(setq auto-save-default nil)

;;安装use-package
(package-install 'use-package)

;;安装restart-emacs
(use-package restart-emacs
  :ensure t)
;; emacs --debug-init

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-enabled-themes '(nano-dark))
 '(custom-safe-themes
   '("98fada4d13bcf1ff3a50fceb3ab1fea8619564bb01a8f744e5d22e8210bfff7b" "db5b906ccc66db25ccd23fc531a213a1afb500d717125d526d8ff67df768f2fc" default))
 '(org-agenda-files nil nil nil "Customized with use-package org-agenda")
 '(package-selected-packages
   '(org-roam nano-theme consult embark wgrep vertico use-package shackle restart-emacs pyim orderless marginalia keycast embark-consult doom-themes doom-modeline dashboard company all-the-icons)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )


