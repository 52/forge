;;; @keymap.el --- -*- lexical-binding: t; -*-
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

;; Bind `M-n' and `M-p' for cycling through candidates.
;; This overrides the default minibuffer history navigation.
(define-key vertico-map (kbd "M-n") #'vertico-next)
(define-key vertico-map (kbd "M-p") #'vertico-previous)

;; Bind `C-n' and `C-p' for cycling through the input history.
;; This restores the default minibuffer history navigation.
(define-key vertico-map (kbd "C-n") #'next-history-element)
(define-key vertico-map (kbd "C-p") #'previous-history-element)

;; Remap built-in commands with their `consult' equivalent.
;; These remappings generally provide a superior editing experience.
(define-key global-map [remap switch-to-buffer-other-window] #'consult-buffer-other-window)
(define-key global-map [remap switch-to-buffer-other-frame] #'consult-buffer-other-frame)
(define-key global-map [remap switch-to-buffer-other-tab] #'consult-buffer-other-tab)
(define-key global-map [remap project-switch-to-buffer] #'consult-project-buffer)
(define-key global-map [remap recentf-open-files] #'consult-recent-file)
(define-key global-map [remap switch-to-buffer] #'consult-buffer)
(define-key global-map [remap bookmark-jump] #'consult-bookmark)
(define-key global-map [remap goto-line] #'consult-goto-line)

;; Additional bindings for `consult' commands.
(define-key global-map (kbd "M-s r") #'consult-ripgrep)
(define-key global-map (kbd "M-s f") #'consult-find)
(define-key global-map (kbd "M-s l") #'consult-line)

(provide '@keymap)

;;; @keymap.el ends here
