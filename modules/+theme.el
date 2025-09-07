;;; +theme.el -*- lexical-binding: t; -*-
;;
;; Copyright (C) 2025 Max Karou
;;
;; Author: Max Karou <maxkarou@protonmail.com>
;; URL: https://github.com/52/forge
;;
;; SPDX-License-Identifier: MIT OR Apache-2.0
;;
;; MIT License: http://opensource.org/licenses/MIT
;; Apache Version 2.0: http://www.apache.org/licenses/LICENSE-2.0
;;
;; This project is dual-licensed under MIT License and Apache License 2.0.
;; You may use this file under either license at your discretion.
;;
;;; Commentary:
;;
;;; Code:

;; Load the `hades' colorscheme.
(add-hook 'emacs-startup-hook (lambda () (load-theme 'hades t)))

;; Set the default font to `monospace 14'.
(add-hook 'emacs-startup-hook (lambda () (set-face-attribute 'default nil :family "monospace" :height 140 :weight 'light)))

(provide '+theme)

;;; +theme.el ends here
