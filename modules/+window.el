;;; +window.el -*- lexical-binding: t; -*-
;;
;; Copyright (C) 2025 Max Karou
;;
;; Author: Max Karou <maxkarou@protonmail.com>
;; URL: https://github.com/52/forge
;;
;; Licensed under MIT License, or Apache Version 2.0, at your discretion.
;;
;; MIT License: http://opensource.org/licenses/MIT
;; Apache Version 2.0: http://www.apache.org/licenses/LICENSE-2.0
;;
;; Usage of this file is permitted solely under a sanctioned license.
;;
;;; Commentary:
;;
;;; Code:

;; Load the `hades' colorscheme.
(add-hook 'emacs-startup-hook (lambda () (load-theme 'hades t)))

;; Set the default font to `monospace 14'.
(add-hook 'emacs-startup-hook (lambda () (set-face-attribute 'default nil :family "monospace" :height 140 :weight 'light)))

(use-package spacious-padding
  :ensure nil
  :demand t
  :hook (after-init . spacious-padding-mode))

(provide '+window)

;; +window.el ends here
