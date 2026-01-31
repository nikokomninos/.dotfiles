;; Appearance Settings / Original DOOM Settings

(setq doom-font (font-spec :family "JetBrainsMono Nerd Font Mono" :size 13))
(after! doom-themes
  (setq doom-themes-enable-bold t
        doom-themes-enable-italic t))
(custom-set-faces!
  '(font-lock-comment-face :slant italic)
  '(font-lock-string-face :slant italic))
(setq display-line-numbers-type 'relative)
(setq doom-theme 'vague)
(setq doom-modeline-height 30)
(setq doom-modeline-major-mode-icon t)
;;(setq fancy-splash-image "~/.config/doom/emacs.png")


;; Package Requires and Initializations



;; General Hooks and Overrides

(add-hook 'doc-view-mode-hook 'pdf-tools-install)
(add-hook 'pdf-view-mode-hook 'pdf-view-midnight-minor-mode)
(remove-hook 'doom-first-input-hook #'evil-snipe-mode)
(setq-default tab-width 2)
(map! :n "C-w v" #'+evil/window-vsplit-and-follow)
(map! :n "C-w s" #'+evil/window-split-and-follow)


;; LSP

(add-hook 'java-ts-mode-hook 'lsp)
(setq corfu-auto t
      corfu-auto-delay 0.0  ; Set to 0.0 or a small value like 0.1
      corfu-auto-prefix 2)   ; Minimum prefix length for auto-completion


;; MacOS Settings

(setq default-frame-alist '((undecorated-round . t)))
(menu-bar-mode 0)


;; LaTeX Settings

(setq TeX-PDF-mode t)
(cl-pushnew "/Library/TeX/texbin" exec-path :test #'equal)
(setq +latex-viewers '(pdf-tools))
(setenv "PATH" (concat (getenv "PATH") ":/Library/TeX/texbin/"))
(setq exec-path (append exec-path '("/Library/TeX/texbin/")))


;; Org Mode Settings

(setq org-directory "~/Documents/org")
(setq org-agenda-files (list org-directory))
(setq org-agenda-custom-commands
      '(("c" "Weekly calendar + tasks + homework"
         ((agenda ""
                  ((org-agenda-span 'week)
                   (org-agenda-start-on-weekday nil)
                   (org-agenda-overriding-header "Weekly Agenda")))
          (tags-todo "task"
                     ((org-agenda-overriding-header "Tasks")))
          (tags-todo "homework"
                     ((org-agenda-overriding-header "Homework")))))))
(setq org-hide-emphasis-markers t)
(setq org-agenda-include-diary t)


;; Custom Keybindings

(map! :leader
      :desc "Fuzzy find file"
      "f z" #'fzf-find-file-in-dir)

(map! :leader
      :desc "+format:buffer"
      "b f" #'+format/buffer)
