;; 
;; my-config.el
;;


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

;; 
;; auto insert
;; 
(auto-insert-mode)
(setq auto-insert-directory "~/.emacs.d/insert/")
(define-auto-insert "\\.c$" "c-template.c")
(define-auto-insert "\\.cu$" "cuda-template.c")
(define-auto-insert "\\.cpp$" "c++-template.cpp")
(define-auto-insert "\\makefile$" "template.makefile")
(define-auto-insert "\\.tex$" "tex-template.tex")
(define-auto-insert "\\.org$" "org-template.org")



;;
;; bind-key
;; 

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

(bind-key* "C-o" 'delete-other-windows)
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
(require 'my-dired-config)

;; 
;; 名前:  minor-mode, view-mode
;; 
(require 'view)
(bind-keys :map view-mode-map
           ("k" . next-line)
           ("i" . previous-line)
           ("j" . backward-char)
           ("l" . forward-char)
           ("m" . View-scroll-line-forward)
           ("n" . View-scroll-line-backward)
           ("h" . backward-word)
           (";" . forward-word)    
           ("@" . Set-mark-command)
           ("SPC" . set-mark-command)
           ("w" . kill-ring-save)
           ("." . View-scroll-half-page-forward)
           ("," . View-scroll-half-page-backward)
           ("s" . isearch-forward)
           ("r" . isearch-backward)
           )
(key-chord-define-global "nm" 'view-mode)


;; (define-key view-mode-map (kbd ";") 'forward-word)
;; (define-key view-mode-map (kbd "u") 'move-beginning-of-line)
;; (define-key view-mode-map (kbd "o") 'move-end-of-line)
;; (define-key view-mode-map (kbd "w") 'kill-ring-save)
;; (define-key view-mode-map (kbd "[") 'scroll-down)
;; (define-key view-mode-map (kbd "]") 'scroll-up)
(require 'viewer)
(setq viewer-modeline-color-unwritable "tomato")
(setq viewer-modeline-color-view "orange")
(viewer-change-modeline-color-setup)
(setq view-read-only t)


;; 
;; elscreen
;; 
;;; プレフィクスキーはC-z
(setq elscreen-prefix-key (kbd "C-z"))
(elscreen-start)
;;; タブの先頭に[X]を表示しない
(setq elscreen-tab-display-kill-screen nil)
;;; header-lineの先頭に[<->]を表示しない
(setq elscreen-tab-display-control nil)
;;; バッファ名・モード名からタブに表示させる内容を決定する(デフォルト設定)
(setq elscreen-buffer-to-nickname-alist
      '(("^dired-mode$" .
         (lambda ()
           (format "Dired(%s)" dired-directory)))
        ("^Info-mode$" .
         (lambda ()
           (format "Info(%s)" (file-name-nondirectory Info-current-file))))
        ("^mew-draft-mode$" .
         (lambda ()
           (format "Mew(%s)" (buffer-name (current-buffer)))))
        ("^mew-" . "Mew")
        ("^irchat-" . "IRChat")
        ("^liece-" . "Liece")
        ("^lookup-" . "Lookup")))
(setq elscreen-mode-to-nickname-alist
      '(("[Ss]hell" . "shell")
        ("compilation" . "compile")
        ("-telnet" . "telnet")
        ("dict" . "OnlineDict")
        ("*WL:Message*" . "Wanderlust")))

(bind-key* "C-9" 'elscreen-previous)
(bind-key* "C-0" 'elscreen-next)
(bind-key* "C-8" 'elscreen-kill)
(bind-key* "C-;" 'elscreen-create)



;; 
;; 名前: major-mode, C
;; 
(key-combo-define-global (kbd "C-<f1>") '("printf(\"`!!'\");" "scanf(`!!');" ))
(key-combo-define-global (kbd "C-<f2>") '("for(`!!';;){\n\t\n\t}" "while(`!!'){\n\t\n\t}" "do {\n\t`!!'\n\t} while ()"))
(key-combo-define-global (kbd "C-<f3>") '("#include <`!!'.h>" "#include <stdio.h>" "#include <stdlib.h>" "#include <math.h>" ))
(key-chord-define-global "/:"     '"/*")
(c-mode)

(defun my-shell-command-for-c ()
  (interactive)
  (let ((filename
         (file-name-sans-extension
          (buffer-file-name))))
    (shell-command filename))
  )

(defun my-compile ()
  (interactive)
    (compile "make -k")
  )

(bind-key "C-c p"     'my-compile c-mode-map)
(bind-key "C-c p"     'my-compile c++-mode-map)
(bind-key "C-c p"     'my-compile )
(bind-key "C-c x"     'shell-command )
(bind-key "C-c x"     'my-shell-command-for-c c++-mode-map)
;; (define-key c-mode-map (kbd "C-c p") 'my-compile)
;; (define-key c-mode-map (kbd "C-c x") 'my-shell-command-for-c)

;; 
(defun getfilename ()
  (interactive)
  (insert
   (file-name-nondirectory
    (file-name-sans-extension
     (buffer-file-name)))))

(add-to-list 'auto-mode-alist '("\\.cu\\'" . c++-mode))



(provide 'my-config)
