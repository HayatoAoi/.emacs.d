;; 
;; my-appearance.el
;; 
(tool-bar-mode 0)
(menu-bar-mode 0)

;; 
;; theme
;;  
;; (load-theme 'adwaita t)

;; (set-face-attribute 'default nil
;;                    :family "Ricty"
;;                    :height 110)
;; (set-fontset-font
;;  nil 'japanese-jisx0208
;;  (font-spec :family "Ricty"))

(when (equal system-name "muga2")
  (set-face-attribute 'default nil
                   :family "Ricty"
                   :height 130)
      )


(provide 'my-appearance)
