;;; doom-vague-theme.el --- port of vague.nvim -*- lexical-binding: t; no-byte-compile: t; -*-
;;
;; Author: Niko Komninos <https://github.com/nikokomninos>
;; Maintainer: Niko Komninos <https://github.com/nikokomninos>
;; Source:
;;
;;; Commentary:
;;
;; A port of vague.nvim <https://github.com/vague-theme/vague.nvim>.
;;
;;; Code:

(require 'doom-themes)


;;
;;; Variables

(defgroup doom-vague-theme nil
  "Options for the `doom-vague' theme."
  :group 'doom-themes)

(defcustom doom-vague-brighter-modeline nil
  "If non-nil, more vivid colors will be used to style the mode-line."
  :group 'doom-vague-theme
  :type 'boolean)

(defcustom doom-vague-brighter-comments nil
  "If non-nil, comments will be highlighted in more vivid colors."
  :group 'doom-vague-theme
  :type 'boolean)

(defcustom doom-vague-comment-bg doom-vague-brighter-comments
  "If non-nil, comments will have a subtle highlight to enhance their
legibility."
  :group 'doom-vague-theme
  :type 'boolean)

(defcustom doom-vague-padded-modeline doom-themes-padded-modeline
  "If non-nil, adds a 4px padding to the mode-line.
Can be an integer to determine the exact padding."
  :group 'doom-vague-theme
  :type '(choice integer boolean))


;;
;;; Theme definition

(def-doom-theme vague
    "The vague colorscheme"

  ;; name        default   256           16
  ((bg         '("#141415" "black"       "black"  ))
   (fg         '("#cdcdcd" "#bfbfbf"     "brightwhite"  ))

   ;; These are off-color variants of bg/fg, used primarily for `solaire-mode',
   ;; but can also be useful as a basis for subtle highlights (e.g. for hl-line
   ;; or region), especially when paired with the `doom-darken', `doom-lighten',
   ;; and `doom-blend' helper functions.
   (bg-alt     '("#161617" "black"       "black"        ))
   (fg-alt     '("#cdcdcd" "#2d2d2d"     "white"        ))

   ;; These should represent a spectrum from bg to fg, where base0 is a starker
   ;; bg and base8 is a starker fg. For example, if bg is light grey and fg is
   ;; dark grey, base0 should be white and base8 should be black.
   (base0 '("#101011" "black"       "black"))         ; darker than bg (fringe, margins)
   (base1 '("#141415" "black"       "black"))         ; bg
   (base2 '("#181819" "black"       "black"))         ; bg-alt
   (base3 '("#252530" "#262626"     "brightblack"))   ; subtle highlight / hl-line
   (base4 '("#3b3b4a" "#3f3f3f"     "brightblack"))   ; delimiters, faint UI
   (base5 '("#606079" "#525252"     "brightblack"))   ; comments / dim fg
   (base6 '("#8b8ba3" "#6b6b6b"     "brightblack"))   ; secondary fg
   (base7 '("#b0b0c0" "#979797"     "brightblack"))   ; strong fg
   (base8 '("#cdcdcd" "#dfdfdf"     "white"))         ; fg


   (grey       base4)
   (red        '("#d8647e" "#ff6655" "red"          ))
   (orange     '("#e0a363" "#dd8844" "brightred"    ))
   (green      '("#7fa563" "#99bb66" "green"        ))
   (teal       '("#4db5bd" "#44b9b1" "brightgreen"  ))
   (yellow     '("#f3be7c" "#ECBE7B" "yellow"       ))
   (blue       '("#8ba9c1" "#51afef" "brightblue"   ))
   (dark-blue  '("#6e94b2" "#2257A0" "blue"         ))
   (magenta    '("#bb9dbd" "#c678dd" "brightmagenta"))
   (violet     '("#aeaed1" "#a9a1e1" "magenta"      ))
   (cyan       '("#9bb4bc" "#46D9FF" "brightcyan"   ))
   (dark-cyan  '("#405065" "#5699AF" "cyan"         ))

   ;; These are the "universal syntax classes" that doom-themes establishes.
   ;; These *must* be included in every doom themes, or your theme will throw an
   ;; error, as they are used in the base theme defined in doom-themes-base.
   (highlight      blue)
   ;;(vertical-bar   (doom-darken base1 0.1))
   (vertical-bar   (doom-darken bg 0.25))
   (selection      dark-blue)
   (builtin        "#b4d4cf")
   (comments       (if doom-vague-brighter-comments dark-cyan "#606079"))
   (doc-comments   (doom-lighten (if doom-vague-brighter-comments dark-cyan "#606079") 0.25))
   (constants      "#aeaed1")
   (functions      "#c48282")
   (keywords       "#6e94b2")
   (methods        "#c48282")
   (operators      "#90a0b5")
   (type           "#9bb4bc")
   (strings        "#e8b589")
   (variables      "#aeaed1")
   (numbers        "#e0a363")
   (region         `(,(doom-lighten (car bg-alt) 0.15) ,@(doom-lighten (cdr base1) 0.35)))
   (error          red)
   (warning        yellow)
   (success        green)
   (vc-modified    orange)
   (vc-added       green)
   (vc-deleted     red)

   ;; These are extra color variables used only in this theme; i.e. they aren't
   ;; mandatory for derived themes.
   (modeline-fg              fg)
   (modeline-fg-alt          base5)
   (modeline-bg              (if doom-vague-brighter-modeline
                                 (doom-darken blue 0.45)
                               (doom-darken bg-alt 0.2)))
   (modeline-bg-alt          (if doom-vague-brighter-modeline
                                 (doom-darken blue 0.475)
                               `(,(doom-darken (car bg-alt) 0.15) ,@(cdr bg))))
   (modeline-bg-inactive     `(,(car bg) ,@(cdr base1)))
   (modeline-bg-inactive-alt `(,(doom-darken (car bg-alt) 0.1) ,@(cdr bg)))

   (-modeline-pad
    (when doom-vague-padded-modeline
      (if (integerp doom-vague-padded-modeline) doom-vague-padded-modeline 4))))


  ;;;; Base theme face overrides
  (((line-number &override) :foreground base4)
   ((line-number-current-line &override) :foreground fg)
   ((font-lock-comment-face &override)
    :background (if doom-vague-comment-bg (doom-lighten bg 0.05) 'unspecified))
   (mode-line
    :background modeline-bg :foreground modeline-fg
    :box (if -modeline-pad `(:line-width ,-modeline-pad :color ,modeline-bg)))
   (mode-line-inactive
    :background modeline-bg-inactive :foreground modeline-fg-alt
    :box (if -modeline-pad `(:line-width ,-modeline-pad :color ,modeline-bg-inactive)))
   (mode-line-emphasis :foreground (if doom-vague-brighter-modeline base8 highlight))

   ;;;; css-mode <built-in> / scss-mode
   (css-proprietary-property :foreground orange)
   (css-property             :foreground green)
   (css-selector             :foreground blue)
   ;;;; doom-modeline
   (doom-modeline-bar :background (if doom-vague-brighter-modeline modeline-bg highlight))
   (doom-modeline-buffer-file :inherit 'mode-line-buffer-id :weight 'bold)
   (doom-modeline-buffer-path :inherit 'mode-line-emphasis :weight 'bold)
   (doom-modeline-buffer-project-root :foreground green :weight 'bold)
   ;;;; elscreen
   (elscreen-tab-other-screen-face :background "#353a42" :foreground "#1e2022")
   ;;;; ivy
   (ivy-current-match :background dark-blue :distant-foreground base0 :weight 'normal)
   ;;;; LaTeX-mode
   (font-latex-math-face :foreground green)
   ;;;; markdown-mode
   (markdown-markup-face :foreground base5)
   (markdown-header-face :inherit 'bold :foreground red)
   ((markdown-code-face &override) :background (doom-lighten base3 0.05))
   ;;;; rjsx-mode
   (rjsx-tag :foreground red)
   (rjsx-attr :foreground orange)
   ;;;; solaire-mode
   (solaire-mode-line-face
    :inherit 'mode-line
    :background modeline-bg-alt
    :box (if -modeline-pad `(:line-width ,-modeline-pad :color ,modeline-bg-alt)))
   (solaire-mode-line-inactive-face
    :inherit 'mode-line-inactive
    :background modeline-bg-inactive-alt
    :box (if -modeline-pad `(:line-width ,-modeline-pad :color ,modeline-bg-inactive-alt))))

  ;;;; Base theme variable overrides-
  ())

;;; vague-theme.el ends here
