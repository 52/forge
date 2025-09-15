;;; @dired.el -*- lexical-binding: t; -*-
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

(use-package dired
  :unless noninteractive
  :config
  ;; Always ask when creating target directories.
  (setq dired-create-destination-dirs 'ask)

  ;; Always copy directories recursively without prompt.
  (setq dired-recursive-copies 'always)

  ;; Always delete directories recursively without prompt.
  (setq dired-recursive-deletes 'always)

  ;; Remove the free space display from `dired' headers.
  (setq dired-free-space nil)

  ;; Revert buffers when the directory changes.
  (setq dired-auto-revert-buffer 'dired-buffer-stale-p)
  
  ;; Kill the current `dired' buffer when opening another.
  ;; This prevents accumulation of unnecessary buffers.
  (setq dired-kill-when-opening-new-dired-buffer t))

(provide '@dired)

;;; @dired.el ends here
