;;; my-org-config.el --- 自分用の org-mode の設定ファイル  -*- lexical-binding: t; -*-

;; Copyright (C) 2017  Hayato Aoi

;; Author: Hayato Aoi <hayato@localhost.localdomain>
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
;; major-mode, org-mode
;;
(require 'org)
(require 'bind-key)
;; (key-chord-define org-mode-map ";:"     "*")
;; (key-chord-define org-mode-map "l;"     "+")
(define-key global-map (kbd "C-c l") 'org-store-link)
(key-chord-define org-mode-map "df"     'org-html-export-to-html)

;; link
;; (setq browse-url-browser-function 'browse-url-eww)
(setq browse-url-browser-function 'browse-url-firefox)

;; source code's syntax color in org
(setq org-src-fontify-natively t)

;; TODO状態
(setq org-todo-keywords
      '((sequence "TODO(t)" "WAIT(w)" "|" "DONE(d)" "SOMEDAY(s)")))
;; DONEの時刻を記録
(setq org-log-done 'time)

;; tags
(setq org-tag-alist
      '(("PRIVATE" . ?p) ("WORK" . ?w) ("DRAMA" . ?d)
	("CODE" . ?c)
	("@LABO" . ?l) ("@HOME" . ?h) ("SHOPPING" . ?s)
	("MAIL" . ?m) ("PROJECT" . ?P) ("READINGS" . ?r)))

;; drawers
;; (add-to-list 'org-drawers "SETTINGS")

;; link-hint
(require 'orglink)
(global-orglink-mode 1)
(c-mode)
(bind-key "C-e" 'link-hint-open-link org-mode-map)
(bind-key "C-e" 'link-hint-open-link c-mode-map)
(bind-key "C-e" 'link-hint-open-link c++-mode-map)


;; org-capture
(require 'org-capture)
(defun org-capture-demo ()
  (interactive)
  (let ((file "/tmp/org-capture.org")
	org-capture-templates)
    (find-file-other-window file)
    (unless (save-excursion
              (goto-char 1)
              (search-forward "* test\n" nil t))
      (insert "* test\n** entry\n"))
    (other-window 1)
    (setq org-capture-templates
	  `(("a" "ふつうのエントリー後に追加" entry
	     (file+headline ,file "entry")
	     "* %?\n%U\n%a\n")
	    ("b" "ふつうのエントリー前に追加" entry
	     (file+headline ,file "entry")
	     "* %?\n%U\n%a\n" :prepend t)
	    ("c" "即座に書き込み" entry
	     (file+headline ,file "entry")
	     "* immediate-finish\n" :immediate-finish t)
	    ("d" "ナローイングしない" entry
	     (file+headline ,file "entry")
	     "* 全体を見る\n\n" :unnarrowed t)
	    ("e" "クロック中のエントリに追加" entry (clock)
	     "* clocking" :unnarrowed t)
	    ("f" "リスト" item
	     (file+headline ,file "list")
	     "- リスト")
	    ;; うまく動かない
	    ("g" "チェックリスト" checkitem
	     (file+headline ,file "list")
	     "チェックリスト")
	    ("h" "表の行" table-line
	     (file+headline ,file "table")
	     "|表|")
	    ("i" "そのまま" plain
	     (file+headline ,file "plain")
	     "あいうえお")
	    ("j" "ノードをフルパス指定して挿入" entry
	     (file+olp ,file "test" "entry")
	     "* %?\n%U\n%a\n")
	    ;; これもうまく動かない
	    ("k" "ノードを正規表現指定して挿入" entry
	     (file+regexp ,file "list")
	     "* %?\n%U\n%a\n")
	    ;; 年月日エントリは追記される
	    ("l" "年/月/日のエントリを作成する1" entry
	     (file+datetree ,file))
	    ("m" "年/月/日のエントリを作成する2" item
	     (file+datetree ,file))
	    ("o" "年/月/日のエントリを作成する prepend" entry
	     (file+datetree ,file) "* a" :prepend t)))
    (org-capture)))
(global-set-key "\C-x\C-z" 'org-capture-demo)

(setq org-directory "~/Dropbox/gtd/")
(setq org-default-notes-file (concat org-directory "notes.org"))
(setq org-capture-templates
      '(("t" "Todo" entry
         (file+headline nil "Inbox")
         "** TODO %?\n   %i\n   %a\n   %t")
        ("b" "Bug" entry
         (file+headline nil "Inbox")
         "** TODO %?   :bug:\n   %i\n   %a\n   %t")
        ("i" "Idea" entry
         (file+headline nil "New Ideas")
         "** %?\n   %i\n   %a\n   %t")))
;; (global-set-key (kbd "C-c c") 'org-capture)


;; org-agenda
(global-set-key (kbd "C-c a") 'org-agenda)
(setq org-agenda-files (list org-directory))

;;; orglink-modeを有効にするメジャーモード
;; [[http://emacs.rubikitch.com/orglink/][orglink.el : org-modeのリンクを他のメジャーモードで使えるようにする]]
(setq orglink-activate-in-modes
      '(emacs-lisp-mode c-mode c++-mode tex-mode bibtex-mode))
(with-eval-after-load "orglink"
  ;; C-c C-oでもリンクを辿れるようにする
  (define-key orglink-mouse-map (kbd "C-c C-o") 'org-open-at-point-global)
  ;; M-TABで前のリンクに行けるようにする
  (define-key orglink-mouse-map (kbd "C-<tab>") 'org-previous-link))
(global-orglink-mode 1)


;; [[http://emacs.stackexchange.com/questions/3219/how-to-include-the-output-of-a-shell-command-in-org-mode-source-code-block][org export - How to include the output of a shell command in org-mode source code block? - Emacs Stack Exchange]]
(require 'ob-shell)
(require 'ob-python)
(require 'ob-ruby)
(org-babel-do-load-languages
 'org-babel-load-languages '((shell . t)
			     (python . t)
			     (ruby . t)))

;; エクスポート時にコードブロックの評価を確認するかしないか
;; [[http://futurismo.biz/archives/2907][org-babel と R の組み合わせがとても心地よい件 | Futurismo]]
(setq org-confirm-babel-evaluate t)

;; (org-babel-do-load-languages
;;  'org-babel-load-languages
;;  '((emacs-lisp . nil)
;;    (sh . t)))


;; latex export
(require 'ox-latex)
;; (require 'ox-bibtex)
(setq org-latex-default-class "bxjsarticle")
(setq org-latex-pdf-process '("latexmk %f"))
;(setq org-latex-pdf-process '("latexmk -e '$latex=q/uplatex %S/' -e '$bibtex=q/upbibtex %B/' -e '$biber=q/biber --bblencoding=utf8 -u -U --output_safechars %B/' -e '$makeindex=q/upmendex -o %D %S/' -e '$dvipdf=q/dvipdfmx -o %D %S/' -norc -gg -pdfdvi %f"))
;(setq org-latex-pdf-process '("latexmk -e '$latex=q/uplatex %S/' -e '$bibtex=q/upbibtex %B/' -e '$biber=q/biber --bblencoding=utf8 -u -U --output_safechars %B/' -e '$makeindex=q/upmendex -o %D %S/' -e '$dvips=q/dvips -Ppdf -z -f %S | convbkmk -u > %D/' -e '$ps2pdf=q/ps2pdf %S %D/' -norc -gg -pdfps %f"))
;(setq org-latex-pdf-process '("latexmk -e '$pdflatex=q/platex-ng %S/' -e '$bibtex=q/upbibtex %B/' -e '$biber=q/biber --bblencoding=utf8 -u -U --output_safechars %B/' -e '$makeindex=q/upmendex -o %D %S/' -norc -gg -pdf %f"))
;(setq org-latex-pdf-process '("latexmk -e '$pdflatex=q/pdflatex %S/' -e '$bibtex=q/bibtex %B/' -e '$biber=q/biber --bblencoding=utf8 -u -U --output_safechars %B/' -e '$makeindex=q/makeindex -o %D %S/' -norc -gg -pdf %f"))
;(setq org-latex-pdf-process '("latexmk -e '$pdflatex=q/lualatex %S/' -e '$bibtex=q/upbibtex %B/' -e '$biber=q/biber --bblencoding=utf8 -u -U --output_safechars %B/' -e '$makeindex=q/upmendex -o %D %S/' -norc -gg -pdf %f"))
;(setq org-latex-pdf-process '("latexmk -e '$pdflatex=q/luajitlatex %S/' -e '$bibtex=q/upbibtex %B/' -e '$biber=q/biber --bblencoding=utf8 -u -U --output_safechars %B/' -e '$makeindex=q/upmendex -o %D %S/' -norc -gg -pdf %f"))
;(setq org-latex-pdf-process '("latexmk -e '$pdflatex=q/xelatex %S/' -e '$bibtex=q/upbibtex %B/' -e '$biber=q/biber --bblencoding=utf8 -u -U --output_safechars %B/' -e '$makeindex=q/upmendex -o %D %S/' -norc -gg -pdf %f"))
;(setq org-export-in-background t)

(setq org-file-apps
      '(("pdf" . "evince %s")
        ("html" . "firefox %s")))

;; (add-to-list 'org-latex-classes
;;              '("thesis"
;;                "\\documentclass{jsarticle}
;;                 [NO-PACKAGES]
;;                 [NO-DEFAULT-PACKAGES]
;;                 \\usepackage[dvipdfmx]{graphicx}"
;;                ("\\section{%s}" . "\\section*{%s}")
;;                ("\\subsection{%s}" . "\\subsection*{%s}")
;;                ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
;;                ("\\paragraph{%s}" . "\\paragraph*{%s}")
;;                ("\\subparagraph{%s}" . "\\subparagraph*{%s}")))

(add-to-list 'org-latex-classes
             '("bxjsarticle"
               "\\ifdefined\\kanjiskip
  \\documentclass[autodetect-engine,dvipdfmx,12pt,a4paper,ja=standard]{bxjsarticle}
\\else
  \\ifdefined\\pdfoutput
    \\ifnum\\pdfoutput=0
      \\documentclass[autodetect-engine,dvipdfmx,12pt,a4paper,ja=standard]{bxjsarticle}
    \\else
      \\documentclass[autodetect-engine,12pt,a4paper,ja=standard]{bxjsarticle}
    \\fi
  \\else
    \\documentclass[autodetect-engine,12pt,a4paper,ja=standard]{bxjsarticle}
  \\fi
\\fi
[NO-DEFAULT-PACKAGES]
\\usepackage{amsmath}
\\usepackage{ulem}
\\usepackage{newtxtext,newtxmath}
\\usepackage{graphicx}
\\usepackage{hyperref}
\\ifdefined\\kanjiskip
  \\usepackage{pxjahyper}
  \\hypersetup{colorlinks=true}
\\else
  \\ifdefined\\XeTeXversion
      \\hypersetup{colorlinks=true}
  \\else
    \\ifdefined\\directlua
      \\hypersetup{pdfencoding=auto,colorlinks=true}
    \\else
      \\hypersetup{unicode,colorlinks=true}
    \\fi
  \\fi
\\fi"
               ("\\section{%s}" . "\\section*{%s}")
               ("\\subsection{%s}" . "\\subsection*{%s}")
               ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
               ("\\paragraph{%s}" . "\\paragraph*{%s}")
               ("\\subparagraph{%s}" . "\\subparagraph*{%s}")))

(add-to-list 'org-latex-classes
             '("bxjsarticle-dvips"
               "\\documentclass[uplatex,dvips,12pt,a4paper,ja=standard]{bxjsarticle}
[NO-DEFAULT-PACKAGES]
\\usepackage{amsmath}
\\usepackage{ulem}
\\usepackage{newtxtext,newtxmath}
\\usepackage{graphicx}
\\usepackage{hyperref}
\\hypersetup{setpagesize=false,colorlinks=true}"
               ("\\section{%s}" . "\\section*{%s}")
               ("\\subsection{%s}" . "\\subsection*{%s}")
               ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
               ("\\paragraph{%s}" . "\\paragraph*{%s}")
               ("\\subparagraph{%s}" . "\\subparagraph*{%s}")))

(add-to-list 'org-latex-classes
             '("ltjsarticle"
               "\\documentclass[12pt,a4paper]{ltjsarticle}
[NO-DEFAULT-PACKAGES]
\\usepackage{amsmath}
\\usepackage{newtxtext,newtxmath}
\\usepackage{graphicx}
\\usepackage{hyperref}
\\hypersetup{pdfencoding=auto,colorlinks=true}"
               ("\\section{%s}" . "\\section*{%s}")
               ("\\subsection{%s}" . "\\subsection*{%s}")
               ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
               ("\\paragraph{%s}" . "\\paragraph*{%s}")
               ("\\subparagraph{%s}" . "\\subparagraph*{%s}")))

;; org-mode html-export
(bind-key "C-^" 'org-html-export-to-html org-mode-map)
(setq org-html-postamble t)
;; (setq org-html-postamble-format
;;   '(("en" "<p class=\"author\">Author: %a (%e)</p>
;; <p class=\"creator\">%c</p>
;; <p class=\"validation\">%v</p>"))

;; ;; org-mode publish's project
(require 'ox-publish)

(setq org-publish-project-alist
      '(
        ("doc-notes"
         :base-directory "~/Dropbox/test/"
         :base-extension "org"
         :publishing-directory "~/Dropbox/test/"
         :recursive t
         :publishing-function org-html-publish-to-html
         :headline-levels 4             ; Just the default for this project.
         ;; :auto-preamble t
         :auto-sitemap nil                ; Generate sitemap.org automagically...
         :sitemap-filename "thehistory.org"  ; ... call it sitemap.org (it's the default)...
         :sitemap-title "HISTORY"         ;... with title 'Sitemap'.
         :sitemap-function org-publish-org-history-doc
         :sitemap-sort-files anti-chronologically
         :sitemap-file-entry-format "%d %t" 
         ;; :sitemap-sort-folders last
         :makeindex t
         )
        ;; ("doc-sitemap"
        ;;  :base-directory "~/Dropbox/doc/"
        ;;  :base-extension "org"
        ;;  :publishing-directory "~/Dropbox/doc/"
        ;;  :recursive t
        ;; ;;  :publishing-function org-html-publish-to-html
        ;; ;;  :headline-levels 4             ;; Just the default for this project.
        ;; ;;  :auto-preamble t
        ;;  :auto-sitemap t               ;;  Generate sitemap.org automagically...
        ;;  :sitemap-filename "sitemap.inc"  ;; ... call it sitemap.org (it's the default)...
        ;;  :sitemap-title "sitemap"         ;; ... with title 'Sitemap'.
        ;;  :sitemap-function org-publish-org-sitemap,
        ;; ;;  :sitemap-sort-files anti-chronologically
        ;;  :sitemap-file-entry-format " %t" 
        ;; ;;  :sitemap-sort-folders last
        ;; ;;  :makeindex t
        ;;  )
        ("doc-static"
         :base-directory "~/Dropbox/test/"
         :base-extension "css\\|js\\|png\\|jpg\\|gif\\|pdf\\|mp3\\|ogg\\|swf"
         :publishing-directory "~/Dropbox/test/"
         :recursive t
         :publishing-function org-publish-attachment
         )
        ("doc" :components ("doc-notes"
;;                           "doc-sitemap"
                             "doc-static"))
        ))

;; publish-emacs
(add-to-list 'org-publish-project-alist
             '("emacs-notes"                            
               :base-directory "~/Dropbox/doc/Tools/emacs/"
               :base-extension "org"
               :publishing-directory "~/Dropbox/doc/Tools/emacs/"
               :recursive t
               :publishing-function org-html-publish-to-html
               :headline-levels 4             ; Just the default for this project.
               ;; :auto-preamble t
               :auto-sitemap t                ; Generate sitemap.org automagically...
               :sitemap-filename "thesitemap-emacs.org"  ; ... call it sitemap.org (it's the default)...
               :sitemap-title "Emacs Sitemap"         ;... with title 'Sitemap'.
	       :sitemap-function org-publish-org-sitemap-emacs
	       :sitemap-sort-files alphabetically
	       :sitemap-file-entry-format "%t" 
               ;; :sitemap-sort-folders last
	       :makeindex t
               ))

(add-to-list 'org-publish-project-alist
             '("emacs-static"
               :base-directory "~/Dropbox/doc/Tools/emacs/"
               :base-extension "css\\|js\\|png\\|jpg\\|gif\\|pdf\\|mp3\\|ogg\\|swf"
               :publishing-directory "~/Dropbox/doc/Tools/emacs/"
               :recursive t
               :publishing-function org-publish-attachment
               ))

(add-to-list 'org-publish-project-alist
             '("emacs" :components ("emacs-notes" "emacs-static")))

;; publish-TeX
(add-to-list 'org-publish-project-alist
             '("TeX-notes"                            
               :base-directory "~/Dropbox/doc/Tools/TeX/"
               :base-extension "org"
               :publishing-directory "~/Dropbox/doc/Tools/TeX/"
               :recursive t
               :publishing-function org-html-publish-to-html
               :headline-levels 4             ; Just the default for this project.
               ;; :auto-preamble t
               :auto-sitemap t                ; Generate sitemap.org automagically...
               :sitemap-filename "thesitemap-TeX.org"  ; ... call it sitemap.org (it's the default)...
               :sitemap-title "TeX Sitemap"         ;... with title 'Sitemap'.
	       :sitemap-function org-publish-org-sitemap-TeX
	       :sitemap-sort-files alphabetically
	       :sitemap-file-entry-format "%t" 
               ;; :sitemap-sort-folders last
	       :makeindex t
               ))

(add-to-list 'org-publish-project-alist
             '("TeX-static"
               :base-directory "~/Dropbox/doc/Tools/TeX/"
               :base-extension "css\\|js\\|png\\|jpg\\|gif\\|pdf\\|mp3\\|ogg\\|swf"
               :publishing-directory "~/Dropbox/doc/Tools/TeX/"
               :recursive t
               :publishing-function org-publish-attachment
               ))

(add-to-list 'org-publish-project-alist
             '("TeX" :components ("TeX-notes" "TeX-static")))

;; publish-daily
(add-to-list 'org-publish-project-alist
             '("daily-notes"                            
               :base-directory "~/Dropbox/daily_log/"
               :base-extension "org"
               :publishing-directory "~/Dropbox/daily_log/"
               :recursive t
               :publishing-function org-html-publish-to-html
               :headline-levels 4             ; Just the default for this project.
               ;; :auto-preamble t
               :auto-sitemap t                ; Generate sitemap.org automagically...
               :sitemap-filename "thesitemap-daily.org"  ; ... call it sitemap.org (it's the default)...
               :sitemap-title "Daily Log Sitemap"         ;... with title 'Sitemap'.
	       :sitemap-function org-publish-org-sitemap-daily
	       :sitemap-sort-files alphabetically
	       :sitemap-file-entry-format "%t" 
               ;; :sitemap-sort-folders last
	       :makeindex t
               ))

(add-to-list 'org-publish-project-alist
             '("daily-static"
               :base-directory "~/Dropbox/daily_log/"
               :base-extension "css\\|js\\|png\\|jpg\\|gif\\|pdf\\|mp3\\|ogg\\|swf"
               :publishing-directory "~/Dropbox/daily_log/"
               :recursive t
               :publishing-function org-publish-attachment
               ))

(add-to-list 'org-publish-project-alist
             '("daily" :components ("daily-notes" "daily-static")))

;; sitemap-emacs
(defun org-publish-org-sitemap-emacs (project &optional sitemap-filename)
  "Create a sitemap of pages in set defined by PROJECT.
Optionally set the filename of the sitemap with SITEMAP-FILENAME.
Default for SITEMAP-FILENAME is `sitemap.org'."
  (let* ((project-plist (cdr project))
         (dir (file-name-as-directory
               (plist-get project-plist :base-directory)))
         (localdir (file-name-directory dir))
         (indent-str (make-string 2 ?\ ))
         (exclude-regexp (plist-get project-plist :exclude))
         (files (nreverse
                 (org-publish-get-base-files project exclude-regexp)))
         (sitemap-filename (concat dir (or sitemap-filename "sitemap.org")))
         (sitemap-title (or (plist-get project-plist :sitemap-title)
                          (concat "Sitemap for project " (car project))))
         (sitemap-style (or (plist-get project-plist :sitemap-style)
                            'tree))
         (sitemap-sans-extension
          (plist-get project-plist :sitemap-sans-extension))
         (visiting (find-buffer-visiting sitemap-filename))
         (ifn (file-name-nondirectory sitemap-filename))
         file sitemap-buffer)
 (with-current-buffer
        (let ((org-inhibit-startup t))
          (setq sitemap-buffer
                (or visiting (find-file sitemap-filename))))
      (erase-buffer)
      (insert (concat "#+TITLE: " sitemap-title
                      "\n#+INDEX: SITEMAP\n"
		      "#+SETUPFILE: thesitemap-emacs-setup.inc\n"
		      "#+HTML: <div class=\"clear\"></div>\n"
		      "  + [[./thehome-emacs.org][HOME]]\n"
		      "  + [[./theindex.org][INDEX]]\n"
		      "  + [[./thesitemap-emacs.org][SITEMAP]]\n"
		      "#+HTML: <a href=\"file:thesitemap-emacs.org\">このページのorg</a>\n\n"
		      "* COMMENT MENU\n"
		      "[[file:thesitemap-emacs.html]]\n\n"
		      "* SITEMAP\n"
                      )) 
      (while (setq file (pop files))
        (let ((fn (file-name-nondirectory file))
              (link (file-relative-name file dir))
              (oldlocal localdir))
          (when sitemap-sans-extension
            (setq link (file-name-sans-extension link)))
          ;; sitemap shouldn't list itself
          (unless (equal (file-truename sitemap-filename)
                         (file-truename file))
            (if (eq sitemap-style 'list)
                (message "Generating list-style sitemap for %s" sitemap-title)
              (message "Generating tree-style sitemap for %s" sitemap-title)
(setq localdir (concat (file-name-as-directory dir)
                                     (file-name-directory link)))
              (unless (string= localdir oldlocal)
                (if (string= localdir dir)
                    (setq indent-str (make-string 2 ?\ ))
                  (let ((subdirs
                         (split-string
                          (directory-file-name
                           (file-name-directory
                            (file-relative-name localdir dir))) "/"))
                        (subdir "")
                        (old-subdirs (split-string
                                      (file-relative-name oldlocal dir) "/")))
                    (setq indent-str (make-string 2 ?\ ))
                    (while (string= (car old-subdirs) (car subdirs))
                      (setq indent-str (concat indent-str (make-string 2 ?\ )))
                      (pop old-subdirs)
                      (pop subdirs))
                    (dolist (d subdirs)
                      (setq subdir (concat subdir d "/"))
                      (insert (concat indent-str " + " d "\n"))
                      (setq indent-str (make-string
                                        (+ (length indent-str) 2) ?\ )))))))
            ;; This is common to 'flat and 'tree
            (let ((entry
                   (org-publish-format-file-entry
                    org-publish-sitemap-file-entry-format file project-plist))
                  (regexp "\\(.*\\)\\[\\([^][]+\\)\\]\\(.*\\)"))
              (cond ((string-match-p regexp entry)
                     (string-match regexp entry)
                     (insert (concat indent-str " + " (match-string 1 entry)
                                     "[[file:" link "]["
                                     (match-string 2 entry)
                                     "]]" (match-string 3 entry) "\n")))
                    (t
                     (insert (concat indent-str " + [[file:" link "]["
                                     entry
                                     "]]\n"))))))))
(save-buffer))
(or visiting (kill-buffer sitemap-buffer))))

;; sitemap-TeX
(defun org-publish-org-sitemap-TeX (project &optional sitemap-filename)
  "Create a sitemap of pages in set defined by PROJECT.
Optionally set the filename of the sitemap with SITEMAP-FILENAME.
Default for SITEMAP-FILENAME is `sitemap.org'."
  (let* ((project-plist (cdr project))
         (dir (file-name-as-directory
               (plist-get project-plist :base-directory)))
         (localdir (file-name-directory dir))
         (indent-str (make-string 2 ?\ ))
         (exclude-regexp (plist-get project-plist :exclude))
         (files (nreverse
                 (org-publish-get-base-files project exclude-regexp)))
         (sitemap-filename (concat dir (or sitemap-filename "sitemap.org")))
         (sitemap-title (or (plist-get project-plist :sitemap-title)
                          (concat "Sitemap for project " (car project))))
         (sitemap-style (or (plist-get project-plist :sitemap-style)
                            'tree))
         (sitemap-sans-extension
          (plist-get project-plist :sitemap-sans-extension))
         (visiting (find-buffer-visiting sitemap-filename))
         (ifn (file-name-nondirectory sitemap-filename))
         file sitemap-buffer)
 (with-current-buffer
        (let ((org-inhibit-startup t))
          (setq sitemap-buffer
                (or visiting (find-file sitemap-filename))))
      (erase-buffer)
      (insert (concat "#+TITLE: " sitemap-title
                      "\n#+INDEX: SITEMAP\n"
		      "#+SETUPFILE: thesitemap-TeX-setup.inc\n"
		      "#+HTML: <div class=\"clear\"></div>\n"
		      "  + [[./thehome-TeX.org][HOME]]\n"
		      "  + [[./theindex.org][INDEX]]\n"
		      "  + [[./thesitemap-TeX.org][SITEMAP]]\n"
		      "#+HTML: <a href=\"file:thesitemap-TeX.org\">このページのorg</a>\n\n"
		      "* COMMENT MENU\n"
		      "[[file:thesitemap-TeX.html]]\n\n"
		      "* SITEMAP\n"
                      )) 
      (while (setq file (pop files))
        (let ((fn (file-name-nondirectory file))
              (link (file-relative-name file dir))
              (oldlocal localdir))
          (when sitemap-sans-extension
            (setq link (file-name-sans-extension link)))
          ;; sitemap shouldn't list itself
          (unless (equal (file-truename sitemap-filename)
                         (file-truename file))
            (if (eq sitemap-style 'list)
                (message "Generating list-style sitemap for %s" sitemap-title)
              (message "Generating tree-style sitemap for %s" sitemap-title)
(setq localdir (concat (file-name-as-directory dir)
                                     (file-name-directory link)))
              (unless (string= localdir oldlocal)
                (if (string= localdir dir)
                    (setq indent-str (make-string 2 ?\ ))
                  (let ((subdirs
                         (split-string
                          (directory-file-name
                           (file-name-directory
                            (file-relative-name localdir dir))) "/"))
                        (subdir "")
                        (old-subdirs (split-string
                                      (file-relative-name oldlocal dir) "/")))
                    (setq indent-str (make-string 2 ?\ ))
                    (while (string= (car old-subdirs) (car subdirs))
                      (setq indent-str (concat indent-str (make-string 2 ?\ )))
                      (pop old-subdirs)
                      (pop subdirs))
                    (dolist (d subdirs)
                      (setq subdir (concat subdir d "/"))
                      (insert (concat indent-str " + " d "\n"))
                      (setq indent-str (make-string
                                        (+ (length indent-str) 2) ?\ )))))))
            ;; This is common to 'flat and 'tree
            (let ((entry
                   (org-publish-format-file-entry
                    org-publish-sitemap-file-entry-format file project-plist))
                  (regexp "\\(.*\\)\\[\\([^][]+\\)\\]\\(.*\\)"))
              (cond ((string-match-p regexp entry)
                     (string-match regexp entry)
                     (insert (concat indent-str " + " (match-string 1 entry)
                                     "[[file:" link "]["
                                     (match-string 2 entry)
                                     "]]" (match-string 3 entry) "\n")))
                    (t
                     (insert (concat indent-str " + [[file:" link "]["
                                     entry
                                     "]]\n"))))))))
(save-buffer))
(or visiting (kill-buffer sitemap-buffer))))

;; sitemap-daily
(defun org-publish-org-sitemap-daily (project &optional sitemap-filename)
  "Create a sitemap of pages in set defined by PROJECT.
Optionally set the filename of the sitemap with SITEMAP-FILENAME.
Default for SITEMAP-FILENAME is `sitemap.org'."
  (let* ((project-plist (cdr project))
         (dir (file-name-as-directory
               (plist-get project-plist :base-directory)))
         (localdir (file-name-directory dir))
         (indent-str (make-string 2 ?\ ))
         (exclude-regexp (plist-get project-plist :exclude))
         (files (nreverse
                 (org-publish-get-base-files project exclude-regexp)))
         (sitemap-filename (concat dir (or sitemap-filename "sitemap.org")))
         (sitemap-title (or (plist-get project-plist :sitemap-title)
                          (concat "Sitemap for project " (car project))))
         (sitemap-style (or (plist-get project-plist :sitemap-style)
                            'tree))
         (sitemap-sans-extension
          (plist-get project-plist :sitemap-sans-extension))
         (visiting (find-buffer-visiting sitemap-filename))
         (ifn (file-name-nondirectory sitemap-filename))
         file sitemap-buffer)
 (with-current-buffer
        (let ((org-inhibit-startup t))
          (setq sitemap-buffer
                (or visiting (find-file sitemap-filename))))
      (erase-buffer)
      (insert (concat "#+TITLE: " sitemap-title
                      "\n#+INDEX: SITEMAP\n"
		      "#+SETUPFILE: thesitemap-daily-setup.inc\n"
		      "#+HTML: <div class=\"clear\"></div>\n"
		      "  + [[./thehome-daily.org][HOME]]\n"
		      "  + [[./theindex.org][INDEX]]\n"
		      "  + [[./thesitemap-daily.org][SITEMAP]]\n"
		      "#+HTML: <a href=\"file:thesitemap-daily.org\">このページのorg</a>\n\n"
		      "* COMMENT MENU\n"
		      "[[file:thesitemap-daily.html]]\n\n"
		      "* SITEMAP\n"
                      )) 
      (while (setq file (pop files))
        (let ((fn (file-name-nondirectory file))
              (link (file-relative-name file dir))
              (oldlocal localdir))
          (when sitemap-sans-extension
            (setq link (file-name-sans-extension link)))
          ;; sitemap shouldn't list itself
          (unless (equal (file-truename sitemap-filename)
                         (file-truename file))
            (if (eq sitemap-style 'list)
                (message "Generating list-style sitemap for %s" sitemap-title)
              (message "Generating tree-style sitemap for %s" sitemap-title)
(setq localdir (concat (file-name-as-directory dir)
                                     (file-name-directory link)))
              (unless (string= localdir oldlocal)
                (if (string= localdir dir)
                    (setq indent-str (make-string 2 ?\ ))
                  (let ((subdirs
                         (split-string
                          (directory-file-name
                           (file-name-directory
                            (file-relative-name localdir dir))) "/"))
                        (subdir "")
                        (old-subdirs (split-string
                                      (file-relative-name oldlocal dir) "/")))
                    (setq indent-str (make-string 2 ?\ ))
                    (while (string= (car old-subdirs) (car subdirs))
                      (setq indent-str (concat indent-str (make-string 2 ?\ )))
                      (pop old-subdirs)
                      (pop subdirs))
                    (dolist (d subdirs)
                      (setq subdir (concat subdir d "/"))
                      (insert (concat indent-str " + " d "\n"))
                      (setq indent-str (make-string
                                        (+ (length indent-str) 2) ?\ )))))))
            ;; This is common to 'flat and 'tree
            (let ((entry
                   (org-publish-format-file-entry
                    org-publish-sitemap-file-entry-format file project-plist))
                  (regexp "\\(.*\\)\\[\\([^][]+\\)\\]\\(.*\\)"))
              (cond ((string-match-p regexp entry)
                     (string-match regexp entry)
                     (insert (concat indent-str " + " (match-string 1 entry)
                                     "[[file:" link "]["
                                     (match-string 2 entry)
                                     "]]" (match-string 3 entry) "\n")))
                    (t
                     (insert (concat indent-str " + [[file:" link "]["
                                     entry
                                     "]]\n"))))))))
(save-buffer))
(or visiting (kill-buffer sitemap-buffer))))


;; doc-project のhistory用のfunction
(defun org-publish-org-history-doc (project &optional sitemap-filename)
  "Create a sitemap of pages in set defined by PROJECT.
Optionally set the filename of the sitemap with SITEMAP-FILENAME.
Default for SITEMAP-FILENAME is `sitemap.org'."
  (let* ((project-plist (cdr project))
         (dir (file-name-as-directory
               (plist-get project-plist :base-directory)))
         (localdir (file-name-directory dir))
         (indent-str (make-string 2 ?\ ))
         (exclude-regexp (plist-get project-plist :exclude))
         (files (nreverse
                 (org-publish-get-base-files project exclude-regexp)))
         (sitemap-filename (concat dir (or sitemap-filename "sitemap.org")))
         (sitemap-title (or (plist-get project-plist :sitemap-title)
                          (concat "Sitemap for project " (car project))))
         (sitemap-style (or (plist-get project-plist :sitemap-style)
                            'tree))
         (sitemap-sans-extension
          (plist-get project-plist :sitemap-sans-extension))
         (visiting (find-buffer-visiting sitemap-filename))
         (ifn (file-name-nondirectory sitemap-filename))
         file sitemap-buffer)
 (with-current-buffer
        (let ((org-inhibit-startup t))
          (setq sitemap-buffer
                (or visiting (find-file sitemap-filename))))
      (erase-buffer)
      (insert (concat "#+TITLE: " sitemap-title
                      "\n#+INDEX: HISTORY" 
                      "\n#+DESCRIPTION: History\n"
                      "\n#+INCLUDE: ./include/settings_00.inc\n"
                      "#+BEGIN_HTML\n"
                      "<a href=\"file:thehistory.org\">このページのorg</a>\n"
                      "#+END_HTML\n"
                      "* COMMENT MENU\n" 
                      "[[file:~/Dropbox/doc/thehome.org][HOME]]  [[file:~/Dropbox/doc/theindex.inc][INDEX]]  [[file:~/Dropbox/doc/thesitemap.org][SITEMAP]]  [[file:~/Dropbox/doc/thehistory.org][HISTORY]]  [[file:~/Dropbox/doc/thelinks.org][LINKS]]  [[file:~/Dropbox/doc/thesettings.org][SETTINGS]]  [[file:thesitemap.html][thesitemap.html]]\n"
                      "\n* History\n")) 
      (while (setq file (pop files))
        (let ((fn (file-name-nondirectory file))
              (link (file-relative-name file dir))
              (oldlocal localdir))
          (when sitemap-sans-extension
            (setq link (file-name-sans-extension link)))
          ;; sitemap shouldn't list itself
          (unless (equal (file-truename sitemap-filename)
                         (file-truename file))
            (if (eq sitemap-style 'list)
                (message "Generating list-style sitemap for %s" sitemap-title)
              (message "Generating tree-style sitemap for %s" sitemap-title)
(setq localdir (concat (file-name-as-directory dir)
                                     (file-name-directory link)))
              (unless (string= localdir oldlocal)
                (if (string= localdir dir)
                    (setq indent-str (make-string 2 ?\ ))
                  (let ((subdirs
                         (split-string
                          (directory-file-name
                           (file-name-directory
                            (file-relative-name localdir dir))) "/"))
                        (subdir "")
                        (old-subdirs (split-string
                                      (file-relative-name oldlocal dir) "/")))
                    (setq indent-str (make-string 2 ?\ ))
                    (while (string= (car old-subdirs) (car subdirs))
                      (setq indent-str (concat indent-str (make-string 2 ?\ )))
                      (pop old-subdirs)
                      (pop subdirs))
                    (dolist (d subdirs)
                      (setq subdir (concat subdir d "/"))
                      (insert (concat indent-str " + " d "\n"))
                      (setq indent-str (make-string
                                        (+ (length indent-str) 2) ?\ )))))))
            ;; This is common to 'flat and 'tree
            (let ((entry
                   (org-publish-format-file-entry
                    org-publish-sitemap-file-entry-format file project-plist))
                  (regexp "\\(.*\\)\\[\\([^][]+\\)\\]\\(.*\\)"))
              (cond ((string-match-p regexp entry)
                     (string-match regexp entry)
                     (insert (concat indent-str " + " (match-string 1 entry)
                                     "[[file:" link "]["
                                     (match-string 2 entry)
                                     "]]" (match-string 3 entry) "\n")))
                    (t
                     (insert (concat indent-str " + [[file:" link "]["
                                     entry
                                     "]]\n"))))))))
(save-buffer))
(or visiting (kill-buffer sitemap-buffer))))

;; 
(setq auto-mode-alist
       (append '(("\\theindex.inc$" . org-mode))
               auto-mode-alist))

;; (setq org-html-link-home "~/Dropbox/")

(setq org-directory "~/Dropbox/gtd/")
(setq org-default-notes-file (concat org-directory "notes.org"))
(setq org-capture-templates
      '(("t" "Todo" entry
         (file+headline nil "Inbox")
         "** TODO %?\n   %i\n   %a\n   %t")
        ("b" "Bug" entry
         (file+headline nil "Inbox")
         "** TODO %?   :bug:\n   %i\n   %a\n   %t")
        ("i" "Idea" entry
         (file+headline nil "New Ideas")
         "** %?\n   %i\n   %a\n   %t")))
;; (global-set-key (kbd "C-c c") 'org-capture)

;; 
;; [[https://taipapamotohus.com/post/org-mode_paper_3/][Emacsのorg-modeで論文を書く（その3：org-modeとbibtexとreftexの連携による文献引用の自動化） | A perfect autumn day]]
;; 
;; (require 'ox-bibtex)


;; bib in org mode
;; [[https://org-technology.com/posts/org-ref.html][Emacs の org-ref で文献参照・相互参照のリンクを挿入する | org-技術]]
;; 
;; (require 'org-ref)
;; (setq reftex-default-bibliography '("~/Dropbox/bib/mybib.bib"))

;; ;; ノート、bib ファイル、PDF のディレクトリなどを設定
;; (setq org-ref-bibliography-notes "~/Dropbox/bib/notes.org"
;;       org-ref-default-bibliography '("~/Dropbox/bib/mybib.bib")
;;       org-ref-pdf-directory "~/Dropbox/bib/bibtex-pdfs/")


(provide 'my-org-config)
;;; my-org-config.el ends here
