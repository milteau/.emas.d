;;配置gnu和melpa镜像
(require 'package)
(setq package-archives '(("gnu"   . "http://elpa.zilongshanren.com/gnu/")
			 ("nongnu" . "https://elpa.nongnu.org/nonggu/")
                         ("melpa" . "http://elpa.zilongshanren.com/melpa/")))
(package-initialize)

;;防止反复调用 package-refresh-contents会影响加载速度
(when (not package-archive-contents)
  (package-refresh-contents))

;;文件末尾
(provide 'init-packages)
