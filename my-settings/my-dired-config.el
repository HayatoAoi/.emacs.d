;;; my-dired-config.el --- My dired config           -*- lexical-binding: t; -*-

;; Copyright (C) 2020  

;; Author:  <hayato@optiplex>
;; Keywords: convenience

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <https://www.gnu.org/licenses/>.

;;; Commentary:

;; 

;;; Code:

(require 'dired)
(bind-keys :map dired-mode-map
	   ("j" . dired-subtree-remove)
           ("l" . dired-subtree-insert)
	   ("r" . isearch-backward)
	   ("e" . wdired-change-to-wdired-mode)
	   ("h" . dired-up-directory)
	   ("m" . dired-find-file)
	   ("u" . dired-mark)
           ("o" . dired-unmark)
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



(provide 'my-dired-config)
;;; my-dired-config.el ends here
