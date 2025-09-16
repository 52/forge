;;; @lsp.el -*- lexical-binding: t; -*-
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

(use-package eglot
  :unless noninteractive
  :config
  ;; Automatically shutdown when all buffers are killed.
  ;; This prevents any orphaned processes from draining resources.
  (setq eglot-autoshutdown t)

  ;; Connect servers asynchronously to avoid blocking.
  ;; This prevents any freezes during the initialization.
  (setq eglot-sync-connect nil)

  ;; Display LSP progress only in debug mode.
  (setq eglot-report-progress forge--debug)

  (unless forge--debug
    ;; Suppress verbose event logging entirely.
    ;; This prevents `jsonrpc' from writing logs for every event.
    (fset #'jsonrpc--log-event #'ignore)

    ;; Disable the `eglot-events-buffer' completely.
    (setq eglot-events-buffer-config '(:size 0 :format short))))

(provide '@lsp)

;;; @lsp.el ends here
