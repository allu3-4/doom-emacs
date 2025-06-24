;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets. It is optional.
;; (setq user-full-name "John Doe"
;;   	user-mail-address "john@doe.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom:
;;
;; - `doom-font' -- the primary font to use
;; - `doom-variable-pitch-font' -- a non-monospace font (where applicable)
;; - `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;; - `doom-symbol-font' -- for symbols
;; - `doom-serif-font' -- for the `fixed-pitch-serif' face
;
;;
;; See 'C-h v doom-font' for documentation and more examples of what they
;; accept. For example:
;;
;;
;;
;; If you or Emacs can't find your font, use 'M-x describe-font' to look them
;; up, `M-x eval-region' to execute elisp code, and 'M-x doom/reload-font' to
;; refresh your font settings. If Emacs still can't find your font, it likely
;; wasn't installed correctly. Font issues are rarely Doom issues!

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(mapc #'disable-theme custom-enabled-themes)
(setq doom-theme 'doom-zenburn)



;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")


;; Whenever you reconfigure a package, make sure to wrap your config in an
;; `after!' block, otherwise Doom's defaults may override your settings. E.g.
;;
;;   (after! PACKAGE
;; 	(setq x y))
;;
;; The exceptions to this rule:
;;
;;   - Setting file/directory variables (like `org-directory')
;;   - Setting variables which explicitly tell you to set them before their
;; 	package is loaded (see 'C-h v VARIABLE' to look up their documentation).
;;   - Setting doom variables (which start with 'doom-' or '+').
;;
;; Here are some additional functions/macros that will help you configure Doom.
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;; Alternatively, use `C-h o' to look up a symbol (functions, variables, faces,
;; etc).
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented
;;
;; Org mode setup for writing, notes, and tasks
;; -----------------------------
;;
(after! org
  (setq org-directory "~/org/")
  ;; Include both org and org-roam directories in agenda
  (setq org-agenda-files
    	(seq-filter (lambda (file)
                 	(not (string-match-p "sync-conflict" file)))
               	(append
                	(directory-files-recursively org-directory "\\.org$")
                	(directory-files-recursively "~/org-roam/" "\\.org$")))))

(use-package org-roam
  :ensure t
  :init
  (setq org-roam-v2-ack t)
  :custom
  (org-roam-directory "~/org-roam")
  (org-roam-completion-everywhere t)
  (org-roam-capture-templates
  	'(;; Top level templates
    	("d" "default" plain
     	"%?"
     	:if-new (file+head "Notes/${slug}.org" "#+title: ${title}\n#+date: %U\n")
     	:unnarrowed t)

    	("p" "Project")
    	("pf" "Ferda" plain
     	"%?"
     	:if-new (file+head "Projects/Ferda/${slug}.org"
                        	"#+title: ${title}\n#+date: %U\n#+filetags: :projects:\n")
     	:unnarrowed t)

    	;; Self-study hierarchy
    	("s" "Self-study")
    	("sg" "General self-study" plain
     	"%?"
     	:if-new (file+head "self-study/${slug}.org"
                        	"#+title: ${title}\n#+date: %U\n#+filetags: :study:\n")
     	:unnarrowed t)
    	("sm" "MOOC" plain
     	(file "~/org-roam/Templates/MoocTemplate.org")
     	:if-new (file+head "self-study/MOOC/${slug}.org"
                        	"#+title: ${title}\n#+date: %U\n#+filetags: :study:mooc:python:\n")
     	:unnarrowed t)
    	("sl" "Linear Algebra" plain
     	"%?"
     	:if-new (file+head "self-study/LINALG/${slug}.org"
                        	"#+title: ${title}\n#+date: %U\n#+filetags: :study:linalg:linearalgebra:\n")
     	:unnarrowed t)
    	("sq" "SQL" plain
     	"%?"
     	:if-new (file+head "self-study/SQL/${slug}.org"
                        	"#+title: ${title}\n#+date: %U\n#+filetags: :study:sql:\n")
     	:unnarrowed t)
     	("sp" "PYTHON" plain
     	"%?"
     	:if-new (file+head "self-study/PYTHON/${slug}.org"
                        	"#+title: ${title}\n#+date: %U\n#+filetags: :study:python:\n")
     	:unnarrowed t)
      	("sa" "ML" plain
     	"%?"
     	:if-new (file+head "self-study/ML/${slug}.org"
                        	"#+title: ${title}\n#+date: %U\n#+filetags: :study:machinelearning:\n")
     	:unnarrowed t)
         	("sc" "CHEM" plain
     	"%?"
     	:if-new (file+head "self-study/CHEM/${slug}.org"
                        	"#+title: ${title}\n#+date: %U\n#+filetags: :study:chemistry:\n")
     	:unnarrowed t)




    	;; Classes hierarchy
    	("c" "Classes")
    	("cg" "General class notes" plain
     	"%?"
     	:if-new (file+head "Classes/${slug}.org"
                        	"#+title: ${title}\n#+date: %U\n#+filetags: :class:university:\n")
     	:unnarrowed t)
    	("cu" "U51" plain
     	"%?"
     	:if-new (file+head "Classes/U28/-${slug}.org"
                        	"#+title: ${title}\n#+date: %U\n#+filetags: :class:U28:university:\n")
     	:unnarrowed t)

    	;; Bibliography
    	("b" "bibliography" plain
     	(file "~/org-roam/Templates/ProjectTemplate.org")
     	:if-new (file+head "Classes/Bibliography/%<%Y%m%d>-${slug}.org"
                        	"#+title: ${title}\n#+date: %U\n#+filetags: :bibliography:university:\n")
     	:unnarrowed t)

    	;; Journal entry (integrated with org-roam)
    	("j" "journal" plain
     	"* Morning Notes
  :PROPERTIES:
  :CREATED:  %U
  :END:

%?

* Today's Tasks

* Class Notes

* Things I Learned Today

* Evening Reflection
"
     	:if-new (file+head "journal/%<%Y-%m-%d>.org"
                        	"#+title: Journal Entry - %<%A, %d %B %Y>\n#+date: %U\n#+filetags: :journal:\n#+STARTUP: showeverything\n")
     	:unnarrowed t)))


  :bind (("C-c n l" . org-roam-buffer-toggle)
     	("C-c n f" . org-roam-node-find)
     	("C-c n i" . org-roam-node-insert)
     	:map org-mode-map
     	("C-M-i" . completion-at-point))
  :config
 (org-roam-setup))


;; Set TODO keywords and workflow
(setq org-todo-keywords
  	'((sequence "TODO(t)" "NEXT(n)" "PROJ(p)" "SCHEDULED(s)" "|" "DONE(d)" "CANCELLED(c)")
    	(sequence "WAIT(w)" "HOLD(h)" "|" "CANCELLED(c)")))

;; Improve default agenda view to show all tasks
;; ──────────────────────────────────────────────────────────────
;; Enhanced Org Agenda Configuration
;; ──────────────────────────────────────────────────────────────

;; ──────────────────────────────────────────────────────────────
;; Simple Super Org Agenda Configuration
;; ──────────────────────────────────────────────────────────────
;;

(use-package! org-super-agenda
  :after org-agenda
  :init
  (setq org-extend-today-until 0)
  (setq org-super-agenda-groups
        '((:name "Important"
           :priority "A")
          (:name "University"
           :tag "university")
          (:name "Study - Linear Algebra"
           :and (:tag "study" :tag "linalg"))
          (:name "Study - SQL/Databases"
           :and (:tag "study" :tag "sql"))
          (:name "Study - Python"
           :and (:tag "study" :tag "python"))
          (:name "Study - MOOC"
           :and (:tag "study" :tag "mooc"))
          (:name "Study - General"
           :tag "study")  ; This should catch your SQL task if the above doesn't
          (:name "Projects"
           :file-path "Project")
          (:name "Index/Reference"
           :tag "index")
          (:name "WAITING"
           :todo "WAITING")
          (:name ""  ; Today section - MOVED TO END
           :time-grid t
           :date today)
          (:name ""  ; Catch-all for anything else
           :anything t)))
  :config
  (org-super-agenda-mode 1))


(after! org
  (setq
   ;; Clean deadline display
   org-agenda-deadline-leaders '("" "" "%2d d. ago: ")
   org-deadline-warning-days 0

   ;; Week view starting today
   org-agenda-span 7
   org-agenda-start-day "-0d"

   ;; Hide completed tasks globally
   org-agenda-skip-function-global '(org-agenda-skip-entry-if 'todo 'done)

   ;; Log completion time
   org-log-done 'time))

  :config
  (org-super-agenda-mode 1)



  :config
  (org-super-agenda-mode 1)
(after! org-agenda
  ;; ── Visual Enhancements ──

  ;; Current time indicator
  (setq org-agenda-current-time-string "◀ now ──────────")

  ;; ── Habit Tracking ──

  ;; Show habits only for today's view
  (setq org-habit-show-habits-only-for-today t
    	org-habit-graph-column 50)

  ;; ── Clean Agenda Display ──

  ;; Remove clutter from agenda view
  (setq org-agenda-remove-tags t
    	org-agenda-show-inherited-tags nil)

  ;; Better time grid
  (setq org-agenda-time-grid
    	'((daily today require-timed)
      	(0800 1000 1200 1400 1600 1800 2000 2200)
      	"......" "────────────────")))

  ;; Make org-agenda headings bigger and prettier
  (custom-set-faces!
	'(org-agenda-structure
  	:weight bold
  	:height 1.1
  	:foreground "#81a1c1"))



;; Optional: Custom agenda commands with different groupings
(setq org-agenda-custom-commands
  	'(("d" "Daily Dashboard"
     	((agenda ""
              	((org-agenda-span 1)
               	(org-super-agenda-groups
                	'((:name "Today's Schedule"
                         	:time-grid t
                         	:date today)
                  	(:name "Due Today"
                         	:deadline today)
                  	(:name "High Priority"
                         	:priority "A")
                  	(:name "Habits"
                         	:habit t)))))
      	(todo "TODO"
            	((org-super-agenda-groups
              	'((:name "Important"
                       	:priority "A")
                	(:name "Work"
                       	:tag "work")
                	(:name "Personal"
                       	:tag "personal")
                	(:name "Quick Wins"
                       	:effort< "0:30")
                	(:discard (:anything t))))))))

    	("w" "Work Focus"
     	((todo "TODO"
            	((org-super-agenda-groups
              	'((:name "Urgent Work"
                       	:and (:tag "work" :priority "A"))
                	(:name "Work Projects"
                       	:and (:tag "work" :todo "PROJ"))
                	(:name "Work Tasks"
                       	:tag "work")
                	(:discard (:anything t))))))))))

(defun my/refresh-org-agenda-files ()
  "Refresh the list of org files in org-agenda-files, including org-roam files."
  (interactive)
  (setq org-agenda-files
    	(seq-filter (lambda (file)
                 	(not (string-match-p "sync-conflict" file)))
               	(append
                	(directory-files-recursively org-directory "\\.org$")
                	(directory-files-recursively org-roam-directory "\\.org$"))))
  (message "Refreshed org-agenda-files. Found %d files." (length org-agenda-files)))
;; Include all org files and org-roam files (excluding sync conflicts)
  ;; Set directory for task notes
  (setq my/task-notes-directory "~/org/task-notes/")

  ;; Create directory if it doesn't exist
  (unless (file-directory-p my/task-notes-directory)
	(make-directory my/task-notes-directory t))

  ;; Function to create a note for the current task
  (defun my/create-task-note ()
	"Create a note file for the current task and link to it."
	(interactive)
	(let* ((task-heading (org-get-heading t t t t))
       	(task-id (org-id-get-create))
       	(current-file (buffer-file-name))
       	(clean-title (replace-regexp-in-string "[^a-zA-Z0-9]+" "-" task-heading))
       	(note-file (concat my/task-notes-directory clean-title ".org")))

  	;; Create the note file with link back to task
  	(with-temp-file note-file
    	(insert (format "#+TITLE: Notes for: %s\n\n" task-heading))
    	(insert (format "[[id:%s][🔗 Back to Task: %s]]\n\n" task-id task-heading))
    	(insert "* Notes\n\n"))

  	;; Add the note file link to the task
  	(org-entry-put nil "NOTE_FILE" note-file)
  	(save-excursion
    	(org-end-of-meta-data t)
    	(insert (format "[[file:%s][📝 Open Task Notes]]\n\n" note-file)))

  	;; Open the note file
  	(find-file note-file)
  	(message "Note file created and linked to current task")))

  ;; Function to open the note file linked to the current task
  (defun my/open-task-note ()
	"Open the note file associated with the current task."
	(interactive)
	(let ((note-file (org-entry-get nil "NOTE_FILE")))
  	(if (and note-file (file-exists-p note-file))
      	(find-file note-file)
    	(message "No note file found for this task"))))

  ;; Function to insert a link to a task from any agenda file
  (defun my/insert-task-link ()
	"Insert a link to a task from any agenda file."
	(interactive)
	(let* ((tasks (org-map-entries
               	(lambda ()
                  	(cons (format "%s (%s)"
                              	(org-get-heading t t t t)
                              	(file-name-nondirectory (buffer-file-name)))
                       	(org-id-get-create)))
               	"TODO=\"TODO\"|TODO=\"NEXT\"|TODO=\"WAITING\"|TODO=\"HOLD\""
               	'agenda))
       	(selected (completing-read "Select task: " (mapcar #'car tasks)))
       	(task-id (cdr (assoc selected tasks))))
  	(insert (format "[[id:%s][🔗 %s]]" task-id selected))))

  ;; Define my/insert-task-reference as an alias for my/insert-task-link for backward compatibility
  (defalias 'my/insert-task-reference 'my/insert-task-link)

  ;; Add keybindings
  (map! :map org-mode-map
    	:localleader
    	:desc "Create note for task" "c n" #'my/create-task-note
    	:desc "Open task note" "o n" #'my/open-task-note
    	:desc "Insert task link" "i t" #'my/insert-task-link)


;; Shortcut: Capture
(map! :leader
  	:desc "Org Capture"
  	"x" #'org-capture)


;; -----------------------------
;; Org Journal (daily notes) - INTEGRATED INTO ORG-ROAM
;; -----------------------------
;; Set up org-roam-dailies (replaces org-journal)
(after! org-roam
  (setq org-roam-dailies-directory "journal/")
  (setq org-roam-dailies-capture-templates
  	'(("d" "default" entry
     	"* Morning Notes
  :PROPERTIES:
  :CREATED:  %U
  :END:

%?

* Morning Reflection

* Today's Tasks

* Class Notes

* Things I Learned Today

* Evening Reflection
"
     	:target (file+head "%<%Y-%m-%d>.org"
                        	"#+title: Journal Entry - %<%A, %d %B %Y>\n#+date: %U\n#+filetags: :journal:\n#+STARTUP: showeverything\n"))))

  ;; Journal keybindings adapted for org-roam-dailies
  (map! :leader
    	(:prefix ("j" . "journal")
     	:desc "New journal entry"  	"j" #'org-roam-dailies-capture-today
     	:desc "Previous journal entry" "p" #'org-roam-dailies-goto-previous-note
     	:desc "Next journal entry" 	"n" #'org-roam-dailies-goto-next-note
     	:desc "Search journal"     	"s" #'org-roam-node-find
     	:desc "New journal at date"	"d" #'org-roam-dailies-capture-date)))

;; Enable auto-save for Org files (saves every 5 minutes)
(setq auto-save-timeout 300)  ;; Time in seconds (e.g., 300 seconds = 5 minutes)
(setq auto-save-interval 100)  ;; Save every 100 keystrokes
;;
(setq org-roam-directory (file-truename "~/org-roam/"))
(after! org-roam
  (org-roam-db-autosync-mode))

(after! org
  (require 'org-id)
  (setq org-id-link-to-org-use-id t))

;;
;;
(remove-hook 'doom-first-file-hook #'global-diff-hl-mode)

;; Show task titles in agenda view
(after! org-agenda
  (setq org-agenda-prefix-format
    	'((agenda . " %i %-12:c%?-12t% s")
      	(todo . " %i %-12:c")
      	(tags . " %i %-12:c")
      	(search . " %i %-12:c")))

  ;; Make sure tasks are shown with full details
  (setq org-agenda-hide-tags-regexp nil)
  (setq org-agenda-todo-keyword-format "%-8s")
  (setq org-agenda-show-inherited-tags t)
  (setq org-agenda-show-all-dates t))

;; Add a function to easily refresh org-agenda-files (now includes org-roam files)
(defun my/refresh-org-agenda-files ()
  "Refresh the list of org files in org-agenda-files, including org-roam files."
  (interactive)
  (setq org-agenda-files
    	(seq-filter (lambda (file)
                 	(not (string-match-p "sync-conflict" file)))
               	(append
                	(directory-files-recursively org-directory "\\.org$")
                	(directory-files-recursively org-roam-directory "\\.org$"))))
  (message "Refreshed org-agenda-files. Found %d files." (length org-agenda-files)))

;; Increase fill column width globally
(setq-default fill-column 120)  ;; Increase from default (usually 70-80)

;; Disable auto-fill-mode in org files (prevents automatic line wrapping)
(add-hook! 'org-mode-hook
  (auto-fill-mode -1))

;; But keep visual-line-mode on for readability (this wraps at window edge without inserting newlines)
(add-hook! 'org-mode-hook
  (visual-line-mode 1))

(defun my/insert-note-link ()
  "Insert a link to another note file."
  (interactive)
  (let* ((files (directory-files-recursively my/task-notes-directory "\\.org$"))
     	(file-names (mapcar #'file-name-nondirectory files))
     	(selected (completing-read "Select note file: " file-names))
     	(full-path (car (seq-filter (lambda (f)
                                  	(string= (file-name-nondirectory f) selected))
                                	files))))
	(insert (format "[[file:%s][📝 %s]]"
               	full-path
               	(file-name-sans-extension selected)))))

;; Add a function to create index files for major areas
(defun my/create-org-roam-index (category)
  "Create or open an index file for a specific category."
  (interactive "sCategory (study/university/journal): ")
  (let* ((filename (format "%s-index.org" category))
     	(filepath (expand-file-name filename org-roam-directory))
     	(title (capitalize category)))
	(find-file filepath)
	(when (= (buffer-size) 0)
  	(insert (format "#+title: %s Index\n" title))
  	(insert (format "#+filetags: :index:%s:\n\n" category))
  	(insert "* Overview\n\n")
  	(insert "* Recent Notes\n")
  	(insert "#+begin: org-roam-backlinks :id current\n")
  	(insert "#+end:\n\n")
  	(insert "* Tasks\n")
  	(insert "#+begin: clocktable :maxlevel 2 :tags \"" category "\" :block today\n")
  	(insert "#+end:\n")
  	(save-buffer))
	(message "%s index created/opened." title)))

(map! :map org-mode-map
  	:localleader
  	:desc "Insert note link" "i n" #'my/insert-note-link)

(map! :leader
  	:desc "Open Doom dashboard"
  	"d" #'+doom-dashboard/open)

;; Add shortcuts for index files
(map! :leader
  	(:prefix ("i" . "index")
   	:desc "Study" "s" (lambda () (interactive) (my/create-org-roam-index "study"))
   	:desc "University" "u" (lambda () (interactive) (find-file "~/org-roam/Classes/university.org"))
   	:desc "Journal" "j" (lambda () (interactive) (my/create-org-roam-index "journal"))
   	:desc "Project" "p" (lambda () (interactive) (my/create-org-roam-index "projects"))
   	:desc "Reading" "r" (lambda () (interactive) (my/create-org-roam-index "reading"))))

(use-package! org-roam-ui
  :after org-roam
  :hook (org-roam-mode . org-roam-ui-mode)
  :config
  (setq org-roam-ui-open-on-start nil))  ;; Optional, disables auto-opening
;; Set transparency: (active . inactive)
(set-frame-parameter (selected-frame) 'alpha '(80 . 80))
(add-to-list 'default-frame-alist '(alpha . (80 . 80)))

;; Custom Dashboard Configuration
;; Add this to your config.el file


(after! org-pomodoro
  (setq org-pomodoro-length 45
    	org-pomodoro-short-break-length 5
    	org-pomodoro-long-break-length 15))

(after! org
  (setq org-format-latex-options (plist-put org-format-latex-options :scale 1.5))
  (setq org-startup-with-latex-preview t)) ;; auto-preview on open

(use-package! org-bullets
  :hook (org-mode . org-bullets-mode)
  :config
  (setq org-bullets-bullet-list '("◉" "○" "●" "◆" "◇" "▶")))

(defun my/org-open-link-or-move-down ()
  "In normal mode, open Org link at point if on one; otherwise, move down a line."
  (interactive)
  (if (org-in-regexp org-link-any-re)
  	(org-open-at-point)
	(evil-next-line)))  ;; this mimics evil-ret's line movement

(after! org
  (map! :map org-mode-map
    	:n "RET" #'my/org-open-link-or-move-down
    	:n [return] #'my/org-open-link-or-move-down))

(after! tex
  ;; Add latexmk as a valid command option
  (add-to-list 'TeX-command-list
           	'("LatexMk" "latexmk -pdf %s" TeX-run-TeX nil t :help "Run LatexMk"))
  ;; Make latexmk the default command
  (setq TeX-command-default "LatexMk"))

(add-to-list 'custom-theme-load-path "~/.doom.d/themes/")

(after! org
  ;; Log time in a LOGBOOK drawer
  (setq org-clock-into-drawer t
    	org-clock-out-remove-zero-time-clocks t
    	org-clock-persist 'history
    	org-log-into-drawer t
    	org-clock-idle-time 15
    	org-clock-persist-query-resume nil)

  ;; Save clock history across sessions
  (org-clock-persistence-insinuate)
)

(setq +doom-dashboard-menu-sections
  	(cl-loop for item in +doom-dashboard-menu-sections
           	if (string= (car item) "Open Documention")
           	;; Replace or add a new entry
           	collect '("Open Goals"
                     	:icon (all-the-icons-octicon "file-text" :face 'doom-dashboard-menu-title)
                     	:action (lambda () (find-file "~/org-roam/Notes/goals_2025.org")))
           	else collect item))

(after! org
  (setq org-agenda-skip-scheduled-if-done t
    	org-agenda-skip-deadline-if-done t))


;; This is an Emacs package that creates graphviz directed graphs from
;; the headings of an org file
(use-package org-mind-map
  :init
  (require 'ox-org)
  :ensure t
  ;; Uncomment the below if 'ensure-system-packages` is installed
  ;;:ensure-system-package (gvgen . graphviz)
  :config
  (setq org-mind-map-engine "dot")   	; Default. Directed Graph
  ;; (setq org-mind-map-engine "neato")  ; Undirected Spring Graph
  ;; (setq org-mind-map-engine "twopi")  ; Radial Layout
  ;; (setq org-mind-map-engine "fdp")	; Undirected Spring Force-Directed
  ;; (setq org-mind-map-engine "sfdp")   ; Multiscale version of fdp for the layout of large graphs
  ;; (setq org-mind-map-engine "twopi")  ; Radial layouts
  ;; (setq org-mind-map-engine "circo")  ; Circular Layout
  )

;; Add MacTeX binaries to PATH and exec-path in Emacs on macOS
(when (eq system-type 'darwin)
  (setenv "PATH" (concat "/Library/TeX/texbin:" (getenv "PATH")))
  (add-to-list 'exec-path "/Library/TeX/texbin"))

(after! tex
  (add-to-list 'TeX-command-list
           	'("LatexMk" "latexmk -pdf -interaction=nonstopmode -synctex=1 %s"
             	TeX-run-TeX nil t :help "Run LatexMk"))
  (setq TeX-command-default "LatexMk"))


(after! tex
  (setq TeX-engine 'xetex
    	TeX-command-extra-options "-shell-escape"))

;; Set transparency for the current frame (alpha is from 0 to 100, 100 = opaque)
(set-frame-parameter (selected-frame) 'alpha '(85 . 85)) ;; 85% opacity when active/inactive

;; Make new frames inherit this transparency setting
(add-to-list 'default-frame-alist '(alpha . (85 . 85)))

(after! org
  (dolist (face '((org-level-1 . 1.2)
                  (org-level-2 . 1.15)
                  (org-level-3 . 1.1)
                  (org-level-4 . 1.05)))
    (set-face-attribute (car face) nil :height (cdr face))))

;; Make org-open-file use Emacs for PDFs
(add-to-list 'org-file-apps '("\\.pdf\\'" . emacs))

(load-file "~/org-roam/org-agenda-dashboard.el")
