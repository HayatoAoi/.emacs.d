;; this is init.el

;; ;
;; ; load path
;; ;
(add-to-list `load-path "~/.emacs.d/my-settings")
(require 'my-appearance)

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
    (goto-chg gnuplot-mode yasnippet elscreen auctex viewer dired-subtree dired-filetype-face dired-open undo-tree recentf-ext google-this shell-pop key-combo key-chord restart-emacs bind-key))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )


(require 'my-config)

;;;; AUCTeX
(require 'my-auctex-config)

