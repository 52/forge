;;; +term.el -*- lexical-binding: t; -*-
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

(use-package vterm
  :unless noninteractive
  :commands (vterm vterm-other-window)
  :config
  ;; Kill the buffer immediately when the terminal exits.
  ;; This prevents the accumulation of dead terminal buffers.
  (setq vterm-kill-buffer-on-exit t)

  ;; Reduce the delay before refreshing the buffer for updates.
  ;; This provides *way* more responsive output at higher CPU cost.
  (setq vterm-timer-delay 0.01))

(provide '+term)

;;; +term.el ends here
