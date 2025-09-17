;;; @prog.el --- -*- lexical-binding: t; -*-
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

  ;; Ignore unnecessary LSP server capabilities.
  ;; These features add noise without improving the editing experience.
  (dolist (item '(:inlayHintProvider :documentHighlightProvider))
    (add-to-list 'eglot-ignored-server-capabilities item))

  ;; Don't interfere with certain features.
  (dolist (feature '(flymake))
    (add-to-list 'eglot-stay-out-of feature))

  ;; Since we tell `eglot' to not interfere with `flymake' we need to
  ;; explicitly add the `eglot-flymake-backend' to the list of available
  ;; diagnostic functions when eglot is attached to a buffer.
  (add-hook 'eglot--managed-mode-hook (lambda ()
    (add-hook 'flymake-diagnostic-functions 'eglot-flymake-backend nil t)))

  ;; Display progress only in debug mode.
  (setq eglot-report-progress forge--debug)

  (unless forge--debug
    ;; Suppress verbose event logging entirely.
    ;; This prevents `jsonrpc' from writing logs for every event.
    (fset #'jsonrpc--log-event #'ignore)

    ;; Disable the `eglot-events-buffer' completely.
    (setq eglot-events-buffer-config '(:size 0 :format short))))

(use-package eldoc
  :unless noninteractive
  :config
  ;; Reduce the delay before displaying documentation.
  (setq eldoc-idle-delay 0.1)

  ;; Don't allow ElDoc strings to resize the echo area.
  ;; This prevents the minibuffer from constantly resizing.
  (setq eldoc-echo-area-use-multiline-p nil)

  ;; Prefer the documentation buffer when visible.
  (setq eldoc-echo-area-prefer-doc-buffer t))

(use-package flymake
  :unless noninteractive
  :config
  ;; Disable any fringe or margin indicators.
  (setq flymake-fringe-indicator-position nil)
  (setq flymake-indicator-type nil)

  ;; Enable `flymake-mode' in all programming modes.
  (add-hook 'prog-mode-hook #'flymake-mode))

(use-package consult-flymake :unless noninteractive)

(provide '@prog)

;;; @prog.el ends here
