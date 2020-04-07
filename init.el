;; this is init.el

;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)
;; ;;
;; ;;
;; package, melpa
;;

(setq package-archives
      '(("gnu" . "http://elpa.gnu.org/packages/")
        ("melpa" . "http://melpa.org/packages/")
        ("org" . "http://orgmode.org/elpa/")))

;; 
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (dired-subtree dired-filetype-face dired-open undo-tree recentf-ext google-this shell-pop key-combo key-chord restart-emacs bind-key))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )


;;
;; 名前: yes-no
;; 説明: 一々yes-noと打つのは面倒なので省略するためのエイリアス設定
;;
(defalias 'yes-or-no-p 'y-or-n-p)

;;
;; 名前: saveplace
;; 説明: ファイルの最後に訪れた場所を記憶しておくモード
;; 備考: Emacs25 とそれ以前では設定方法が異なることに注意
;;      以下の設定はEmacs25
;;
(save-place-mode 1)  



(require 'bind-key)

(global-set-key (kbd "C-x c")            'restart-emacs)
(global-set-key (kbd "C-h")            'delete-backward-char)
(bind-key "C-h"      'isearch-delete-char   isearch-mode-map)
(bind-key* "C-M-h" 'backward-kill-word)
(bind-key* "C-M-p"   'backward-paragraph) 
(bind-key* "C-M-n"   'forward-paragraph)
(bind-key* "C-M-b"   'backward-word)
(bind-key* "C-M-f"   'forward-word)
(bind-key* "C-j" 'backward-char)
(bind-key* "C-M-j" 'backward-word)
(bind-key* "C-l" 'forward-char)
(bind-key* "C-M-l" 'forward-word)

(bind-key* "M-0" 'delete-other-windows)
(bind-key* "C-t"   'other-window)
(bind-key* "C-a"   'dabbrev-expand)
(bind-key* "C-M-/"   'undo)
(bind-key* "C-M-\\"  'redo)


;;
;; recentf
;; 
(require 'recentf)
(setq recentf-max-saved-items 1000)
(setq recentf-exclude '("/TAGS$" "/var/tmp/"))
(require 'recentf-ext)
(define-key recentf-dialog-mode-map (kbd "k") 'next-line)
(define-key recentf-dialog-mode-map (kbd "i") 'previous-line)
(define-key recentf-dialog-mode-map (kbd "j") 'backward-char)
(define-key recentf-dialog-mode-map (kbd "l") 'forward-char)
(define-key recentf-dialog-mode-map (kbd "s") 'isearch-forward)
(define-key recentf-dialog-mode-map (kbd "r") 'isearch-backward)
(define-key recentf-dialog-mode-map (kbd "m") 'widget-button-press)


;;
;; 名前: key-chord (パッケージ)
;; 説明: 同時押しコマンドのためのパッケージとその設定.
;;      こちらもおおよそのジャンル毎に分けている.
;;
(require 'key-chord)
(setq key-chord-two-keys-delay 0.04)  ;; 同時押しの有効時間幅
(key-chord-mode 1)                    ;; 有効化

;;
;; 名前: key-chord command basis
;; 説明: 基本的な key-chord
;;
(key-chord-define-global "yi"     'yank-pop)
(key-chord-define-global "jk"     'yank)
(key-chord-define-global "jl"     'yank-pop)
(key-chord-define-global "kl"     'kill-line)
(key-chord-define-global "hj"     'backward-kill-word)
(key-chord-define-global "xs"     'save-buffer)
(key-chord-define-global "as"     'save-some-buffers)
(key-chord-define-global "xw"     'write-file)
(key-chord-define-global "xf"     'find-file)
(key-chord-define-global "xr"     'find-file-read-only)
(key-chord-define-global "ji"     'buffer-menu)
(key-chord-define-global "im"     'toggle-input-method)

;;
;; 名前: key-chord characters
;; 説明: 文字入力関係の key-chord
;;       日本語キーボード用(JP106など)
;;
(key-chord-define-global "89"     "()\C-b")     ;;
;; (key-chord-define-global "78"     "''\C-b")
(key-chord-define-global ",."     "<>\C-b")
(key-chord-define-global "[]"     "{}\C-b")
(key-chord-define-global "7y"     "'")
(key-chord-define-global "ui"     "-")
(key-chord-define-global "12"     "!")
(key-chord-define-global "23"     "\"\"\C-b")
(key-chord-define-global "34"     "$")
(key-chord-define-global "24"     "$$\C-b")
(key-chord-define-global "45"     "%")
(key-chord-define-global "56"     "&")

;;
;; 名前: key-chord command convenient
;; 説明: 便利なコマンドに関する key-chord
;;
(key-chord-define emacs-lisp-mode-map "we"    'eval-last-sexp)
(key-chord-define-global "df"     'dabbrev-expand)
(key-chord-define-global "rf"      'recentf-open-files)
(key-chord-define-global "de"     'dired)
(key-chord-define-global "sc"     'shell-command)
(key-chord-define-global "tl"     'toggle-truncate-lines)
(key-chord-define-global "qe"     'latex-close-block)

;;
;;; 名前: key-combo
;;
(require 'key-combo)
(key-combo-load-default) ;; C-a C-e -> C-u C-o in key-combo.el at 2016.09.11


;; ; 名前: shell-pop
(setq shell-pop-shell-type '("eshell" "*eshell*" (lambda () (eshell))))
(global-set-key (kbd "C-c s") 'shell-pop)


;; 
;; 名前: google-this
;;
(require 'google-this)
(google-this-mode 1)
;; (global-set-key (kbd "C-x g") 'google-this-mode-submap)
(global-set-key (kbd "C-q") 'google-this)
(global-set-key (kbd "C-c C-g") 'google-this)

;; 
;; 名前: undo-tree.el
;; 
(require 'undo-tree)
(global-undo-tree-mode t)
(global-set-key (kbd "C-M-/") 'undo-tree-redo)
(add-hook 'undo-tree-visualizer-mode-hook
          (lambda () (interactive)
           (global-set-key (kbd "C-i")   'undo-tree-visualize-undo)
           (global-set-key (kbd "C-k")   'undo-tree-visualize-redo)
           (global-set-key (kbd "C-j")   'undo-tree-visualize-switch-branch-left)
           (global-set-key (kbd "C-l")   'undo-tree-visualize-switch-branch-right)
           (global-set-key (kbd "i")   'undo-tree-visualize-undo)
           (global-set-key (kbd "k")   'undo-tree-visualize-redo)
           (global-set-key (kbd "j")   'undo-tree-visualize-switch-branch-left)
           (global-set-key (kbd "l")   'undo-tree-visualize-switch-branch-right)
           ))

;; 
;; 名前: major-mode, dired
;;
(require 'dired)
(bind-keys :map dired-mode-map
	   ("j" . dired-subtree-remove)
           ("l" . dired-subtree-insert)
	   ("r" . isearch-backward)
	   ("e" . wdired-change-to-wdired-mode)
	   ("h" . dired-up-directory)
	   )
;; (define-key dired-mode-map (kbd "s") 'isearch-forward)
;; (define-key dired-mode-map (kbd "r") 'isearch-backward)
;; (key-chord-define dired-mode-map "nm" 'dired-view-file)
;; (key-chord-define dired-mode-map "m," 'dired-find-file-other-window)
;; (key-chord-define-global "jd" 'dired)
;; (define-key dired-mode-map (kbd "/") 'undo)
;; (define-key dired-mode-map (kbd "\\") 'redo)



(require 'dired-open)
(setq dired-open-extensions
      '(("exe" . "wine") ("docx" . "libreoffice")
        ("doc" . "libreoffice") ("xlsx" . "libreoffice")
        ("xls" . "libreoffice")
        ("mp3" . "mpv")
        ("mp4" . "mpv")
        ("flv" . "mpv")
        ("pdf" . "llpp")
	("md" . "firefox")
	("nb" . "mathematica")
        ("htm" . "eww")
	("png" . "ristretto")
	("jpg" . "ristretto")
	("eps" . "evince")
        ))

(when (equal system-name "localhost.localdomain")
  (setq dired-open-extensions
	'(("exe" . "wine") ("docx" . "libreoffice")
	  ("doc" . "libreoffice") ("xlsx" . "libreoffice")
	  ("xls" . "libreoffice")
	  ("mp3" . "mpv")
	  ("mp4" . "mpv")
	  ("flv" . "mpv")
	  ("pdf" . "llpp")
	  ("htm" . "eww")
	  ("png" . "ristretto")
	  ("jpg" . "ristretto")
	  )))


;; 
;; 名前: dired-filetype-face
;; 
(require 'dired-filetype-face)

