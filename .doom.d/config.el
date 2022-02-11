;; -*- lexical-binding: t -*-

(setq visible-bell t)

(setq doom-theme 'doom-monokai-pro
      all-the-icons-scale-factor 1)
(setq neo-theme (if (display-graphic-p) 'icons 'arrow))
(setq doom-modeline-height 0) ;; set the height of modeline to min

(setq doom-font (font-spec :family "JetBrains Mono" :size 16 :weight 'regular)
      doom-big-font (font-spec :family "JetBrains Mono" :size 22 :weight 'regular)
      doom-variable-pitch-font (font-spec :family "DeJa Vu Sans" :size 14))

(setq-default line-spacing 0.1)

(setq user-full-name "Nils Riedemann"
      user-mail-address "nils@bleepbloop.studio")

(setq shell-file-name (executable-find "zsh"))
(setq +format-on-save-enabled-modes '(not emacs-lisp-mode sql-mode tex-mode latex-mode rustic-mode web-mode))

(global-set-key (kbd "s-j") '+vterm/toggle)
(setq vterm-shell '/usr/local/bin/fish)

(after! python-mode
  (setq py-python-command "/usr/bin/python3")
  )

(after! deft
  (setq deft-directory "~/notes"))

(setq org-agenda-files
      '("~/notes"))

(setq org-babel-python-command "/usr/bin/python3")
(setq org-refile-targets '((org-agenda-files :maxlevel . 3)))
(setq org-log-into-drawer t)
(setq org-startup-indented t)
;; (setq org-tag-alist
;;       '(("tobuy" . ?b)
;;         ("tosell" . ?s)
;;         ("huchting")))


(setq org-todo-keywords
      '(
        (sequence "TODO(t)" "PROJ(p)" "NEXT(x)" "LOOP(r)" "STRT(s)" "WAIT(w)" "HOLD(h)" "IDEA(i)" "|" "DONE(d!)" "KILL(k)")
        (sequence "[ ](T)" "[-](S)" "[?](W)" "|" "[X](D!)")
        (sequence "|" "OKAY(o)" "YES(y)" "NO(n)")
        ))

(add-hook 'org-mode-hook 'turn-on-auto-fill)

(setq org-stuck-projects
      '("/+PROJ-MAYBE-DONE-IDEA" ("NEXT" "STRT") ("tobuy")
        "\\<IGNORE\\>"))

(after! org
    (map! :leader
        :desc "Org Agenda Day View"
        "o a d" #'org-agenda-day-view)
  )

(setq org-agenda-format-date
      (lambda (date) (concat "\n\n" (org-agenda-format-date-aligned date))))

(setq org-agenda-custom-commands
      '(("b" "Basics for today"
         ((tags-todo "chore")
          (tags-todo "writing")
          (tags "WAIT")
          (todo "NEXT")
          (agenda ""))
         )))

(setq org-roam-capture-templates
      '(("d" "default" plain #'org-roam--capture-get-point "%?"
         :file-name "%<%Y%m%d%H%M%S>"
         :head "#+TITLE: ${title}\n#+Created: %t\n#+Time-stamp: <>\n"
         :unnarrowed t)))
(require 'time-stamp)
(add-hook 'write-file-functions 'time-stamp)
(setq time-stamp-format "%:y-%02m-%02d %02H:%02M:%02S")
;; (after! org-roam
;;   (setq org-roam-dailies-directory "daily/")
;;   (setq org-roam-dailies-capture-templates
;;         '(("d" "default" entry
;;            #'org-roam-capture--get-point
;;            "* %?"
;;            :file-name "daily/%<%Y-%m-%d>"
;;            :head "#+title: %<%Y-%m-%d>\n\n")))
;;   (map! :leader
;;         :desc "Roam Daily"
;;         "m D" #'org-roam-dailies-find-today)
;;   )

(setq projectile-project-search-path '("~/projects/"))
(global-set-key "\C-s" 'swiper)

(setq display-line-numbers-type 'relative)

(setq doom-themes-neotree-enable-variable-pitch nil)
(global-set-key (kbd "s-b") '+neotree/toggle) ; treemacs toggle keybind

(setq ivy-use-selectable-prompt t)

(setq tide-tsserver-process-environment '("TSS_LOG=-level verbose"))

(setq company-idle-delay 0.2)
(setq company-tooltip-idle-delay 0.1)
(setq lsp-idle-delay 0.2)

(after! mu4e
  (add-to-list 'mu4e-bookmarks
               '(:name "Pull Requests" :key ?p :query "from:pullrequests-reply and maildir:/+SaneDevelopment"))
  (add-to-list 'mu4e-bookmarks
               '(:name "Stargazer Updates" :key ?g :query "from:stargazer@myiridium.net"))
  (add-to-list 'mu4e-bookmarks
               '(:name "Personal 7d" :key ?m :query "date:7d..now AND to:moin@nilsriedemann.de"))
  (add-to-list 'mu4e-bookmarks
               '(:name "BBS 7d" :key ?b :query "date:7d..now AND to:nils@bleepbloop.studio AND NOT maildir:/Spam AND NOT maildir:/Trash AND NOT maildir:/Archive"))
  )

(use-package! mu4e-views
  :after mu4e
  :config
  (setq mu4e-views-completion-method 'ivy)
  (setq mu4e-views-default-view-method "html")
  (setq mu4e-views-next-previous-message-behaviour 'stick-to-current-window) ;; when pressing n and p stay in the current window
  (setq mu4e-views-mu4e-html-email-header-style
        "<style type=\"text/css\">
            .mu4e-mu4e-views-mail-headers { font-family: Operator Mono; line-height: 2; padding: 2px; margin-bottom: 20px; padding-bottom: 20px; border-bottom: 2px solid #eee; }
            .mu4e-mu4e-views-header-row { display: flex; }
            .mu4e-mu4e-views-mail-header {  opacity: .5; width: 100px; text-align: right; flex-grow: 0;}
            .mu4e-mu4e-views-header-content { margin-left: 2ch;}
            .mu4e-mu4e-views-email { margin-right: 8px; }
            .mu4e-mu4e-views-attachment { }
            .mu4e-mu4e-views-mail-headers + div { font-family: Operator Mono; line-height: 1.5; max-width: 80ch; padding: 2ch;}
        </style>")

  (map! :map mu4e-headers-mode-map
        :n "M-b" #'mu4e-views-cursor-msg-view-window-up
        :n "M-f" #'mu4e-views-cursor-msg-view-window-down
        :localleader
        :desc "Message action"        "a"   #'mu4e-views-mu4e-view-action
        :desc "Scoll message down"    "b"   #'mu4e-views-cursor-msg-view-window-up
        :desc "Scoll message up"      "f"   #'mu4e-views-cursor-msg-view-window-down
        :desc "Open attachment"       "o"   #'mu4e-views-mu4e-view-open-attachment
        :desc "Save attachment"       "s"   #'mu4e-views-mu4e-view-save-attachment
        :desc "Save all attachments"  "S"   #'mu4e-views-mu4e-view-save-all-attachments
        :desc "Set view method"       "v"   #'mu4e-views-mu4e-select-view-msg-method)) ;; select viewing method)


;; Evil bindings for xwidget webkit browsers
(map! :map xwidget-webkit-mode-map
      :n "Z Z" #'quit-window
      :n "gr"  #'xwidget-webkit-reload
      :n "y"   #'xwidget-webkit-copy-selection-as-kill
      :n "s-c" #'xwidget-webkit-copy-selection-as-kill
      :n "t"   #'xwidget-webkit-browse-url
      :n "TAB" #'xwidget-webkit-forward
      :n "C-o" #'xwidget-webkit-back
      :n "G"   #'xwidget-webkit-scroll-bottom
      :n "gg"  #'xwidget-webkit-scroll-top
      :n "C-b" #'xwidget-webkit-scroll-down
      :n "C-f" #'xwidget-webkit-scroll-up
      :n "M-=" #'xwidget-webkit-zoom-in
      :n "M--" #'xwidget-webkit-zoom-out
      :n "k"   #'xwidget-webkit-scroll-down-line
      :n "j"   #'xwidget-webkit-scroll-up-line)

(after! mu4e
  (setq message-send-mail-function 'smtpmail-send-it)
  (setq smtpmail-smtp-server "smtp.example.org")
  )

(after! mu4e
  (add-to-list 'load-path "/usr/local/Cellar/mu/1.4.15/share/emacs/site-lisp/mu/mu4e")
  (setq mu4e-view-show-addresses t)
  (setq mu4e-change-filenames-when-moving t)
  (setq mu4e-views-default-view-method "html") ;; make xwidgets default
  (mu4e-views-mu4e-use-view-msg-method "html") ;; select the default
  (define-key mu4e-headers-mode-map (kbd "v") #'mu4e-views-mu4e-select-view-msg-method)
  (setq mu4e-views-next-previous-message-behaviour 'stick-to-current-window) ;; when pressing n and p stay in the current window
  (setq mu4e-views-auto-view-selected-message t) ;; automatically open messages when moving in the headers view
  (setq mu4e-update-interval 180)
  (setq mu4e-get-mail-command  "mbsync -a")
  (setq mu4e-headers-time-format "%H:%M")
  (setq mu4e-headers-date-format "%y-%m-%d")
  )
