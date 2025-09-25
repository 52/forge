;;; hades-theme.el --- -*- lexical-binding: t; -*-
;;
;; Copyright (C) 2025 Max Karou
;;
;; Author: Max Karou <maxkarou@protonmail.com>
;; URL: https://github.com/52/forge
;;
;; SPDX-License-Identifier: MIT OR Apache-2.0
;;
;; MIT License: http://opensource.org/licenses/MIT
;; Apache License 2.0: http://www.apache.org/licenses/LICENSE-2.0
;;
;; This project is dual-licensed under MIT License and Apache License 2.0.
;; You may use this file under either license at your discretion.
;;
;;; Commentary:
;;
;;; Code:

(defgroup hades nil
  "A dark theme for GNU Emacs."
  :group 'convenience)

(defgroup hades-theme nil
  "Faces and colors for the `hades-theme'."
  :group 'hades)

(defgroup hades-fonts nil
  "Font's used by the `hades-theme'."
  :group 'hades-theme)

(defgroup hades-colors nil
  "Color's used by the `hades-theme'."
  :group 'hades-theme)

(defface hades-mono
  '((t (:family "monospace" :weight light :height 140)))
  "Default monospace face."
  :group 'hades-fonts)

(defface hades-sans
  '((t (:family "sans-serif" :weight light :height 140)))
  "Default sans-serif face."
  :group 'hades-fonts)

(defcustom hades-bg "#1c1c1c"
  "Primary background color."
  :type 'color :group 'hades-colors)

(defcustom hades-fg "#dedede"
  "Primary foreground color."
  :type 'color :group 'hades-colors)

(defcustom hades-bg-alt "#262626"
  "Alternative background color."
  :type 'color :group 'hades-colors)

(defcustom hades-bg-dim "#4e4e4e"
  "Dimmed background color."
  :type 'color :group 'hades-colors)

(defcustom hades-fg-alt "#707070"
  "Alternative foreground color."
  :type 'color :group 'hades-colors)

(defcustom hades-fg-dim "#585858"
  "Dimmed foreground color."
  :type 'color :group 'hades-colors)

(defcustom hades-region "#504d49"
  "Region background color."
  :type 'color :group 'hades-colors)

(defcustom hades-highlight "#303030"
  "Highlight background color."
  :type 'color :group 'hades-colors)

(defcustom hades-red "#f62b5a"
  "Red accent color."
  :type 'color :group 'hades-colors)

(defcustom hades-blue "#5dc5f8"
  "Blue accent color."
  :type 'color :group 'hades-colors)

(defcustom hades-green "#35d450"
  "Green accent color."
  :type 'color :group 'hades-colors)

(defcustom hades-yellow "#e3c401"
  "Yellow accent color."
  :type 'color :group 'hades-colors)

(defcustom hades-orange "#f6722b"
  "Orange accent color."
  :type 'color :group 'hades-colors)

(defcustom hades-magenta "#feabf2"
  "Magenta accent color."
  :type 'color :group 'hades-colors)

;;;###autoload
(deftheme hades
  "A dark theme for GNU Emacs.")

(let* ((class '((class color) (min-colors 256))))
  (custom-theme-set-faces
   'hades
   `(default ((,class (:background ,hades-bg :foreground ,hades-fg))))

   `(default ((,class (:family ,(face-attribute 'hades-mono :family)))))
   `(default ((,class (:weight ,(face-attribute 'hades-mono :weight)))))
   `(default ((,class (:height ,(face-attribute 'hades-mono :height)))))

   `(variable-pitch ((,class (:family ,(face-attribute 'hades-sans :family)))))
   `(variable-pitch ((,class (:weight ,(face-attribute 'hades-sans :weight)))))
   `(variable-pitch ((,class (:height ,(face-attribute 'hades-sans :height)))))

   `(fixed-pitch       ((,class (:inherit default))))
   `(fixed-pitch-serif ((,class (:inherit default))))

   `(bold        ((,class (:inherit default))))
   `(italic      ((,class (:inherit default))))
   `(bold-italic ((,class (:inherit default))))

   `(cursor ((,class (:background ,hades-fg :foreground ,hades-bg))))
   `(mouse  ((,class (:background ,hades-bg :foreground ,hades-fg))))

   `(region    ((,class (:background ,hades-region :distant-foreground unspecified))))
   `(fringe    ((,class (:background ,hades-bg :foreground ,hades-fg))))
   `(highlight ((,class (:background ,hades-highlight))))

   `(shadow  ((,class (:foreground ,hades-fg-alt))))
   `(warning ((,class (:foreground ,hades-orange))))
   `(success ((,class (:foreground ,hades-green))))
   `(error   ((,class (:foreground ,hades-red))))

   ;; match

   ;; lazy-highlight
   ;; isearch
   ;; isearch-fail

   `(show-paren-match    ((,class (:background ,hades-yellow :foreground ,hades-bg))))
   `(show-paren-mismatch ((,class (:background ,hades-red  :foreground ,hades-bg))))

   `(minibuffer-prompt ((,class (:foreground ,hades-fg))))

   `(vertical-border ((,class (:foreground ,hades-bg-dim))))

   `(window-divider             ((,class (:foreground ,hades-bg-dim))))
   `(window-divider-last-pixel  ((,class (:inherit window-divider))))
   `(window-divider-first-pixel ((,class (:inherit window-divider))))

   `(tab-bar              ((,class (:background ,hades-bg-alt :foreground ,hades-fg :box (:line-width 6 :color ,hades-bg-alt)))))
   `(tab-bar-tab          ((,class (:background ,hades-bg-alt :foreground ,hades-fg :box (:line-width 6 :color ,hades-bg-alt)))))
   `(tab-bar-tab-inactive ((,class (:background ,hades-bg-dim :foreground ,hades-fg :box (:line-width 6 :color ,hades-bg-dim)))))

   `(line-number              ((,class (:background ,hades-bg :foreground ,hades-fg-dim))))
   `(line-number-major-tick   ((,class (:background ,hades-bg :foreground ,hades-fg-alt))))
   `(line-number-minor-tick   ((,class (:background ,hades-bg :foreground ,hades-fg-alt))))
   `(line-number-current-line ((,class (:inherit hl-line :foreground ,hades-fg :weight normal))))

   `(mode-line           ((,class (:background ,hades-bg-alt :foreground ,hades-fg :box (:line-width 2 :color ,hades-bg-alt)))))
   `(mode-line-inactive  ((,class (:background ,hades-bg-dim :foreground ,hades-fg :box (:line-width 2 :color ,hades-bg-dim)))))
   `(mode-line-buffer-id ((,class (:weight light))))
   `(mode-line-emphasis  ((,class (:weight light))))

   `(completions-annotations      ((,class (:foreground ,hades-fg-alt))))
   `(completions-common-part      ((,class (:foreground ,hades-fg))))
   `(completions-first-difference ((,class (:foreground ,hades-fg))))

   `(orderless-match-face-0 ((,class (:foreground ,hades-yellow  :weight medium))))
   `(orderless-match-face-1 ((,class (:foreground ,hades-magenta :weight medium))))
   `(orderless-match-face-2 ((,class (:foreground ,hades-blue    :weight medium))))
   `(orderless-match-face-3 ((,class (:foreground ,hades-orange  :weight medium))))

   `(vertico-current ((,class (:background ,hades-highlight :foreground ,hades-fg))))
   ;; vertico-group-title
   ;; vertico-group-separator
   ;; vertico-multiline

   `(corfu-current ((,class (:background ,hades-highlight :foreground ,hades-fg))))
   ;; corfu-deprecated
   ;; corfu-border
   ;; corfu-annotations
   ;; corfu-bar
   ;; corfu-default

   ;; evil-ex-search
   ;; evil-ex-info
   ;; evil-ex-lazy-highlight
   ;; evil-ex-substitute-replacement
   ;; evil-ex-commands
   ;; evil-ex-substitute-matches

   `(font-lock-bracket-face              ((,class (:foreground ,hades-fg))))
   `(font-lock-builtin-face              ((,class (:foreground ,hades-fg))))
   `(font-lock-comment-delimiter-face    ((,class (:foreground ,hades-fg))))
   `(font-lock-comment-face              ((,class (:foreground ,hades-fg))))
   `(font-lock-constant-face             ((,class (:foreground ,hades-fg))))
   `(font-lock-delimiter-face            ((,class (:foreground ,hades-fg))))
   `(font-lock-doc-face                  ((,class (:foreground ,hades-fg))))
   `(font-lock-doc-markup-face           ((,class (:foreground ,hades-fg))))
   `(font-lock-escape-face               ((,class (:foreground ,hades-fg))))
   `(font-lock-function-call-face        ((,class (:foreground ,hades-fg))))
   `(font-lock-function-name-face        ((,class (:foreground ,hades-fg))))
   `(font-lock-keyword-face              ((,class (:foreground ,hades-fg))))
   `(font-lock-misc-punctuation-face     ((,class (:foreground ,hades-fg))))
   `(font-lock-negation-char-face        ((,class (:foreground ,hades-fg))))
   `(font-lock-number-face               ((,class (:foreground ,hades-fg))))
   `(font-lock-operator-face             ((,class (:foreground ,hades-fg))))
   `(font-lock-preprocessor-face         ((,class (:foreground ,hades-fg))))
   `(font-lock-property-name-face        ((,class (:foreground ,hades-fg))))
   `(font-lock-property-use-face         ((,class (:foreground ,hades-fg))))
   `(font-lock-punctuation-face          ((,class (:foreground ,hades-fg))))
   `(font-lock-regexp-face               ((,class (:foreground ,hades-fg))))
   `(font-lock-regexp-grouping-backslash ((,class (:foreground ,hades-fg))))
   `(font-lock-regexp-grouping-construct ((,class (:foreground ,hades-fg))))
   `(font-lock-string-face               ((,class (:foreground ,hades-fg))))
   `(font-lock-type-face                 ((,class (:foreground ,hades-fg))))
   `(font-lock-variable-name-face        ((,class (:foreground ,hades-fg))))
   `(font-lock-variable-use-face         ((,class (:foreground ,hades-fg))))
   `(font-lock-warning-face              ((,class (:foreground ,hades-fg))))))

;;;###autoload
(when (and (boundp 'custom-theme-load-path) load-file-name)
  (add-to-list 'custom-theme-load-path
               (file-name-as-directory (file-name-directory load-file-name))))

(provide-theme 'hades)
(provide 'hades-theme)

;;; hades-theme.el ends here
