;;; +editor.el -*- lexical-binding: t; -*-
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

(use-package emacs
  :preface
  (defun forge--report-init-time ()
    "Report the total startup time and garbage collection statistics."
    (let* ((total (float-time (time-subtract (current-time) before-init-time)))
           (gcs (if (boundp 'gcs-done) gcs-done 0)))
      (message "Total startup time: %.3fs (%d GCs)" total gcs)))
  :config
  ;; Prefer spaces over hard TAB characters for indentation.
  ;; Use spaces by default in all buffers to keep diffs stable.
  (setq-default indent-tabs-mode nil)

  ;; Set the visual width of a literal TAB character.
  (setq-default tab-width 2)

  ;; Indent with TAB first then fall back to `completion-at-point'.
  (setq-default tab-always-indent 'complete)

  ;; Consider a single space sufficient to end sentences.
  (setq sentence-end-double-space nil)

  ;; Always end files with a trailing newline.
  (setq require-final-newline t)

  ;; Truncate long lines by default for performance.
  (setq-default truncate-lines t)

  ;; Wrap at word boundaries when wrapping is enabled.
  (setq-default word-wrap t)

  ;; Do not create lockfiles (".#file").
  (setq create-lockfiles nil)

  ;; Do not create backup files ("file~").
  (setq make-backup-files nil)

  ;; Do not create autosave files ("#file#").
  (setq auto-save-default nil)

  ;; Report statistics after startup.
  (add-hook 'emacs-startup-hook #'forge--report-init-time))

(use-package undo-fu
  :preface
  (define-minor-mode undo-fu-mode
    "Enables `undo-fu' for the current session."
    :init-value nil
    :global t)
  :config
  ;; Increase the soft limit to 256kB.
  (setq undo-limit 256000)

  ;; Increase the strong limit to 2MB.
  (setq undo-strong-limit 2000000)

  ;; Increase the outer limit to 36MB.
  (setq undo-outer-limit 36000000)

  ;; Remap `undo' and `redo' to `undo-fu' functions.
  (global-set-key [remap undo] #'undo-fu-only-undo)
  (global-set-key [remap redo] #'undo-fu-only-redo)

  ;; Enable `undo-fu-mode' after initialization.
  (add-hook 'after-init-hook #'undo-fu-mode))

(use-package undo-fu-session
  :config
  ;; Write undo files to "`forge-cache-directory'/undo".
  (setq undo-fu-session-directory (concat-path forge-cache-directory "undo"))

  ;; Enable `undo-fu-session' when `undo-fu-mode' is active.
  (add-hook 'undo-fu-mode-hook #'undo-fu-session-global-mode))

(use-package autorevert
  :config
  ;; Enable verbose logging when reverting buffers.
  (setq auto-revert-verbose t)
  
  ;; Do not pause reverting on user input.
  (setq auto-revert-stop-on-user-input nil)

  ;; Revert saved buffers without prompt.
  (setq revert-without-query (list "."))

  ;; Enable `global-auto-revert-mode' after initialization.
  (add-hook 'after-init-hook #'global-auto-revert-mode))

(provide '+editor)

;;; +editor.el ends here
