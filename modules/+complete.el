;;; +complete.el -*- lexical-binding: t; -*-
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

(use-package corfu
  :unless noninteractive
  :config
  ;; Indent with TAB first then fall back to `completion-at-point'.
  (setq-default tab-always-indent 'complete)

  ;; Enable `global-corfu-mode' after initialization.
  (add-hook 'after-init-hook #'global-corfu-mode))

(provide '+complete)

;;; +complete.el ends here
