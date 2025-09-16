;;; @macro.el --- -*- lexical-binding: t; -*-
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

(defmacro define-lsp! (mode bin &rest args)
  "Associate LSP server BIN for MODE with optional ARGS.
Adds an entry to `eglot-server-programs' and installs `eglot-ensure'."
  `(with-eval-after-load 'eglot
     ;; Only continue if the LSP binary exists.
     (when (executable-find ,bin)
       ;; Remove any existing configuration for this mode.
       (setq eglot-server-programs (assq-delete-all ',mode eglot-server-programs))
       ;; Add the new server configuration to `eglot-server-programs'.
       (add-to-list 'eglot-server-programs '(,mode ,bin ,@args))
       ;; Setup the automatic LSP activation for this mode.
       (let ((hook-sym ',(intern (concat (symbol-name mode) "-hook"))))
         ;; Remove any existing `eglot' hook.
         (remove-hook hook-sym #'eglot-ensure)
         (remove-hook hook-sym #'eglot)
         ;; Add `eglot-ensure' to automatically start LSP.
         (add-hook hook-sym #'eglot-ensure)))))

(defmacro define-auto-mode! (mode &rest extensions)
  "Associate file EXTENSIONS with MODE.
Adds an entry to `auto-mode-alist' for each extension pattern."
  (let ((mode-sym mode))
    ;; Iterate through each extension pattern.
    `(dolist (ext ',extensions)
       ;; Add the file association to `auto-mode-alist'.
       (add-to-list 'auto-mode-alist (cons ext ',mode-sym)))))

(provide '@macro)

;;; @macro.el ends here
