;;; @editor.el -*- lexical-binding: t; -*-
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

(use-package emacs
  :preface
  (defun forge--report-init-time ()
    "Report the total startup time and garbage collection statistics."
    (let* ((total (float-time (time-subtract (current-time) before-init-time)))
           (gcs (if (boundp 'gcs-done) gcs-done 0)))
      (message "Total startup time: %.3fs (%d GCs)" total gcs)))
  :config
  ;; Do not create lockfiles (".#file").
  (setq create-lockfiles nil)

  ;; Do not create backup files ("file~").
  (setq make-backup-files nil)

  ;; Do not create autosave files ("#file#").
  (setq auto-save-default nil)

  ;; Consider a single space sufficient to end sentences.
  (setq sentence-end-double-space nil)

  ;; Always end files with a trailing newline.
  (setq require-final-newline t)

  ;; Truncate long lines by default for performance.
  (setq-default truncate-lines t)

  ;; Wrap at word boundaries when wrapping is enabled.
  (setq-default word-wrap t)

  ;; Set the visual width of a literal TAB character.
  (setq-default tab-width 2)

  ;; Prefer spaces over hard TAB characters for indentation.
  ;; Use spaces by default in all buffers to keep diffs stable.
  (setq-default indent-tabs-mode nil)

  ;; Report statistics after startup.
  (add-hook 'emacs-startup-hook #'forge--report-init-time))

(use-package undo-fu
  :preface
  (define-minor-mode undo-fu-mode
    "Enables `undo-fu' for the current session."
    :init-value nil
    :global t)
  :config
  ;; Increase the default limit (256KB).
  (setq undo-limit 256000)

  ;; Increase the strong limit (2MB).
  (setq undo-strong-limit 2000000)

  ;; Increase the outer limit (36MB).
  (setq undo-outer-limit 36000000)

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

(use-package recentf
  :config
  ;; Keep a reasonably large history (300 entries).
  (setq recentf-max-saved-items 300)

  ;; Display up to 12 items in menus.
  (setq recentf-max-menu-items 12)

  ;; Do not cleanup automatically in non-daemon sessions.
  (setq recentf-auto-cleanup (if (daemonp) 300 'never))

  ;; Exclude TRAMP and privileged paths.
  (setq recentf-exclude (list "^/\\(?:ssh\\|su\\|sudo\\)?:"))

  ;; Write recentf data to "`forge-cache-directory'/recentf".
  (setq recentf-save-file (concat-path forge-cache-directory "recentf"))

  ;; Run `recentf-cleanup' before exiting.
  (add-hook 'kill-emacs-hook #'recentf-cleanup)

  ;; Enable `recentf-mode' after initialization.
  (add-hook 'after-init-hook #'recentf-mode))

(use-package savehist
  :config
  ;; Increase the maximum history (300 entries).
  (setq history-length 300)

  ;; Write savehist files to "`forge-cache-directory'/savehist".
  (setq savehist-file (concat-path forge-cache-directory "savehist"))

  ;; Enable `savehist-mode' after initialization.
  (add-hook 'after-init-hook #'savehist-mode))

(use-package saveplace
  :config
  ;; Write saveplace data to "`forge-cache-directory'/saveplace".
  (setq save-place-file (concat-path forge-cache-directory "saveplace"))

  ;; Enable `save-place-mode' after initialization.
  (add-hook 'after-init-hook #'save-place-mode))

(use-package bookmark
  :config
  ;; Write bookmarks to "`forge-cache-directory'/bookmarks".
  (setq bookmark-default-file (concat-path forge-cache-directory "bookmarks")))

(use-package project
  :config
  ;; Write project list to "`forge-cache-directory'/projects".
  (setq project-list-file (concat-path forge-cache-directory "projects")))

(use-package dired
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

(use-package compile
  :config
  ;; Clear the default command to require explicit input.
  ;; This overwrites the generic default `make -k' command.
  (setq compile-command "")

  ;; Only stop at errors when jumping through the output.
  (setq compilation-skip-threshold 2)

  ;; Automatically follow incoming output lines.
  (setq compilation-scroll-output t)

  ;; Display context around compilation errors.
  (setq compilation-context-lines 3)

  ;; Set compilation buffers to be strictly read-only.
  ;; This prevents any accidental typing in the output buffer.
  (setq compilation-disable-input t)

  ;; Support ANSI color codes in the compilation output.
  ;; This preserves colored output from any modern tools.
  (add-hook 'compilation-filter-hook #'ansi-color-compilation-filter))

(provide '@editor)

;;; @editor.el ends here
