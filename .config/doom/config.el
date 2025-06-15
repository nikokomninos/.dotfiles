;; Appearance Settings / Original DOOM Settings

(setq doom-font (font-spec :family "JetBrainsMono Nerd Font" :size 14))
(setq display-line-numbers-type 'relative)
(setq doom-theme 'doom-tomorrow-night)
(setq doom-modeline-height 35)
(setq doom-modeline-major-mode-icon t)
(setq word-wrap t)
(setq fancy-splash-image "~/.config/doom/emacs.png")


;; Package Requires and Initializations


;; General Hooks and Overrides

(add-hook 'doc-view-mode-hook 'pdf-tools-install)
(remove-hook 'doom-first-input-hook #'evil-snipe-mode)


;; MacOS Settings

;(setq default-frame-alist '((undecorated-round . t)))
(menu-bar-mode 0)


;; LaTeX Settings

(setq TeX-PDF-mode t)
(cl-pushnew "/Library/TeX/texbin" exec-path :test #'equal)
(setq +latex-viewers '(pdf-tools))
(setenv "PATH" (concat (getenv "PATH") ":/Library/TeX/texbin/"))
(setq exec-path (append exec-path '("/Library/TeX/texbin/")))


;; Org Mode Settings

(setq org-hide-emphasis-markers t)


;; Custom Keybindings

(map! :leader
      :desc "Fuzzy find file"
      "f z" #'fzf-find-file-in-dir)
