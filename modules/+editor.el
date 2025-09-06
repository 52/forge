;;; +editor.el -*- lexical-binding: t; -*-
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

(use-package emacs
  :ensure nil
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

  ;; Schedule the reporting of startup statistics after startup.
  ;; This will display the total startup time and the number of GC operations.
  (add-hook 'emacs-startup-hook #'forge--report-init-time))

(use-package spacious-padding
  :ensure nil
  :demand t
  :hook (after-init . spacious-padding-mode))

(provide '+editor)

;; +editor.el ends here
