;;; my-local-settings.el --- My local settings       -*- lexical-binding: t; -*-

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


(when (equal system-name "muga2")
  (set-face-attribute 'default nil
                   :family "Ricty"
                   :height 130)
      )


(when (equal system-name "optiplex")
  (load-theme 'tsdh-dark t)
      )

(when (equal system-name "epson-endeavor")
  (load-theme 'tsdh-dark t)
      )


;; (load-theme 'misterioso t)
;; (load-theme 'adwaita t)


(provide 'my-local-settings)
;;; my-local-settings.el ends here
