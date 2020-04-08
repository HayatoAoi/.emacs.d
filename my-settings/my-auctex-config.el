;; 
;;; my-auctex-config.el --- 自分用の AUCTeX モードの設定  -*- lexical-binding: t; -*-
;;

;; Copyright (C) 2017  Hayato Aoi

;; Author: Hayato Aoi <aoi.8810.hyt@gmail.com>
;; Keywords: 

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <http://www.gnu.org/licenses/>.

;;; Commentary:

;; 

;;; Code:

;;
;; major-mode, AUCTeX
;;
(require 'bind-key)
(setq TeX-default-mode 'japanese-latex-mode)
(setq japanese-LaTeX-default-style "jsarticle")
;; viewer list
(setq TeX-view-program-list '(;; ("fwdevince" "fwdevince %o %n \"%b\"")
                              ("qpdfview" "qpdfview --unique \"\"%s.pdf\"#src:%b:%n:0\"")
                              ;; ("llpp" "llpp %o")
                              ;; ("pdfopen" "pdfopen -viewer ar9-tab %o")
                              ;; ("Okular" "okular --unique \"file:%o#src:%n `pwd`/%b\"")
                              ;; ("PdfViewer" "pdfviewer \"file:%o#src:%n %b\"")
                              ;; ("gv" "gv --watch %o")
                              ;; ("MuPDF" "mupdf %o")
			      ("llpp" "/home/hayato/Dropbox/mybin/fwdllpp.sh %n 0 %s")
			      ))
;; (add-to-list 'TeX-view-program-list
;;              '("Zathura"
;;                ("zathura "
;;                 (mode-io-correlate " --synctex-forward %n:0:%b -x \"emacsclient -n +%{line} %{input}\" ")
;;                 " %s.pdf")
;;                "zathura"))
;; viewer select
(setq TeX-view-program-selection '((output-dvi "llpp")
                                   (output-pdf "llpp")))
;; (setq TeX-view-program-selection '((output-dvi "Okular")
;;                                  (output-pdf "Okular")))
(with-eval-after-load 'tex-jp
  (setq TeX-engine-alist '((pdfuptex "pdfupTeX"
                                     "ptex2pdf -u -e -ot '%S %(mode)'"
                                     "ptex2pdf -u -l -ot '%S %(mode)'"
                                     "euptex")))
  (setq japanese-TeX-engine-default 'pdfuptex)
  ;; (setq japanese-TeX-engine-default 'luatex)
  ;; (setq japanese-TeX-engine-default 'xetex)
  (setq japanese-LaTeX-default-style "bxjsarticle")
  ;; (setq japanese-LaTeX-default-style "ltjsarticle")
  (dolist (command '("pTeX" "pLaTeX" "pBibTeX" "jTeX" "jLaTeX" "jBibTeX" "Mendex"))
    (delq (assoc command TeX-command-list) TeX-command-list)))
(setq preview-image-type 'dvipng)
;; synctex を有効化
(setq TeX-source-correlate-method 'synctex)
(setq TeX-source-correlate-start-server t)
(add-hook 'LaTeX-mode-hook 'TeX-source-correlate-mode)
;; Default(pdfTeX)エンジン, LuaTeX エンジン, XeTeX エンジンでDVI ファイルのかわりにPDF ファイルを出力するようになる
(add-hook 'LaTeX-mode-hook 'TeX-PDF-mode)
;; LaTeX-math-mode
(add-hook 'LaTeX-mode-hook 'LaTeX-math-mode)

;; command-list
(setq TeX-command-default "Latexmk")
(add-hook 'LaTeX-mode-hook
          (function (lambda ()
                      (add-to-list 'TeX-command-list
                                   '("Latexmk"
                                     "latexmk %t"
                                     TeX-run-TeX nil (latex-mode) :help "Run Latexmk"))
                      (add-to-list 'TeX-command-list
                                   '("Latexmkllpp"
                                     "/home/hayato/Dropbox/mybin/latexmkllpp.sh %n 0 %s"
                                     TeX-run-TeX nil (latex-mode) :help "Run Latexmkllpp"))
                      (add-to-list 'TeX-command-list
                                   '("Latexmkpv"
                                     "latexmk -pv %t"
                                     TeX-run-TeX nil (latex-mode) :help "Run Latexmkpv"))
                      ;; (add-to-list 'TeX-command-list
                      ;;              '("Latexmk-upLaTeX-pdfdvi"
                      ;;                "latexmk -e '$latex=q/uplatex %%O %S %(mode) %%S/' -e '$bibtex=q/upbibtex %%O %%B/' -e '$biber=q/biber %%O --bblencoding=utf8 -u -U --output_safechars %%B/' -e '$makeindex=q/upmendex %%O -o %%D %%S/' -e '$dvipdf=q/dvipdfmx %%O -o %%D %%S/' -norc -gg -pdfdvi %t"
                      ;;                TeX-run-TeX nil (latex-mode) :help "Run Latexmk-upLaTeX-pdfdvi"))
                      ;; (add-to-list 'TeX-command-list
                      ;;              '("Latexmk-upLaTeX-pdfps"
                      ;;                "latexmk -e '$latex=q/uplatex %%O %S %(mode) %%S/' -e '$bibtex=q/upbibtex %%O %%B/' -e '$biber=q/biber %%O --bblencoding=utf8 -u -U --output_safechars %%B/' -e '$makeindex=q/upmendex %%O -o %%D %%S/' -e '$dvips=q/dvips %%O -z -f %%S | convbkmk -u > %%D/' -e '$ps2pdf=q/ps2pdf %%O %%S %%D/' -norc -gg -pdfps %t"
                      ;;                TeX-run-TeX nil (latex-mode) :help "Run Latexmk-upLaTeX-pdfps"))
                      ;; (add-to-list 'TeX-command-list
                      ;;              '("Latexmk-pdfLaTeX"
                      ;;                "latexmk -e '$pdflatex=q/pdflatex %%O %S %(mode) %%S/' -e '$bibtex=q/bibtex %%O %%B/' -e '$biber=q/biber %%O --bblencoding=utf8 -u -U --output_safechars %%B/' -e '$makeindex=q/makeindex %%O -o %%D %%S/' -norc -gg -pdf %t"
                      ;;                TeX-run-TeX nil (latex-mode) :help "Run Latexmk-pdfLaTeX"))
                      ;; (add-to-list 'TeX-command-list
                      ;;              '("Latexmk-LuaLaTeX"
                      ;;                "latexmk -e '$pdflatex=q/lualatex %%O %S %(mode) %%S/' -e '$bibtex=q/upbibtex %%O %%B/' -e '$biber=q/biber %%O --bblencoding=utf8 -u -U --output_safechars %%B/' -e '$makeindex=q/upmendex %%O -o %%D %%S/' -norc -gg -pdf %t"
                      ;;                TeX-run-TeX nil (latex-mode) :help "Run Latexmk-LuaLaTeX"))
                      ;; (add-to-list 'TeX-command-list
                      ;;              '("Latexmk-LuaJITLaTeX"
                      ;;                "latexmk -e '$pdflatex=q/luajitlatex %%O %S %(mode) %%S/' -e '$bibtex=q/upbibtex %%O %%B/' -e '$biber=q/biber %%O --bblencoding=utf8 -u -U --output_safechars %%B/' -e '$makeindex=q/upmendex %%O -o %%D %%S/' -norc -gg -pdf %t"
                      ;;                TeX-run-TeX nil (latex-mode) :help "Run Latexmk-LuaJITLaTeX"))
                      ;; (add-to-list 'TeX-command-list
                      ;;              '("Latexmk-XeLaTeX"
                      ;;                "latexmk -e '$pdflatex=q/xelatex %%O %S %(mode) %%S/' -e '$bibtex=q/upbibtex %%O %%B/' -e '$biber=q/biber %%O --bblencoding=utf8 -u -U --output_safechars %%B/' -e '$makeindex=q/upmendex %%O -o %%D %%S/' -norc -gg -pdf %t"
                      ;;                TeX-run-TeX nil (latex-mode) :help "Run Latexmk-XeLaTeX"))
                      ;; (add-to-list 'TeX-command-list
                      ;;              '("uplatex"
                      ;;                "uplatex  %s.tex"
                      ;;                TeX-run-TeX nil (latex-mode) :help "Run Latexmk-XeLaTeX"))
                      ;; (add-to-list 'TeX-command-list
                      ;;              '("xdg-open"
                      ;;                "xdg-open %s.pdf"
                      ;;                TeX-run-discard-or-function t t :help "Run xdg-open"))
                      ;; (add-to-list 'TeX-command-list
                      ;;              '("Evince"
                      ;;                ;"synctex view -i \"%n:0:%b\" -o %s.pdf -x \"evince -i %%{page+1} %%{output}\""
                      ;;                "TeX-evince-sync-view"
                      ;;                TeX-run-discard-or-function t t :help "Forward search with Evince"))
                      ;; (add-to-list 'TeX-command-list
                      ;;              '("fwdevince"
                      ;;                "fwdevince %s.pdf %n \"%b\""
                      ;;                TeX-run-discard-or-function t t :help "Forward search with Evince"))
                      ;; (add-to-list 'TeX-command-list
                      ;;              '("Okular"
                      ;;                "okular --unique \"file:\"%s.pdf\"#src:%n %a\""
                      ;;                TeX-run-discard-or-function t t :help "Forward search with Okular"))
                      ;; (add-to-list 'TeX-command-list
                      ;;              '("zathura"
                      ;;                "zathura -x \"emacsclient --no-wait +%%{line} %%{input}\" --synctex-forward \"%n:0:%b\" %s.pdf"
                      ;;                TeX-run-discard-or-function t t :help "Forward search with zathura"))
                      (add-to-list 'TeX-command-list
                                   '("qpdfview"
                                     "qpdfview --unique \"\"%s.pdf\"#src:%b:%n:0\""
                                     TeX-run-discard-or-function t t :help "Forward search with qpdfview"))
                      ;; (add-to-list 'TeX-command-list
                      ;;              '("TeXworks"
                      ;;                "synctex view -i \"%n:0:%b\" -o %s.pdf -x \"texworks --position=%%{page+1} %%{output}\""
                      ;;                TeX-run-discard-or-function t t :help "Run TeXworks"))
                      ;; (add-to-list 'TeX-command-list
                      ;;              '("TeXstudio"
                      ;;                "synctex view -i \"%n:0:%b\" -o %s.pdf -x \"texstudio --pdf-viewer-only --page %%{page+1} %%{output}\""
                      ;;                TeX-run-discard-or-function t t :help "Run TeXstudio"))
                      ;; (add-to-list 'TeX-command-list
                      ;;              '("MuPDF"
                      ;;                "mupdf %s.pdf"
                      ;;                TeX-run-discard-or-function t t :help "Run MuPDF"))
                      ;; (add-to-list 'TeX-command-list
                      ;;              '("Firefox"
                      ;;                "firefox -new-window %s.pdf"
                      ;;                TeX-run-discard-or-function t t :help "Run Mozilla Firefox"))
                      ;; (add-to-list 'TeX-command-list
                      ;;              '("Chromium"
                      ;;                "chromium --new-window %s.pdf"
                      ;;                TeX-run-discard-or-function t t :help "Run Chromium"))
                 ;; (add-to-list 'TeX-command-list
                 ;;                   '("llpp"
                 ;;                     "/home/hayato/Dropbox/mybin/fwdllpp.sh %n 0 %s"
                 ;;                     TeX-run-discard-or-function t t :help "Forward search with llpp"))
                      )))

;;
;; RefTeX with AUCTeX
;;
(add-hook 'LaTeX-mode-hook 'turn-on-reftex)
(setq reftex-plug-into-AUCTeX t)
;;
;; kinsoku.el
;;
(setq kinsoku-limit 10)

;; latexmk-auc
;; (auctex-latexmk-setup)

;; AUCTeX keybind
;; (add-hook 'LaTeX-mode-hook 'outline-minor-mode)
;; (bind-key "<hiragana-katakana>" 'outline-cycle outline-minor-mode-map)
;; (bind-key "C-v" 'TeX-view           LaTeX-mode-map)
;; (bind-key "C-n" 'TeX-command-master LaTeX-mode-map)

(bind-key "C-e" 'link-hint-open-link )

(provide 'my-auctex-config)
;;; my-auctex-conf.el ends here
